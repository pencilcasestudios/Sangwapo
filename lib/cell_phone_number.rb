class CellPhoneNumber < ActiveRecord::Base
  RESTRICTED_NUMBERS = (AppConfig.application_sim_cards["airtel"].to_a + AppConfig.application_sim_cards["mtn"].to_a + AppConfig.application_sim_cards["zamtel"].to_a).flatten.uniq
  
  # Generate a random Zambian mobile carrier phone number sequence
  def self.random
    [["+26",""][rand 2],"09",["5","6","7"][rand 3],"#{'%07d' % (rand 10000000)}"].join.strip
  end
  
  # Given a Zambian cell phone number return the mobile carrier:
  # 095XXXXXXX is Zamtel
  # 096XXXXXXX is MTN
  # 097XXXXXXX is Airtel
  #
  # May need to match 011 (International code)
  def self.mobile_carrier(phone_number)
    if phone_number =~ /^[\+]?(26)?(097)/
      "airtel"
    elsif phone_number =~ /^[\+]?(26)?(096)/
      "mtn"
    elsif phone_number =~ /^[\+]?(26)?(095)/
      "zamtel"
    else
      nil
    end
  end
end
