class Event < ApplicationRecord
	belongs_to :user
	after_create :create_event_in_iterable

  def create_event_in_iterable
    iterable_service = IterableService.new
    iterable_service.create_event(user, self)
  end
end
