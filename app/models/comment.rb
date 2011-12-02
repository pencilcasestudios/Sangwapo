class Comment < ActiveRecord::Base
  belongs_to :user

  has_paper_trail

  validates :body, presence: true
end
