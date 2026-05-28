resource "aws_cognito_user_pool" "user_pool" {
  name = "user_pool"

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

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "user_pool_client"
  user_pool_id = aws_cognito_user_pool.user_pool.id

  # Authentication flows
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH" # Required for the hosted UI
  ]

  generate_secret = false # Set to false for client-side (web/mobile) apps
}