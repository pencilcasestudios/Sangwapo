class UsersController < ApplicationController
  before_filter :sign_in_required, :except => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.role = User::ROLES[I18n.t("models.user.roles.user")]
    if @user.save
      #Emailer.registration_confirmation(@user).deliver  
      Emailer.delay.registration_confirmation(@user)
      flash[:success] = t("controllers.users_controller.actions.create.success")
      redirect_to sign_in_path
    else
      render action: "new"
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = t("controllers.users_controller.actions.update.success")
      redirect_to(account_settings_path)
    else
      render :action => "edit"
    end
  end
end
