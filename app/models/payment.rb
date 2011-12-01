class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  validates :from, presence: true, :cell_phone_number_format => true
  validates :received_at, presence: true
  validates :state, presence: true
  validates :to, presence: true, :cell_phone_number_format => true
  validates :uuid, presence: true, uniqueness: true

  has_paper_trail

  state_machine :state, :initial => :open do
  end

  def self.generate_uuid
    `uuidgen`.strip.downcase
  end
end
