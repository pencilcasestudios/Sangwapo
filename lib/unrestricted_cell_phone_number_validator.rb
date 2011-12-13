# Do not allow registration with numbers registered to this application
class UnrestrictedCellPhoneNumberValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if (CellPhoneNumber::RESTRICTED_NUMBERS.include?(value))
      object.errors[attribute] << (options[:message] || I18n.t("validators.unrestricted_cell_phone_number.error"))
    end
  end
end
