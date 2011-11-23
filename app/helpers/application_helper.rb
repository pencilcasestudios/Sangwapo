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

  def title(page_title)
    content_for(:title) { page_title }
  end

  def sub_title(sub_title)
    content_for(:sub_title) do
      content_tag :small do
        sub_title
      end
    end
  end
end
