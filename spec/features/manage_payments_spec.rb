require "spec_helper"
require "support/authentication_helper"

describe "Payment management" do
  describe "when not signed in" do
    describe "requesting index of payments" do
      it "redirects to the sign in page" do
        visit payments_path

        current_path.should eq(sign_in_path)
      end
    end
  end

  describe "when signed in" do
    describe "as admin" do
    end

    describe "without admin" do
    end
  end
end
