class HomeController < ApplicationController
  before_action :set_user, only: :user_availablity

  def user_availability
    user_available = true
    all_day_events_date = @user.events.all_day_event.pluck(:starttime).map(&:to_date)
    user_available = false if all_day_events_date.include?(params[:start_time].to_date)
    
    if user_available
      attending_events = @user.events.where('events.starttime BETWEEN ? AND ?, invitations.rsvp IN (?)', params[:start_time].to_datetime, 
        params[:end_time], [Invitation.rsvps[:yes], Invitation.rsvps[:maybe]])
      user_available = attending_events.blank?
    end
    
    render json { message: "#{@user.username} is " + "#{user_available ? '' : 'not '}" + "available during that slot!}" }, status: 200
  end

  def events
    events = Event.where('startime BETWEEN ? AND ?', params[:start_date].to_date, params[:end_date].to_date)
    render json: {events: events}, status: 200
  end

  private

  def set_user
    @user = User.find_by_id(params[:user_id])
    render json: {error: 'User no found!'}, status: 404 unless @user.present?
  end
end
