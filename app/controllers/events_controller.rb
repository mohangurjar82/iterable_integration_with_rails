class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.all
  end

  def create_event_a
    create_event('Event A')
  end

  def create_event_b
    create_event('Event B')
  end

  private

  def create_event(event_type)
	  event_name = params[:name]
	  if current_user.events.create(name: event_name, event_type: event_type)
	    flash[:notice] = "#{event_name} created successfully!"
	  else
	    flash[:alert] = "Something went wrong"
	  end
	  redirect_to root_path
  end
end
