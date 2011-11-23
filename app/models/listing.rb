class Listing < ActiveRecord::Base
  belongs_to :user

  has_paper_trail

  validates :description, :presence => true
end
