class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = 'Friend added'
      redirect_to dashboard_path
    else
      flash[:notice] = 'Unable to add friend'
      redirect_to dashboard_path
    end
  end
end
