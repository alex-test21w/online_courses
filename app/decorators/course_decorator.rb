class CourseDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def active_state
    object.active? ? 'Visible' : 'Invisible'
  end
end
