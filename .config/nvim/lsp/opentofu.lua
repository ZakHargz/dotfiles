return {
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform", "terraform-vars", "hcl" },
  root_markers = { ".terraform", ".opentofu", ".git", "*.tf", "*.hcl" },
  settings = {
    terraformls = {
      experimentalFeatures = {
        validateOnSave = true,
        prefillRequiredFields = true,
      },
    },
  },
  single_file_support = true,
}
