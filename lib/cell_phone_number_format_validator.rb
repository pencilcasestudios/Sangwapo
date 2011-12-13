# Zambian MTN, Airtel or Zamtel number
# Just capture the number as a person would enter it when make a call (optional leading '+')
class CellPhoneNumberFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    # Do not allow registration with application SIM numbers or non-Zambian cell phone numbers
    unless ((value =~ /^[\+]?(26)?(09)[5,6,7][\d]{7}$/) && (!CellPhoneNumber::RESTRICTED_NUMBERS.include?(value)))
      object.errors[attribute] << (options[:message] || I18n.t("validators.cell_phone_number_format.error"))
    end
  end
end
