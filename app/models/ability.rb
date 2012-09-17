class Ability
  include CanCan::Ability

  def initialize(user)
    # guest user (not logged in)
    user ||= User.new

    # Administrators
    if user.admin?
      can :manage, :all
    else
      can :read, :all
    end
    
    # Application users
    can :manage, User, id: user.id

    # Listings
    can :manage, Listing, user_id: user.id
  end
end
