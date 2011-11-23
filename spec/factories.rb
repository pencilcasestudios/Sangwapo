Factory.define :user do |f|
  f.sequence(:cell_phone_number) { |n| PhoneNumber.random }
  f.sequence(:email) { |n| "mutinta#{n}@example.com" }
  f.sequence(:first_name) { |n| "Name#{n}" }

  f.language Language::NAMES[I18n.t("models.language.names.eng")]
  f.password AppConfig.test_user_password
  f.time_zone "Africa/Lusaka"
end
