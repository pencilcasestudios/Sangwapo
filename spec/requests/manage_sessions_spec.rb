require "spec_helper"
require "support/authentication_helper"

describe "Session management" do
  describe "when not signed in" do
    describe "requesting sign in" do
      it "allows sign in with valid email and credentials" do
        sign_in_with_email

        current_path.should eq(root_path)
        page.should have_content(I18n.t("controllers.sessions_controller.actions.create.success"))
      end

      it "allows sign in with valid cell_phone_number and credentials" do
        sign_in_with_cell_phone_number

        current_path.should eq(root_path)
        page.should have_content(I18n.t("controllers.sessions_controller.actions.create.success"))
      end

      it "rejects sign in with an invalid email" do
        @current_user = FactoryGirl.create(:user)  

        visit sign_in_path

        fill_in I18n.t("views.sessions._form.labels.identifier"), :with => "#{@current_user.email}-#{Time.now}" # Non-existent email address
        fill_in I18n.t("views.sessions._form.labels.password"), :with => AppConfig.test_user_password

        click_button I18n.t("views.sessions._form.buttons.submit")

        current_path.should eq(sessions_path)
        page.should have_content(I18n.t("controllers.sessions_controller.actions.create.error"))
      end

      it "rejects sign in with an invalid cell_phone_number" do
        @current_user = FactoryGirl.create(:user)  

        visit sign_in_path

        fill_in I18n.t("views.sessions._form.labels.identifier"), :with => "#{@current_user.cell_phone_number}-#{Time.now}" # Non-existent cell_phone_number
        fill_in I18n.t("views.sessions._form.labels.password"), :with => AppConfig.test_user_password

        click_button I18n.t("views.sessions._form.buttons.submit")

        current_path.should eq(sessions_path)
        page.should have_content(I18n.t("controllers.sessions_controller.actions.create.error"))
      end

      it "rejects sign in with an invalid password" do
        @current_user = FactoryGirl.create(:user)  

        visit sign_in_path

        fill_in I18n.t("views.sessions._form.labels.identifier"), :with => @current_user.email
        fill_in I18n.t("views.sessions._form.labels.password"), :with => "#{AppConfig.test_user_password}-#{Time.now}" # Incorrect password

        click_button I18n.t("views.sessions._form.buttons.submit")

        current_path.should eq(sessions_path)
        page.should have_content(I18n.t("controllers.sessions_controller.actions.create.error"))
      end

      it "rejects sign in with a blank email and password" do
        @current_user = FactoryGirl.create(:user)  

        visit sign_in_path

        # Blank: fill_in I18n.t("views.sessions._form.labels.email"), :with => @current_user.email
        # Blank: fill_in I18n.t("views.sessions._form.labels.password"), :with => "#{AppConfig.test_user_password}-#{Time.now}" # Incorrect password

        click_button I18n.t("views.sessions._form.buttons.submit")

        current_path.should eq(sessions_path)
        page.should have_content(I18n.t("controllers.sessions_controller.actions.create.error"))
      end
    end

    describe "requesting sign out" do
    end

    describe "when signed in" do
      before(:each) do
        sign_in_with_email
      end

      describe "requesting sign in" do
      end

      describe "requesting sign out" do
        it "signs the user out" do
          visit sign_out_path

          current_path.should eq(sign_in_path)
          page.should have_content(I18n.t("controllers.sessions_controller.actions.destroy.success"))
        end
      end
    end
  end
end
