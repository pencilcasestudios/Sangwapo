class Emailer < ActionMailer::Base
  def registration_confirmation(user)
    @user = user
    mail(to: "#{user.first_name} <#{user.email}>", subject: t("mailers.emailer.registration_confirmation.subject", application_name: t("application.name")), from: "#{t("application.name")} <#{AppConfig.email_user_name}>")
  end

  def payment_received_confirmation(payment)
    @payment = payment
    mail(to: "#{payment.user.first_name} <#{payment.user.email}>", subject: t("mailers.emailer.payment_received_confirmation.subject", application_name: t("application.name")), from: "#{t("application.name")} <#{AppConfig.email_user_name}>")
  end
end
