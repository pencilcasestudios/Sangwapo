source "http://rubygems.org"




# Our foundation
gem "rails"#, "3.1.3"




# Used accross environments
#gem "rails-backbone"
#gem "recaptcha", "~> 0.3.1"
#gem "ruby-graphviz", :require => "graphviz" # Optional: only required with state_machine for graphing
#gem "simple_captcha", "~> 0.1.3"
gem "bcrypt-ruby"#, "~> 3.0.0"
gem "bundler"
gem "cancan"
gem "carrierwave" #, git: "git://github.com/jnicklas/carrierwave.git"
gem "carrierwave_backgrounder"
gem "daemons"
gem "delayed_job_active_record"#, "~> 0.2.1"
gem "exception_notification"
gem "galetahub-simple_captcha", require: "simple_captcha", git: "git://github.com/galetahub/simple-captcha.git"
gem "jquery-rails"
gem "meta-tags", require: "meta_tags"
gem "nested_form", git: "git://github.com/ryanb/nested_form.git"
gem "paper_trail"
gem "prawn_rails"
gem "rake"
gem "rvm"
gem "settingslogic"
gem "sqlite3"
gem "state_machine"
gem "tinder"
gem "twitter"




# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "coffee-rails"#, "~> 3.1.1"
  gem "jombo"
  gem "sass-rails"#,   "~> 3.1.4"
  gem "uglifier"#, ">= 1.0.3"
end




group :test, :development do
  gem "rspec-rails"
end

group :test, :darwin do
  gem "rb-fsevent-legacy" # PowerPC
  gem "rb-readline"
end

group :test do
  gem "capybara"
  gem "factory_girl_rails"
  gem "guard-bundler"
  gem "guard-rspec"
  gem "guard-spork"
  gem "launchy" # Ref: http://techiferous.com/2010/04/using-capybara-in-rails-3/ for save_and_open_page to work
  gem "rack_session_access"
  gem "spork-rails"
end




group :development do
  gem "capistrano"
  gem "capistrano-campfire"
  gem "capistrano-ext"
  gem "letter_opener"
  gem "rvm-capistrano"
end




group :production do
  #gem "unicorn"
  gem "mysql2"
end
