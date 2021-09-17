class Users::EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.save
    redirect_to my_calendar_path
  end

  def index
    @events = Event.where(user_id: current_user.id)
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
    unless @event.user == current_user
      redirect_to root_path
    end
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to my_calendar_path
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to my_calendar_path
  end

  def my_calendar
  end

  private

  def event_params
    params.require(:event).permit(:title, :body, :start_date, :end_date)
  end
end
