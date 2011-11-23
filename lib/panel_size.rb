class PanelSize < ActiveRecord::Base
  NAMES = {
    # Translation                                               # Database key
    I18n.t("models.panel_size.names.small")  =>                 "Small",
    I18n.t("models.panel_size.names.medium") =>                 "Medium",
    I18n.t("models.panel_size.names.large")  =>                 "Large",
  }
end
