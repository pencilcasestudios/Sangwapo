class Emailer < ActionMailer::Base
  def registration_confirmation(user)
    @user = user
    mail(to: user.email, subject: t("mailers.emailer.registration_confirmation.subject", application_name: t("application.name")), from: "#{t("application.name")} <#{AppConfig.email_user_name}>")
  end
end
