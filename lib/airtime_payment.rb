class AirtimePayment < ActiveRecord::Base
  # Select the phone number to which airtime payment will be sent
  def self.receiving_number(carrier)
    AppConfig.application_sim_cards[carrier][rand(AppConfig.application_sim_cards[carrier].size)]
  end
end
