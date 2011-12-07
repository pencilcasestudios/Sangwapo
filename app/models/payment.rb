class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  validates :amount, presence: true, numericality: true
  validates :from, presence: true, cell_phone_number_format: true
  validates :listing_id, presence: true, numericality: true
  validates :method, presence: true, :unless => :is_initialised?
  validates :received_at, presence: true, :unless => :is_initialised?
  validates :state, presence: true
  validates :to, presence: { :unless => :is_initialised? }, cell_phone_number_format: true, allow_nil: true
  validates :user_id, presence: true, numericality: true
  validates :uuid, presence: { :if => :is_unlocked? }, uniqueness: true

  has_paper_trail
    
  before_create :set_payment_amount  
  
  METHODS = {
    I18n.t("models.payment.methods.airtime")      => "airtime",
    I18n.t("models.payment.methods.cash")         => "cash",
    I18n.t("models.payment.methods.cheque")       => "cheque",
    I18n.t("models.payment.methods.mobile_money") => "mobile_money",
  }

  state_machine :state, :initial => :initialised do

    event :unlock do
      transition :initialised => :unlocked
    end

    event :reconcile do
      transition :unlocked => :locked
    end
  end

  def self.generate_uuid
    `uuidgen`.strip.downcase
  end
  
  # Validation helpers
  def is_initialised?
    self.initialised?
  end

  def is_unlocked?
    self.unlocked?
  end

  def is_locked?
    self.locked?
  end

  # Triggers
  def set_payment_amount
    self.amount = self.listing.total_listing_price
  end
end
