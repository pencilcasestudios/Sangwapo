class Listing < ActiveRecord::Base
  default_scope order("id DESC")

  belongs_to :user

  has_paper_trail

  validates :description, presence: true
  validates :listing_code, presence: true, uniqueness: true
  validates :listing_type, presence: true
  validates :panel_size, presence: true
  validates :price, presence: true, numericality: true
  validates :state, presence: true
  validates :uuid, presence: true, uniqueness: true
  
  def self.generate_listing_code
    Time.now.strftime("L%Y-%m-%d-%s")
  end

  def self.generate_uuid
    `uuidgen`.strip.downcase
  end
end
