class InviteController < ApplicationController
  def new

  end

  def create
    if get_recipient[:email]
      sender = get_sender
      recipient = get_recipient[:login]
      email = get_recipient[:email]
      InviteMailer.invite(sender, recipient, email).deliver_now
      flash[:notice] = "Invite sent!"
      redirect_to dashboard_path
    else
      flash[:notice] = "User does not exist or does not have a public email"
      render :new
    end
  end

  private
  def github_handle
    params[:github_handle]
  end

  def get_sender
    service = GithubService.new(current_user.github_token)
    service.get_current_user
  end

  def get_recipient
    service = GithubService.new(current_user.github_token)
    service.get_user(github_handle)
  end

  def invite_params

  end
end
