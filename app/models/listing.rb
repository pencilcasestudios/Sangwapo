class Listing < ActiveRecord::Base
  default_scope order("id DESC")

  belongs_to :user

  has_paper_trail

  MAXIMUM_CHARACTERS_IN_A_LISTING = 140
  validates :description, presence: true, length: { :maximum => MAXIMUM_CHARACTERS_IN_A_LISTING }
  validates :display_for, presence: true, numericality: true
  validates :listing_code, presence: true, uniqueness: true
  validates :listing_type, presence: true
  validates :panel_size, presence: true
  validates :price, presence: true, numericality: true
  validates :state, presence: true
  validates :uuid, presence: true, uniqueness: true

  has_many :payments, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  COST_PER_CHARACTER = 0
  COST_PER_DAY = 799
  COST_PER_PANEL_SIZE = {
    "small"  => 0, # Text only
    "medium" => 0, # Text and one image
    "large"  => 0, # Text and three images
  }

  # Revised pricing starting 1 March 2012
  #COST_PER_CHARACTER = 19
  #COST_PER_DAY = 199
  #COST_PER_PANEL_SIZE = {
  #  "small" => 2999,
  #  "medium" => 5999,
  #  "large" => 8999,
  #}

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

    after_transition :unpublished => :clearing, do: :generate_payment

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

    event :expire do
      transition :clearing => :expired
      transition :published => :expired
      transition :review => :expired
      transition :unpublished => :expired
    end

    event :relist do
      transition :expired => :unpublished
    end

    event :archive do
      transition :expired => :archived
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
  
  def expires_at
    self.approved_at + self.display_for.days
  end

  # Count down to expiry in days
  def expiry_count_down
    if self.expires_at.present?
  		((self.expires_at - Time.now) / (60*60*24)).to_i
		end
  end
  
  def self.random_display_period
    PERIODS[PERIODS.to_a[rand PERIODS.size].first]
  end

  def self.random_type
    TYPES[TYPES.to_a[rand TYPES.size].first]
  end

  def self.random_size
    SIZES[SIZES.to_a[rand SIZES.size].first]
  end
end
