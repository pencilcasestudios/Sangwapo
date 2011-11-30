require "spec_helper"

describe User do
  describe "presence" do
    it "fails validation with no cell_phone_number" do
      user = User.new
      user.should have(2).error_on(:cell_phone_number)
      user.errors[:cell_phone_number].should == ["can't be blank", I18n.t("validators.cell_phone_number_format.error")]
    end

    it "fails validation with no email" do
      user = User.new
      user.should have(2).error_on(:email)
      user.errors[:email].should == ["can't be blank", "is not formatted properly"]
    end

    it "fails validation with no first_name" do
      user = User.new
      user.should have(1).error_on(:first_name)
      user.errors[:first_name].should == ["can't be blank"]
    end

    it "fails validation with no language" do
      user = User.new
      user.should have(1).error_on(:language)
      user.errors[:language].should == ["can't be blank"]
    end

    it "fails validation with no role" do
      user = User.new(role: nil)
      user.should have(1).error_on(:role)
      user.errors[:role].should == ["can't be blank"]
    end

    it "fails validation with no time_zone" do
      user = User.new
      user.should have(1).error_on(:time_zone)
      user.errors[:time_zone].should == ["can't be blank"]
    end
  end

  describe "uniqueness" do
    it "fails validation with a duplicate cell_phone_number" do
      user = Factory(:user)
      duplicate = User.new(cell_phone_number: user.cell_phone_number)
      duplicate.should have(1).error_on(:cell_phone_number)
      duplicate.errors[:cell_phone_number].should == ["has already been taken"]
    end

    it "fails validation with a duplicate email" do
      user = Factory(:user)
      duplicate = User.new(email: user.email)
      duplicate.should have(1).error_on(:email)
      duplicate.errors[:email].should == ["has already been taken"]
    end
  end

  describe "format" do
    it "fails validation with an incorrect format for email" do
      user = User.new(email: "email-without-at-symbol")
      user.should have(1).error_on(:email)
      user.errors[:email].should == ["is not formatted properly"]
    end

    it "fails validation with an incorrect format for cell_phone_number" do
      user = User.new(cell_phone_number: "some ridiculously formatted cell phone number")
      user.should have(1).error_on(:cell_phone_number)
      user.errors[:cell_phone_number].should == [I18n.t("validators.cell_phone_number_format.error")]
    end
  end
end
