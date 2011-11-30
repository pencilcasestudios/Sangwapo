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
  
  has_many :payments

  PERIODS = {
    # Translation                         # Database key
    I18n.t("models.listing.periods")[1]  =>    "1",
    I18n.t("models.listing.periods")[2]  =>    "2",
    I18n.t("models.listing.periods")[3]  =>    "3",
    I18n.t("models.listing.periods")[4]  =>    "4",
    I18n.t("models.listing.periods")[5]  =>    "5",
    I18n.t("models.listing.periods")[6]  =>    "6",
    I18n.t("models.listing.periods")[7]  =>    "7",
    I18n.t("models.listing.periods")[14] =>    "14",
    I18n.t("models.listing.periods")[21] =>    "21",
    I18n.t("models.listing.periods")[28] =>    "28",
  }
  
  COST_PER_CHARACTER = 120
  COST_PER_DAY = 1000
  COST_PER_PANEL_SIZE = {
    "small" => 3000,
    "medium" => 4000,
    "large" => 5000,
  }

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
end
