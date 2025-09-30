function fish_prompt_aws --description 'Show current AWS profile in prompt'
    if set -q AWS_PROFILE
        set_color yellow
        echo -n "[$AWS_PROFILE]"
        set_color normal
        echo -n " "
    end
end

