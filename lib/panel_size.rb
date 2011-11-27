class PanelSize < ActiveRecord::Base
  NAMES = {
    # Translation                                               # Database key
    I18n.t("models.panel_size.names.small")  =>                 "small",
    I18n.t("models.panel_size.names.medium") =>                 "medium",
    I18n.t("models.panel_size.names.large")  =>                 "large",
  }
end
