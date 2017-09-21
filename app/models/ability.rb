class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role?(:trainer)
      can :manage, User
    else
      can %i[read update destroy], User
    end

    can :manage, Course do |course|
      user.subscription_in?(course) || user.id == course.user_id
    end

    can :manage, Homework do |homework|
      user.id == homework.lesson.course.user_id || user.id == homework.user_id
    end

    can :manage, Comment do |comment|
      user.id == comment.user_id
    end
  end
end
