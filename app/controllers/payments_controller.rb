class PaymentsController < ApplicationController
  before_filter :sign_in_required
  before_filter :admin_required

  def index
    @payments = Payment.all
  end

  def show
  end

  def edit
    @payment = Payment.find(params[:id])
  end
  
  def update
    @payment = Payment.find(params[:id])
    @payment.uuid = Payment.generate_uuid
    if @payment.update_attributes(params[:payment])
      @payment.reconcile
      @payment.listing.clear
      flash[:success] = t("controllers.payments_controller.actions.update.success", id: @payment.id)
      redirect_to pending_payments_path
    else
      render :action => "edit"
    end
  end

  def pending
    @payments = Payment.find_all_by_state("open")
  end
end
