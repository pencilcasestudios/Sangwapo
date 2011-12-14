class ListingsController < ApplicationController
  before_filter :sign_in_required, :except => [:index, :show]
  before_filter :admin_required, :only => [:review, :accept, :reject]

  def index
    @listings = Listing.where("state='published'")
  end
  
  def show
    @listing = Listing.where("state!='archived'").find(params[:id])
  end
  
  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(params[:listing])
    @listing.uuid = Listing.generate_uuid
    @listing.listing_code = Listing.generate_listing_code
    if @listing.save
      flash[:success] = t("controllers.listings_controller.actions.create.success")
      redirect_to @listing
    else
      render action: "new"
    end
  end

  def edit
    @listing = current_user.listings.where("state!='archived'").find(params[:id])
    unless @listing.unpublished?
      # Editing is only allowed on unpublished listings
      flash[:error] = t("controllers.listings_controller.actions.edit.error")
      redirect_to @listing
    end
  end

  def update
    @listing = current_user.listings.find(params[:id])
    if @listing.update_attributes(params[:listing])
      flash[:success] = t("controllers.listings_controller.actions.update.success")
      redirect_to(@listing)
    else
      render :action => "edit"
    end
  end

  def mine
    @listings = current_user.listings.where("state!='archived'")
  end

  def review
    @listings = Listing.find_all_by_state("review")
  end

  def relist
    @listing = current_user.listings.find(params[:id])
    if @listing.relist
      flash[:success] = t("controllers.listings_controller.actions.relist.success")
      redirect_to @listing
    else
      # Do nothing
    end
  end
  
  def pay
    @listing = current_user.listings.find(params[:id])
    if @listing.pay
      flash[:success] = t("controllers.listings_controller.actions.pay.success")
      redirect_to @listing
    else
      # Do nothing
    end
  end
  
  def accept
    @listing = Listing.find(params[:id])
    @listing.update_attribute("approved_at", Time.now)
    @listing.accept
    
    #Emailer.listing_approved_confirmation(@listing).deliver  
    Emailer.delay.listing_approved_confirmation(@listing)
    
    # Schedule the listing to expire
    Delayed::Job.enqueue(ListingExpirationJob.new(params[:id]), -3, 2.minutes.from_now)

    flash[:success] = t("controllers.listings_controller.actions.accept.success", id: @listing.id)
    redirect_to review_listings_path
  end

  def reject
    @listing = Listing.find(params[:id])
    @listing.reject
    @listing.comments.new(label: "administrator_comment", body: t("controllers.listings_controller.actions.reject.comment", listing: @listing.description, date: @listing.updated_at.strftime("%A, %d %B %Y, %H:%M:%S"), rejected_at: Time.now.strftime("%A, %d %B %Y, %H:%M"), refund_percentage: AppConfig.refund_percentage, to: @listing.user.cell_phone_number)).save

    #Emailer.listing_rejected_confirmation(@listing).deliver  
    Emailer.delay.listing_rejected_confirmation(@listing)

    flash[:success] = t("controllers.listings_controller.actions.reject.success", id: @listing.id, refund_percentage: AppConfig.refund_percentage)
    redirect_to review_listings_path
  end

  # Permanently archive this listing
  def destroy
    @listing = current_user.listings.find(params[:id])
    if @listing.archive
      flash[:success] = t("controllers.listings_controller.actions.destroy.success")
    else
      flash[:error] = t("controllers.listings_controller.actions.destroy.error")
    end
    redirect_to mine_listings_path
  end
end
