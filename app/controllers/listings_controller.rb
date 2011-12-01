class ListingsController < ApplicationController
  before_filter :sign_in_required, :except => [:index, :show]

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
  end

  def create
    @listing = current_user.listings.new(params[:listing])
    if @listing.save
      flash[:success] = t("controllers.listings_controller.actions.create.success")
      redirect_to @listing
    else
      render action: "new"
    end
  end

  def edit
    @listing = current_user.listings.find_by_id(params[:id])
    if @listing.blank?
      flash[:error] = t("controllers.listings_controller.actions.edit.failure")
      redirect_to root_path
    end
  end

  def update
    @listing = current_user.listings.find_by_id(params[:id])
    if @listing.update_attributes(params[:listing])
      flash[:success] = t("controllers.listings_controller.actions.update.success")
      redirect_to(@listing)
    else
      render :action => "edit"
    end
  end

  def mine
    @listings = current_user.listings
  end
  
  def pay
    @listing = current_user.listings.find_by_id(params[:id])
    if @listing.blank?
      flash[:error] = t("controllers.listings_controller.actions.pay.failure")
      redirect_to root_path
    else
      @listing.pay
      flash[:success] = t("controllers.listings_controller.actions.pay.success")
      redirect_to @listing
    end
  end
end
