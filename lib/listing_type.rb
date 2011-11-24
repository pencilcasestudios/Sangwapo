class ListingType < ActiveRecord::Base
  NAMES = {
    # Translation                                     # Database key
    I18n.t("models.listing_type.names.offered") =>    "offered",
    I18n.t("models.listing_type.names.wanted")  =>    "wanted",
  }
end
