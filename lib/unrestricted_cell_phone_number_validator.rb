# Do not allow a User to create an account with a number to this application
class UnrestrictedCellPhoneNumberValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if (value && CellPhoneNumber::RESTRICTED_NUMBERS.include?(value.gsub(/^[\+]?(26)?/, ""))) # Strip the leading "+" or "+26"
      object.errors[attribute] << (options[:message] || I18n.t("validators.unrestricted_cell_phone_number.error"))
    end
  end
end
