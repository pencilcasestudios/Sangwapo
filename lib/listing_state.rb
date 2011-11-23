class ListingState < ActiveRecord::Base
  NAMES = {
    # Translation                                          # Database key
    I18n.t("models.listing_state.names.unpublished") =>    "unpublished",
    I18n.t("models.listing_state.names.approved")    =>    "approved",
    I18n.t("models.listing_state.names.published")   =>    "published",
  }
end
