class ClockEventsController < ApplicationController
  before_action :handle_login, only: %i(clock_in clock_out)

  # GET /clock_events
  def index
    @clock_events = ClockEvent.includes(:user).latest.page(params[:page])
  end

  # POST /clock_in
  def clock_in
    @clock_event = @user.clock_events.new(clock_in_at: Time.current)

    if !clock_in_params[:clock_in_again] && @user.clock_events.latest.first&.clocked_in?
      return redirect_to root_path, { 
        danger: "You're already clocked in. Please confirm that you want to clock in again.",
        data: { is_clocked_in_already: true },
      }
    end

    if @clock_event.save
      redirect_to root_path, success: "You're clocked in."
    else
      redirect_to root_path, danger: "Error creating Clock Event."
    end
  end

  # PATCH/PUT /clock_out
  def clock_out
    @clock_event = @user.clock_events.latest.first

    if @clock_event&.clocked_in? && @clock_event&.update(clock_out_at: Time.current)
      redirect_to root_path, success: "You've been clocked out."
    else
      message = @clock_event&.clocked_in? ? 
        "Error updating Clock Event." :
        "The last Clock Event has already been clocked out."
      redirect_to root_path, danger: message
    end
  end

  private
  
    def handle_login
      @user = User.find_by(email: clock_in_params[:email].downcase)
      unless @user&.authenticate(clock_in_params[:password])
        redirect_to root_path, danger: "Invalid login credentials."
      end
    end

    def clock_in_params
      params.permit(:email, :password, :clock_in_again)
    end
end
