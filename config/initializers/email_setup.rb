ActionMailer::Base.smtp_settings = {
  address:              AppConfig.email_address,
  authentication:       "plain",
  domain:               AppConfig.email_domain,
  enable_starttls_auto: AppConfig.email_enable_starttls_auto,
  password:             AppConfig.email_password,
  port:                 AppConfig.email_port,
  user_name:            AppConfig.email_user_name,
}

ActionMailer::Base.default_url_options[:host] = AppConfig.application_server_name
