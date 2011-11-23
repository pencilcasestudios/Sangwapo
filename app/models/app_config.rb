# Application configuration wish Settingslogic
# Ref: https://github.com/binarylogic/settingslogic
class AppConfig < Settingslogic
  source "#{Rails.root}/config/config.yml"
  namespace Rails.env
end
