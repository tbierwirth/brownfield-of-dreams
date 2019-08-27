class ActivationController < ApplicationController
  def update
    user = User.find_by(activation_code: params[:code])
    if user
      user.activate
      redirect_to activated_path
    else
      flash[:notice] = "Code is invalid"
      redirect_to root_path
    end
  end

  def show

  end
end
