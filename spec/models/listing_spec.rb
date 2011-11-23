require "spec_helper"

describe Listing do
  describe "presence" do
    it "fails validation with no description" do
      listing = Listing.new
      listing.should have(1).error_on(:description)
      listing.errors[:description].should == ["can't be blank"]
    end
  end

  describe "uniqueness" do
  end

  describe "format" do
  end
end
