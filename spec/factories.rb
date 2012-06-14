FactoryGirl.define do
  factory :user do
    sequence(:cell_phone_number) { CellPhoneNumber.random }
    sequence(:email) { |n| "email#{n}@example.com" }
    sequence(:first_name) { |n| "First Name#{n}" }
    sequence(:role) { User.random_role }

    language Language.random_name
    password AppConfig.test_user_password
    time_zone "Africa/Lusaka"
  end
  
  factory :listing do
    association :user
  
    sequence(:description) { |n| "Description #{n}" }
    sequence(:display_for) { Listing.random_display_period }
    sequence(:listing_code) { Listing.generate_listing_code }
    sequence(:listing_type) { Listing.random_type }
    sequence(:panel_size) { Listing.random_size }
    sequence(:uuid) { Listing.generate_uuid }
  end
  
  factory :payment do
    association :user
    association :listing
  
    sequence(:from) { CellPhoneNumber.random }
    sequence(:method) {  Payment.random_payment_method }
    sequence(:notes) { |n| "Note #{n}" }
    sequence(:received_at) { Time.now }
    sequence(:to) { CellPhoneNumber.random }
    sequence(:uuid) { Payment.generate_uuid }
  end
end
