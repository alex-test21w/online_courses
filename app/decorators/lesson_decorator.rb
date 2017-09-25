class LessonDecorator < Draper::Decorator
  delegate :current_page, :per_page, :offset, :total_entries, :total_pages
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def start_date
    object.start_date.strftime('%d.%m.%Y')
  end
end
