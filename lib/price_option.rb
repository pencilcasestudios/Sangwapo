class PriceOption < ActiveRecord::Base
  NAMES = {
    # Translation                                                      # Database key
    I18n.t("models.panel_option.names.free")          =>                 "Free",
    I18n.t("models.panel_option.names.negotiable")    =>                 "Negotiable",
    I18n.t("models.panel_option.names.or_best_offer") =>                 "or Best Offer",
  }
end
