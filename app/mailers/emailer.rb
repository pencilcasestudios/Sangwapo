class Emailer < ActionMailer::Base
  default from: "#{I18n.t("application.name")} <#{AppConfig.email_from_address}>"

  def registration_confirmation(user)
    @user = user
    mail(to: "#{user.first_name} <#{user.email}>", subject: t("mailers.emailer.registration_confirmation.subject", application_name: t("application.name")))
  end

  def payment_received_confirmation(payment)
    @payment = payment
    mail(to: "#{payment.user.first_name} <#{payment.user.email}>", subject: t("mailers.emailer.payment_received_confirmation.subject", application_name: t("application.name")))
  end

  def listing_approved_confirmation(listing)
    @listing = listing
    mail(to: "#{listing.user.first_name} <#{listing.user.email}>", subject: t("mailers.emailer.listing_approved_confirmation.subject", application_name: t("application.name")))
  end

  def listing_rejected_confirmation(listing)
    @listing = listing
    mail(to: "#{listing.user.first_name} <#{listing.user.email}>", subject: t("mailers.emailer.listing_rejected_confirmation.subject", application_name: t("application.name")))
  end

  def expired_listing_notification(listing)
    @listing = listing
    mail(to: "#{listing.user.first_name} <#{listing.user.email}>", subject: t("mailers.emailer.expired_listing_notification.subject", application_name: t("application.name")))
  end
end
