require "spec_helper"

describe Comment do
  describe "presence" do
    it "fails validation with no body" do
      comment = Comment.new
      comment.should have(1).error_on(:body)
      comment.errors[:body].should == ["can't be blank"]
    end
  end
end
