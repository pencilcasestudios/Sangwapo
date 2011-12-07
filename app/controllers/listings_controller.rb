class ListingsController < ApplicationController
  before_filter :sign_in_required, :except => [:index, :show]
  before_filter :admin_required, :only => [:review, :accept, :reject]

  def index
    @listings = Listing.where("state='published'").order("id DESC")
  end
  
  def show
    if user_signed_in?
      @listing = Listing.find(params[:id])
      if @listing.published?
        # Do nothing and render this listing
      else
        @listing = current_user.listings.find(params[:id]) # Which will not be found
      end
    else
      @listing = Listing.where("state='published'").find(params[:id])
    end
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
    @listing = current_user.listings.find(params[:id])
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
    @listings = current_user.listings
  end

  def review
    @listings = Listing.find_all_by_state("review")
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
  
  def accept
    @listing = Listing.find(params[:id])
    @listing.update_attribute("approved_at", Time.now)
    @listing.accept
    
    Emailer.listing_approved_confirmation(@listing).deliver  
    #Emailer.delay.listing_approved_confirmation(@listing)
    flash[:success] = t("controllers.listings_controller.actions.accept.success", id: @listing.id)
    redirect_to review_listings_path
  end

  def reject
    @listing = Listing.find(params[:id])
    @listing.reject
    @listing.comments.new(label: "administrator_comment", body: t("controllers.listings_controller.actions.reject.comment", listing: @listing.description, date: @listing.updated_at.strftime("%A, %d %B %Y, %H:%M:%S"), rejected_at: Time.now.strftime("%A, %d %B %Y, %H:%M"), refund_percentage: AppConfig.refund_percentage, to: @listing.user.cell_phone_number)).save
    flash[:success] = t("controllers.listings_controller.actions.reject.success", id: @listing.id, refund_percentage: AppConfig.refund_percentage)
    redirect_to review_listings_path
  end
end
