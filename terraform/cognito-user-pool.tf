resource "aws_cognito_user_pool" "pool" {
  name = "my-user-pool"

  # Allows users to use their email as their username
  username_attributes = ["email"]

  # Configure password complexity
  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  # Auto-verify email addresses
  auto_verified_attributes = ["email"]
}

