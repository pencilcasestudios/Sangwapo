class PaymentsController < ApplicationController
  before_filter :sign_in_required
  before_filter :admin_required

  def new
  end

  def edit
  end

  def index
  end

  def show
  end

end
