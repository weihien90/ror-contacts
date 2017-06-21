module SessionsHelper
  
  # Login the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns true if the given user is current user
  def current_user?(user)
    user == current_user
  end

  # Returns the currently logged in user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Check whether the user is logged in
  def logged_in?
    !current_user.nil?
  end

  # Log out current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
