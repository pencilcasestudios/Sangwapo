Factory.define :user do |f|
  f.sequence(:cell_phone_number) { CellPhoneNumber.random }
  f.sequence(:email) { |n| "mutinta#{n}@example.com" }
  f.sequence(:first_name) { |n| "Name#{n}" }
  f.sequence(:role) { User::ROLES[User::ROLES.to_a[rand User::ROLES.size].first] }

  f.language Language::NAMES[I18n.t("models.language.names.eng")]
  f.password AppConfig.test_user_password
  f.time_zone "Africa/Lusaka"
end

Factory.define :listing do |f|
  f.association :user

  f.sequence(:description) { |n| "Description #{n}" }
  f.sequence(:display_for) { Listing::PERIODS[Listing::PERIODS.to_a[rand Listing::PERIODS.size].first] }
  f.sequence(:listing_code) { Listing.generate_listing_code }
  f.sequence(:listing_type) { ListingType::NAMES[ListingType::NAMES.to_a[rand ListingType::NAMES.size].first] }
  f.sequence(:panel_size) { PanelSize::NAMES[PanelSize::NAMES.to_a[rand PanelSize::NAMES.size].first] }
  f.sequence(:uuid) { Listing.generate_uuid }
end

Factory.define :payment do |f|
  f.association :user
  f.association :listing

  f.sequence(:from) { CellPhoneNumber.random }
  f.sequence(:notes) { |n| "Note #{n}" }
  f.sequence(:received_at) { Time.now }
  f.sequence(:to) { CellPhoneNumber.random }
  f.sequence(:uuid) { Payment.generate_uuid }
end
