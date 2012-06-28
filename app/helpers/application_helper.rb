module ApplicationHelper
  def body_id
    controller.controller_name
  end

  def new_or_create_action?
    (controller.action_name == "new") || (controller.action_name == "create")
  end

  def edit_or_update_action?
    (controller.action_name == "edit") || (controller.action_name == "update")
  end

  # Ref: https://github.com/kpumuk/meta-tags
  def default_meta_tags
    {
      description: t("application.meta_tags.description"),
      keywords: t("application.meta_tags.keywords"),
      prefix: " ",
      reverse: true,
      site: t("application.name"),
      title: t("application.tagline"),
      open_graph: {
        description: t("application.meta_tags.description"),
        image: root_url + asset_path("logo-400x400.png"),
        title: t("application.tagline"),
        type: :website,
        url: root_url,
      }
    }
  end
end
