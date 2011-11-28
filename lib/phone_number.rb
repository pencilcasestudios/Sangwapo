class PhoneNumber < ActiveRecord::Base
  # Generate a correctly-formatted, random, 10-digit phone number sequence
  def self.random
    [["+",""][rand 2],"#{'%010d' % (rand 1000000000000)}"].join.strip
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
