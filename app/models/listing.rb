class Listing < ActiveRecord::Base
  default_scope order("id DESC")

  belongs_to :user

  has_paper_trail

  validates :description, presence: true
  validates :display_for, presence: true, numericality: true
  validates :listing_code, presence: true, uniqueness: true
  validates :listing_type, presence: true
  validates :panel_size, presence: true
  validates :price, presence: true, numericality: true
  validates :state, presence: true
  validates :uuid, presence: true, uniqueness: true

  has_many :payments, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  COST_PER_CHARACTER = 120
  COST_PER_DAY = 1000
  COST_PER_PANEL_SIZE = {
    "small" => 3000,
    "medium" => 4000,
    "large" => 5000,
  }

  PERIODS = {
    #I18n.t("models.listing.periods")[1]  =>    "1",
    #I18n.t("models.listing.periods")[2]  =>    "2",
    #I18n.t("models.listing.periods")[3]  =>    "3",
    #I18n.t("models.listing.periods")[4]  =>    "4",
    #I18n.t("models.listing.periods")[5]  =>    "5",
    #I18n.t("models.listing.periods")[6]  =>    "6",
    I18n.t("models.listing.periods")[7]  =>    "7",
    I18n.t("models.listing.periods")[14] =>    "14",
    I18n.t("models.listing.periods")[21] =>    "21",
    I18n.t("models.listing.periods")[28] =>    "28",
  }

  SIZES = {
    I18n.t("models.listing.sizes.small")  =>  "small",
    #I18n.t("models.listing.sizes.medium") =>  "medium",
    #I18n.t("models.listing.sizes.large")  =>  "large",
  }

  TYPES = {
    I18n.t("models.listing.types.offered") =>    "offered",
    I18n.t("models.listing.types.wanted")  =>    "wanted",
  }

  state_machine :state, :initial => :unpublished do

    after_transition :unpublished => :clearing, :do => :generate_payment

    event :pay do
      transition :unpublished => :clearing
    end

    event :clear do
      transition :clearing => :review
    end

    event :reject do
      transition :review => :unpublished
    end

    event :accept do
      transition :review => :published
    end

    event :archive do
      transition :published => :archived
    end
  end


  def generate_payment
    p = self.payments.new(from: self.user.cell_phone_number, amount: self.total_listing_price, user: self.user)

    # Force-save this payment in an invalidated, unlocked state
    p.unlock(false)
    p.save(validate: false) 
  end

  def self.generate_listing_code
    Time.now.strftime("L%Y-%m-%d-%H%M%S-%L")
  end

  def self.generate_uuid
    `uuidgen`.strip.downcase
  end

  def total_character_price
    self.description.size * COST_PER_CHARACTER
  end

  def total_daily_price
    self.display_for * COST_PER_DAY
  end

  def total_panel_price
    COST_PER_PANEL_SIZE[self.panel_size]
  end

  def total_listing_price
     total_character_price + total_daily_price + total_panel_price
  end

  def is_published?
    self.state == "published"
  end
  
  def belongs_to?(owner)
    self.user == owner
  end
end
