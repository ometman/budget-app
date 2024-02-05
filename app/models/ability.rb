# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here.
    user ||= User.new # Guest user (not logged in)

    if user.admin?
      can :manage, :all # Admin can manage all resources
    else
      can :read, :all # Default permission for non-admin users is read-only
      can :manage, Deal, author_id: user.id # User can manage their own deals
      can :manage, Category, user_id: user.id # User can manage their own categories
    end
  end
end
