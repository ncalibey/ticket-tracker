class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= user_for_session(session[:user_id])
  end

  helper_method :current_user

  def require_session
    unless current_user
      redirect_back alert: "You must be logged in to do that.",
        fallback_location: root_path
    end
  end

  def user_for_session(user_id)
    User.find(user_id) if user_id
  end

  def sign_in(user)
    session[:user_id] = user.id
  end
end
