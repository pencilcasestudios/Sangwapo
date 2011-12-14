class ListingExpirationJob < Struct.new(:listing_id)
  def perform
    listing = Listing.find(listing_id)
    listing.expire
  end
end
