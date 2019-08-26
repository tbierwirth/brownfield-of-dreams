class Github::SessionsController < ApplicationController
  def create
    current_user.add_token('github', token, uid)
    redirect_to dashboard_path
  end

  private
  def token
    request.env['omniauth.auth']['credentials']['token']
  end

  def uid
    request.env['omniauth.auth']['uid']
  end
end
