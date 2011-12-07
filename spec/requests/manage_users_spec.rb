require "spec_helper"
require "support/authentication_helper"

describe "User management" do
  describe "when not signed in" do
    # users#new
    describe "requesting sign up" do
      it "allows sign up with acceptable input" do
        Delayed::Worker.delay_jobs = false 
        #expected_delayed_jobs = Delayed::Job.count + 1

        visit sign_up_path

        first_name = "Monde"
        fill_in I18n.t("views.users._form.labels.first_name"), with: first_name

        email = "monde@example.com"
        fill_in I18n.t("views.users._form.labels.email"), with: email

        cell_phone_number = CellPhoneNumber.random
        fill_in I18n.t("views.users._form.labels.cell_phone_number"), with: cell_phone_number

        password = "password"
        fill_in I18n.t("views.users._form.labels.password"), with: password
        fill_in I18n.t("views.users._form.labels.password_confirmation"), with: password

        select I18n.t("models.language.names.eng"), from: I18n.t("views.users._form.labels.language")
        select "(GMT+02:00) Africa/Lusaka", from: I18n.t("views.users._form.labels.time_zone")

        check I18n.t("views.users._form.labels.terms_of_use")

        click_button I18n.t("helpers.submit.user.create")

        current_path.should eq(sign_in_path)
        page.should have_content(I18n.t("controllers.users_controller.actions.create.success"))

        last_email.to.should include(email)
        last_email.subject.should eq(I18n.t("mailers.emailer.registration_confirmation.subject", application_name: I18n.t("application.name")))
        #expected_delayed_jobs.should eq(Delayed::Job.count)
      end

      it "rejects sign up with missing email" do
        visit sign_up_path

        # Not filled in: fill_in I18n.t("views.users._form.labels.email"), with: "monde@example.com"

        cell_phone_number = CellPhoneNumber.random
        fill_in I18n.t("views.users._form.labels.cell_phone_number"), with: cell_phone_number

        password = "password"
        fill_in I18n.t("views.users._form.labels.password"), with: password
        fill_in I18n.t("views.users._form.labels.password_confirmation"), with: password

        select I18n.t("models.language.names.eng"), from: I18n.t("views.users._form.labels.language")
        select "(GMT+02:00) Africa/Lusaka", from: I18n.t("views.users._form.labels.time_zone")

        check I18n.t("views.users._form.labels.terms_of_use")

        click_button I18n.t("helpers.submit.user.create")

        current_path.should eq(users_path)
        page.should have_content("#{I18n.t("views.users._errors.fields.email")} can't be blank")
      end

      it "rejects sign up with missing cell_phone_number" do
        visit sign_up_path

        fill_in I18n.t("views.users._form.labels.email"), with: "monde@example.com"

        cell_phone_number = CellPhoneNumber.random
        # Not filled in: fill_in I18n.t("views.users._form.labels.cell_phone_number"), with: cell_phone_number

        password = "password"
        fill_in I18n.t("views.users._form.labels.password"), with: password
        fill_in I18n.t("views.users._form.labels.password_confirmation"), with: password

        select I18n.t("models.language.names.eng"), from: I18n.t("views.users._form.labels.language")
        select "(GMT+02:00) Africa/Lusaka", from: I18n.t("views.users._form.labels.time_zone")

        check I18n.t("views.users._form.labels.terms_of_use")

        click_button I18n.t("helpers.submit.user.create")

        current_path.should eq(users_path)
        page.should have_content("#{I18n.t("views.users._errors.fields.cell_phone_number")} can't be blank")
      end

      it "rejects sign up with missing password" do
        visit sign_up_path

        fill_in I18n.t("views.users._form.labels.email"), with: "monde@example.com"

        cell_phone_number = CellPhoneNumber.random
        fill_in I18n.t("views.users._form.labels.cell_phone_number"), with: cell_phone_number

        password = "password"
        # Not filled in: fill_in I18n.t("views.users._form.labels.password"), with: password
        fill_in I18n.t("views.users._form.labels.password_confirmation"), with: password

        select I18n.t("models.language.names.eng"), from: I18n.t("views.users._form.labels.language")
        select "(GMT+02:00) Africa/Lusaka", from: I18n.t("views.users._form.labels.time_zone")

        check I18n.t("views.users._form.labels.terms_of_use")

        click_button I18n.t("helpers.submit.user.create")

        current_path.should eq(users_path)
        page.should have_content("#{I18n.t("views.users._errors.fields.password")} doesn't match confirmation")
      end

      it "rejects sign up with missing password_confirmation" do
        visit sign_up_path

        fill_in I18n.t("views.users._form.labels.email"), with: "monde@example.com"

        cell_phone_number = CellPhoneNumber.random
        fill_in I18n.t("views.users._form.labels.cell_phone_number"), with: cell_phone_number

        password = "password"
        fill_in I18n.t("views.users._form.labels.password"), with: password
        #Not filled in: fill_in I18n.t("views.users._form.labels.password_confirmation"), with: password

        select I18n.t("models.language.names.eng"), from: I18n.t("views.users._form.labels.language")
        select "(GMT+02:00) Africa/Lusaka", from: I18n.t("views.users._form.labels.time_zone")

        check I18n.t("views.users._form.labels.terms_of_use")

        click_button I18n.t("helpers.submit.user.create")

        current_path.should eq(users_path)
        page.should have_content("#{I18n.t("views.users._errors.fields.password")} doesn't match confirmation")
      end

      it "rejects sign up with missmatched password and password_confirmation" do
        visit sign_up_path

        fill_in I18n.t("views.users._form.labels.email"), with: "monde@example.com"

        cell_phone_number = CellPhoneNumber.random
        fill_in I18n.t("views.users._form.labels.cell_phone_number"), with: cell_phone_number

        fill_in I18n.t("views.users._form.labels.password"), with: "mbelele"
        fill_in I18n.t("views.users._form.labels.password_confirmation"), with: "ifinkubala"

        select I18n.t("models.language.names.eng"), from: I18n.t("views.users._form.labels.language")
        select "(GMT+02:00) Africa/Lusaka", from: I18n.t("views.users._form.labels.time_zone")

        check I18n.t("views.users._form.labels.terms_of_use")

        click_button I18n.t("helpers.submit.user.create")

        current_path.should eq(users_path)
        page.should have_content("#{I18n.t("views.users._errors.fields.password")} doesn't match confirmation")
      end

      it "rejects sign up without acceptance of terms_of_use" do
        visit sign_up_path

        fill_in I18n.t("views.users._form.labels.email"), with: "monde@example.com"

        cell_phone_number = CellPhoneNumber.random
        fill_in I18n.t("views.users._form.labels.cell_phone_number"), with: cell_phone_number

        password = "password"
        fill_in I18n.t("views.users._form.labels.password"), with: password
        fill_in I18n.t("views.users._form.labels.password_confirmation"), with: password

        select I18n.t("models.language.names.eng"), from: I18n.t("views.users._form.labels.language")
        select "(GMT+02:00) Africa/Lusaka", from: I18n.t("views.users._form.labels.time_zone")

        # Not filled in: check I18n.t("views.users._form.labels.terms_of_use")

        click_button I18n.t("helpers.submit.user.create")

        current_path.should eq(users_path)
        page.should have_content("#{I18n.t("views.users._errors.fields.terms_of_use")} must be accepted")
      end
    end

    describe "requesting edit user account" do
      it "should ask the user to sign in first" do
        visit account_settings_path

        current_path.should eq(sign_in_path)
        page.should have_content(I18n.t("controllers.application_controller.flash.sign_in_required"))
      end
    end
  end

  describe "when signed in" do
    before(:each) do
      sign_in_with_email
    end

    describe "requesting sign up" do
    end

    describe "requesting edit user account" do
      it "allows the user to edit their email" do
        visit account_settings_path

        updated_field = "monde#{Time.now.strftime("%s")}@example.com"
        fill_in I18n.t("views.users._form.labels.email"), with: updated_field

        click_button I18n.t("helpers.submit.user.update")

        current_path.should eq(account_settings_path)
        page.should have_content(I18n.t("controllers.users_controller.actions.update.success"))
        find_field(I18n.t("views.users._form.labels.email")).value.should eq(updated_field)
      end

      it "allows the user to edit their cell_phone_number" do
        visit account_settings_path

        updated_field = CellPhoneNumber.random
        fill_in I18n.t("views.users._form.labels.cell_phone_number"), with: updated_field

        click_button I18n.t("helpers.submit.user.update")

        current_path.should eq(account_settings_path)
        page.should have_content(I18n.t("controllers.users_controller.actions.update.success"))
        find_field(I18n.t("views.users._form.labels.cell_phone_number")).value.should eq(updated_field)
      end

      # TODO - Update password
      # TODO - Update language
      # TODO - Update time zone
    end
  end
end
