if AppConfig.email_delivery_mode == "virtual" # Deliver using postfix on the virtual machine
	ActionMailer::Base.smtp_settings = {
		openssl_verify_mode:		AppConfig.email_openssl_verify_mode,
	}
else
	ActionMailer::Base.smtp_settings = {
		address:              	AppConfig.email_address,
		authentication:       	AppConfig.email_authentication,
		domain:               	AppConfig.email_domain,
		enable_starttls_auto: 	AppConfig.email_enable_starttls_auto,
		openssl_verify_mode:		AppConfig.email_openssl_verify_mode,
		password:             	AppConfig.email_password,
		port:                 	AppConfig.email_port,
		user_name:            	AppConfig.email_user_name,
	}
end

ActionMailer::Base.default_url_options[:host] = AppConfig.application_server_name
