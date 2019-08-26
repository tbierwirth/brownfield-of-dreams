class Github::SessionsController < ApplicationController
  def create
    current_user.add_token('github', token, uid)
  end

  private
  def token
    request.env['omniauth.auth']['credentials']['token']
  end

  def uid
    request.env['omniauth.auth']['uid']
  end
end
