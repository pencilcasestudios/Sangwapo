class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  validates :from, presence: true, cell_phone_number_format: true
  validates :received_at, presence: true, :if => :payment_closed?
  validates :state, presence: true
  validates :to, presence: { :if => :payment_closed? }, cell_phone_number_format: true, allow_nil: true
  validates :uuid, presence: { :if => :payment_closed? }, uniqueness: true

  has_paper_trail
  
  state_machine :state, :initial => :open do
    event :reconcile do
      transition :open => :closed
    end
  end

  def self.generate_uuid
    `uuidgen`.strip.downcase
  end
  
  def payment_closed?
    self.closed?
  end
end
