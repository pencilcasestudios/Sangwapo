Factory.define :user do |f|
  f.sequence(:cell_phone_number) { |n| PhoneNumber.random }
  f.sequence(:email) { |n| "mutinta#{n}@example.com" }
  f.sequence(:first_name) { |n| "Name#{n}" }

  f.language Language::NAMES[I18n.t("models.language.names.eng")]
  f.password AppConfig.test_user_password
  f.time_zone "Africa/Lusaka"
end

Factory.define :listing do |f|
  f.association :user
  
  f.sequence(:description) { |n| "Description #{n}" }
  f.sequence(:listing_code) { Listing.generate_listing_code }
  f.sequence(:panel_size) { PanelSize::NAMES[PanelSize::NAMES.to_a[rand PanelSize::NAMES.size].first] }  
  f.sequence(:uuid) { Listing.generate_uuid }

  f.state I18n.t("models.listing_state.names.unpublished")
end
