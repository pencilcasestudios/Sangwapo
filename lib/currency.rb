class Currency < ActiveRecord::Base
  CODES = {
    # Translation                                                             # Database key
    I18n.t("models.currency.codes.zmk")                =>                     "zmk",
    I18n.t("models.currency.codes.usd")                =>                     "usd",
    I18n.t("models.currency.codes.cad")                =>                     "cad",
    I18n.t("models.currency.codes.gbp")                =>                     "gbp",
    I18n.t("models.currency.codes.eur")                =>                     "eur",
  }
end
