FactoryGirl.define do
  factory :user do
    sequence(:cell_phone_number) { CellPhoneNumber.random }
    sequence(:email) { |n| "email#{n}@example.com" }
    sequence(:first_name) { |n| "First Name#{n}" }
    sequence(:role) { User::ROLES[User::ROLES.to_a[rand User::ROLES.size].first] }

    language Language::NAMES[I18n.t("models.language.names.eng")]
    password AppConfig.test_user_password
    time_zone "Africa/Lusaka"
  end
  
  factory :listing do
    association :user
  
    sequence(:description) { |n| "Description #{n}" }
    sequence(:display_for) { Listing::PERIODS[Listing::PERIODS.to_a[rand Listing::PERIODS.size].first] }
    sequence(:listing_code) { Listing.generate_listing_code }
    sequence(:listing_type) { Listing::TYPES[Listing::TYPES.to_a[rand Listing::TYPES.size].first] }
    sequence(:panel_size) { Listing::SIZES[Listing::SIZES.to_a[rand Listing::SIZES.size].first] }
    sequence(:uuid) { Listing.generate_uuid }
  end
  
  factory :payment do
    association :user
    association :listing
  
    sequence(:from) { CellPhoneNumber.random }
    sequence(:method) {  Payment::METHODS[Payment::METHODS.to_a[rand Payment::METHODS.size].first] }
    sequence(:notes) { |n| "Note #{n}" }
    sequence(:received_at) { Time.now }
    sequence(:to) { CellPhoneNumber.random }
    sequence(:uuid) { Payment.generate_uuid }
  end
end
