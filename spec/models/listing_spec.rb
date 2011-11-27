require "spec_helper"

describe Listing do
  describe "presence" do
    it "fails validation with no description" do
      listing = Listing.new
      listing.should have(1).error_on(:description)
      listing.errors[:description].should == ["can't be blank"]
    end

    it "fails validation with no display_for" do
      listing = Listing.new(display_for: nil)
      listing.should have(2).error_on(:display_for)
      listing.errors[:display_for].should == ["can't be blank", "is not a number"]
    end

    it "fails validation with no price" do
      listing = Listing.new(price: nil)
      listing.should have(2).error_on(:price)
      listing.errors[:price].should == ["can't be blank", "is not a number"]
    end

    it "fails validation with no listing_code" do
      listing = Listing.new
      listing.should have(1).error_on(:listing_code)
      listing.errors[:listing_code].should == ["can't be blank"]
    end

    it "fails validation with no panel_size" do
      listing = Listing.new
      listing.should have(1).error_on(:panel_size)
      listing.errors[:panel_size].should == ["can't be blank"]
    end

    it "fails validation with no listing_type" do
      listing = Listing.new
      listing.should have(1).error_on(:listing_type)
      listing.errors[:listing_type].should == ["can't be blank"]
    end

    it "fails validation with no state" do
      listing = Listing.new
      listing.should have(1).error_on(:state)
      listing.errors[:state].should == ["can't be blank"]
    end

    it "fails validation with no uuid" do
      listing = Listing.new
      listing.should have(1).error_on(:uuid)
      listing.errors[:uuid].should == ["can't be blank"]
    end
  end

  describe "format" do
    it "fails validation if price is not a number" do
      listing = Listing.new(price: "Something that is not a number")
      listing.should have(1).error_on(:price)
      listing.errors[:price].should == ["is not a number"]
    end
  end

  describe "uniqueness" do
    it "fails validation with a duplicate uuid" do
      listing = Factory(:listing)
      duplicate = Listing.new(uuid: listing.uuid)
      duplicate.should have(1).error_on(:uuid)
      duplicate.errors[:uuid].should == ["has already been taken"]
    end

    it "fails validation with a duplicate listing_code" do
      listing = Factory(:listing)
      duplicate = Listing.new(listing_code: listing.listing_code)
      duplicate.should have(1).error_on(:listing_code)
      duplicate.errors[:listing_code].should == ["has already been taken"]
    end
  end
end
