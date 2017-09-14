class ActivityDecorator < Draper::Decorator
  delegate_all

  def partial_name
    object.trackable_type.underscore
  end

  def username
    "#{object.owner.first_name} #{object.owner.last_name}"
  end
end
