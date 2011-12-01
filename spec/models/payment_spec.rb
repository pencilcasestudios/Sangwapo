require "spec_helper"

describe Payment do
  describe "when payment is open" do
    describe "presence" do
      it "fails validation with no from" do
        payment = Payment.new(from: nil)
        payment.state.should == "open"
        payment.should have(2).error_on(:from)
        payment.errors[:from].should == ["can't be blank", I18n.t("validators.cell_phone_number_format.error")]
      end

      it "validates with no to" do
        payment = Payment.new(to: nil)
        payment.state.should == "open"
        payment.should have(0).error_on(:to)
        payment.errors[:to].should == []
      end

      it "validates with no received_at" do
        payment = Payment.new(received_at: nil)
        payment.state.should == "open"
        payment.should have(0).error_on(:received_at)
        payment.errors[:received_at].should == []
      end

      it "fails validation with no state" do
        payment = Payment.new(state: nil)
        payment.state.should == nil
        payment.should have(2).error_on(:state)
        payment.errors[:state].should == ["can't be blank", "is invalid"]
      end

      it "validates with no uuid" do
        payment = Payment.new(uuid: nil)
        payment.state.should == "open"
        payment.should have(0).error_on(:uuid)
        payment.errors[:uuid].should == []
      end
    end

    describe "format" do
      it "fails when from is incorrectly formatted (not a cell phone number)" do
        payment = Payment.new(from: "Something that is not a valid cell phone number")
        payment.state.should == "open"
        payment.should have(1).error_on(:from)
        payment.errors[:from].should == ["is not a Zambian cell phone number"]
      end

      it "fails when from is incorrectly formatted (not a Zambian cell phone number)" do
        payment = Payment.new(from: "0987654321")
        payment.state.should == "open"
        payment.should have(1).error_on(:from)
        payment.errors[:from].should == ["is not a Zambian cell phone number"]
      end

      it "fails when to is incorrectly formatted (not a cell phone number)" do
        payment = Payment.new(to: "Something that is not a valid cell phone number")
        payment.state.should == "open"
        payment.should have(1).error_on(:to)
        payment.errors[:to].should == ["is not a Zambian cell phone number"]
      end

      it "fails when to is incorrectly formatted (not a Zambian cell phone number)" do
        payment = Payment.new(to: "0987654321")
        payment.state.should == "open"
        payment.should have(1).error_on(:to)
        payment.errors[:to].should == ["is not a Zambian cell phone number"]
      end
    end

    describe "uniqueness" do
      it "fails validation with a duplicate uuid" do
        payment = Factory(:payment)
        payment.state.should == "open"
        duplicate = Payment.new(uuid: payment.uuid)
        duplicate.state.should == "open"        
        duplicate.should have(1).error_on(:uuid)
        duplicate.errors[:uuid].should == ["has already been taken"]
      end
    end
  end

  describe "when payment is closed" do
  end
end
