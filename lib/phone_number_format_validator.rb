# Just capture the number as a person would enter it when make a call (optional leading '+')
class PhoneNumberFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value =~ /^[\+]?[\d]{4,}$/
      object.errors[attribute] << (options[:message] || "is not formatted properly")
    end
  end
end
