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
  
  PERIODS = {
    # Translation                                            # Database key
    I18n.t("models.listing.periods.one_day")           =>    "1",
    I18n.t("models.listing.periods.two_days")          =>    "2",
    I18n.t("models.listing.periods.three_days")        =>    "3",
    I18n.t("models.listing.periods.four_days")         =>    "4",
    I18n.t("models.listing.periods.five_days")         =>    "5",
    I18n.t("models.listing.periods.six_days")          =>    "6",
    I18n.t("models.listing.periods.seven_days")        =>    "7",
    I18n.t("models.listing.periods.fourteen_days")     =>    "14",
    I18n.t("models.listing.periods.twenty_one_days")   =>    "21",
    I18n.t("models.listing.periods.twenty_eight_days") =>    "28",
  }
  
  COST_PER_CHARACTER = 200
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
  
  def total_listing_cost
    (self.description.size * COST_PER_CHARACTER) + (self.display_for * COST_PER_DAY) + COST_PER_PANEL_SIZE[self.panel_size]
  end
  
  def published?
    self.state == "published"
  end
end
