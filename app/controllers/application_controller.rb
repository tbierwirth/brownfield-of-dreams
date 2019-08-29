class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :require_user

  add_flash_types :success

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    render file: 'public/404', status: 404 unless current_user
  end

  def four_oh_four
    raise ActionController::RoutingError.new('Not Found')
  end
end
