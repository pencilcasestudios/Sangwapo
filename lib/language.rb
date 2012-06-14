class Language < ActiveRecord::Base
  NAMES = {
    # Translation                                                         # Database key. Ref: http://www.loc.gov/standards/iso639-2/php/code_list.php
    I18n.t("models.language.names.eng")                =>                 "English",
  }
  
  def self.random_name
    NAMES[I18n.t("models.language.names.eng")]
  end
end
