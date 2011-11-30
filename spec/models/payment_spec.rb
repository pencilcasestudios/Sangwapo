require "spec_helper"

describe Payment do
  describe "presence" do
    it "fails validation with no from" do
      payment = Payment.new(from: nil)
      payment.should have(2).error_on(:from)
      payment.errors[:from].should == ["can't be blank", I18n.t("validators.cell_phone_number_format.error")]
    end

    it "fails validation with no to" do
      payment = Payment.new(to: nil)
      payment.should have(2).error_on(:to)
      payment.errors[:to].should == ["can't be blank", I18n.t("validators.cell_phone_number_format.error")]
    end

    it "fails validation with no received_at" do
      payment = Payment.new(received_at: nil)
      payment.should have(1).error_on(:received_at)
      payment.errors[:received_at].should == ["can't be blank"]
    end

    it "fails validation with no uuid" do
      payment = Payment.new(uuid: nil)
      payment.should have(1).error_on(:uuid)
      payment.errors[:uuid].should == ["can't be blank"]
    end
  end

  describe "format" do
    describe "fails validation if to" do
      it "is not in Zambian cell phone number format" do
        payment = Payment.new(to: "Something that is not a Zambian cell phone number")
        payment.should have(1).error_on(:to)
        payment.errors[:to].should == [I18n.t("validators.cell_phone_number_format.error")]
      end
    end

    describe "fails validation if from" do
      it "is not in Zambian cell phone number format" do
        payment = Payment.new(from: "Something that is not a Zambian cell phone number")
        payment.should have(1).error_on(:from)
        payment.errors[:from].should == [I18n.t("validators.cell_phone_number_format.error")]
      end
    end
  end

  describe "uniqueness" do
    it "fails validation with a duplicate uuid" do
      payment = Factory(:payment)
      duplicate = Payment.new(uuid: payment.uuid)
      duplicate.should have(1).error_on(:uuid)
      duplicate.errors[:uuid].should == ["has already been taken"]
    end
  end
end
