class ListingsController < ApplicationController
  before_filter :sign_in_required, :except => [:index]

  def index
    @listings = Listing.all
  end
  
  def show
    @listing = Listing.find(params[:id])
  end
  
  def new
    @listing = Listing.new
    @listing.listing_code = Listing.generate_listing_code
    @listing.uuid = Listing.generate_uuid
    @listing.state = ListingState::NAMES[t("models.listing_state.names.unpublished")]
  end

  def create
    @listing = Listing.new(params[:listing])
    @listing.user = current_user
    if @listing.save
      flash[:success] = t("controllers.listings_controller.actions.create.success")
      redirect_to @listing
    else
      render action: "new"
    end
  end
end
