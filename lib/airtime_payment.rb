class AirtimePayment < ActiveRecord::Base
  # Select the phone number to which airtime payment will be sent
  def self.random_receiving_number(carrier)
    AppConfig.application_sim_cards[carrier][AppConfig.application_sim_cards[carrier].to_a[rand(AppConfig.application_sim_cards[carrier].to_a.size)].first]
  end

  def self.available_receiving_numbers(carrier)
    AppConfig.application_sim_cards[carrier]
  end
end
