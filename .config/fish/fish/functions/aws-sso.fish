function aws-sso --description 'AWS SSO login and credential export'
    # Define our colors using Fish's built-in color command
    # Using set_color ensures compatibility with the Fish terminal
    set -l reset (set_color normal)
    set -l bold (set_color --bold)
    set -l dim (set_color --dim)
    set -l green (set_color green)
    set -l blue (set_color blue)
    set -l yellow (set_color yellow)
    set -l red (set_color red)
    set -l cyan (set_color cyan)

    # Handle profile argument
    set -l profile "default"
    if test (count $argv) -gt 0
        set profile $argv
    end

    # Show a nice header when starting the process
    echo $bold"🔒 Initiating AWS SSO Login Process"$reset
    echo $dim"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"$reset

    # Perform SSO login
    if not aws sso login --profile $profile
        echo $red"❌ SSO login failed"$reset
        return 1
    end

    # Get the SSO session information with status updates
    echo $dim"📂 Locating SSO cache directory..."$reset
    set -l sso_cache_dir ~/.aws/sso/cache
    set -l token_file (find $sso_cache_dir -name "*.json" -type f -exec ls -t {} + 2>/dev/null | head -1)
    if test -z "$token_file"
        echo $red"❌ No SSO token file found. Please run 'aws sso login' first"$reset
        return 1
    end

    # Extract the access token and other necessary information
    echo $dim"🔑 Extracting SSO token information..."$reset
    set -l access_token (jq -r '.accessToken' $token_file)
    set -l sso_region (jq -r '.region' $token_file)

    # Get account ID and role name from AWS config
    set -l account_id (aws configure get sso_account_id --profile $profile)
    set -l role_name (aws configure get sso_role_name --profile $profile)
    if test -z "$account_id" -o -z "$role_name"
        echo $red"❌ Could not find account ID or role name in AWS config"$reset
        return 1
    end

    # Use the access token to get temporary credentials
    echo $dim"🔄 Fetching temporary AWS credentials..."$reset
    set -l role_creds (aws sso get-role-credentials \
        --profile $profile \
        --account-id $account_id \
        --role-name $role_name \
        --access-token $access_token \
        --region $sso_region \
        --no-cli-pager)
    if test $status -ne 0
        echo $red"❌ Failed to get role credentials"$reset
        return 1
    end

    # Extract and export the actual AWS credentials
    set -gx AWS_ACCESS_KEY_ID (echo $role_creds | jq -r '.roleCredentials.accessKeyId')
    set -gx AWS_SECRET_ACCESS_KEY (echo $role_creds | jq -r '.roleCredentials.secretAccessKey')
    set -gx AWS_SESSION_TOKEN (echo $role_creds | jq -r '.roleCredentials.sessionToken')
    set -gx AWS_REGION $sso_region
    set -gx AWS_PROFILE $profile

    # Show a success message with nicely formatted information
    echo $dim"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"$reset
    echo $green"✅ AWS Credentials Successfully Exported!"$reset
    echo
    echo $bold"Profile Details:"$reset
    echo $cyan"▸ Profile:    "$reset$yellow$profile$reset
    echo $cyan"▸ Account ID: "$reset$yellow$account_id$reset
    echo $cyan"▸ Role:       "$reset$yellow$role_name$reset
    echo $cyan"▸ Region:     "$reset$yellow$sso_region$reset

    # Show expiration time with a warning if it's less than 1 hour away
    set -l expiration (echo $role_creds | jq -r '.roleCredentials.expiration')
    set -l expiration_formatted (date -j -f "%s" $expiration "+%Y-%m-%d %H:%M:%S")
    echo $cyan"▸ Expires:    "$reset$yellow$expiration_formatted$reset
    echo $dim"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"$reset
    echo $dim"🔔 Tip: Run 'aws sts get-caller-identity' to verify credentials"$reset
end
