def sign_in_with_email
  @current_user = Factory(:user)  

  visit sign_in_path

  fill_in I18n.t("views.sessions._form.labels.identifier"), :with => @current_user.email
  fill_in I18n.t("views.sessions._form.labels.password"), :with => AppConfig.test_user_password

  click_button I18n.t("views.sessions._form.buttons.submit")
  page.should have_content(I18n.t("views.application._navigation.links.sign_out"))
  page.should have_content(@current_user.first_name)
end

def sign_in_with_cell_phone_number
  @current_user = Factory(:user)  

  visit sign_in_path

  fill_in I18n.t("views.sessions._form.labels.identifier"), :with => @current_user.cell_phone_number
  fill_in I18n.t("views.sessions._form.labels.password"), :with => AppConfig.test_user_password

  click_button I18n.t("views.sessions._form.buttons.submit")
  page.should have_content(I18n.t("views.application._navigation.links.sign_out"))
  page.should have_content(@current_user.first_name)
end
