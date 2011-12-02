require "spec_helper"
require "support/authentication_helper"

describe "Listing management" do
  describe "when not signed in" do
    describe "requesting index of listings" do
      it "displays the listings index" do
        visit root_path

        current_path.should eq(root_path)
      end
    end
    
    describe "requesting to create a new listing" do
      it "asks the user to sign in first" do
        visit new_listing_path
        
        current_path.should eq(sign_in_path)
        page.should have_content(I18n.t("controllers.application_controller.flash.sign_in_required"))
      end
    end
  end

  describe "when signed in" do
    before(:each) do
      sign_in_with_email
    end

    describe "requesting index of listings" do
      it "displays the listings index" do
        visit root_path

        current_path.should eq(root_path)
      end
    end
    
    describe "requesting to create a new listing" do
      it "creates an offer listing on a small panel when acceptable data is given" do
        visit new_listing_path

        select I18n.t("models.listing.types.offered"), from: I18n.t("views.listings._form.labels.listing_type")

        select I18n.t("models.listing.sizes.small"), from: I18n.t("views.listings._form.labels.panel_size")

        lorem = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        fill_in I18n.t("views.listings._form.labels.description"), with: lorem

        click_button I18n.t("helpers.submit.create", :model => "Listing")

        page.should have_content(I18n.t("controllers.listings_controller.actions.create.success"))
        page.should have_content(lorem)
      end
    end
  end
end
