class UsersController < ApplicationController
  def show
    render locals: {
      github_facade: GithubFacade.new(current_user.github_token),
      bookmark_facade: BookmarkFacade.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      AccountActivationMailer.activate(user).deliver_now
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
