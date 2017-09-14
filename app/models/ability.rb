class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role?(:trainer)
      can :manage, User
    else
      can [:read, :update, :destroy], User
    end

    can :manage, Course do |course|
      user.subscription_in?(course)
    end
  end
end
