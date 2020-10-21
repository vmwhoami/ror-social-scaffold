class FriendshipsController < ApplicationController
 
  def add
 
   @friend = current_user.friendships.new(friend_id: params[:person_id])
    if  @friend.save
      redirect_to users_path, notice: "Friend added succesfully"
    else
      redirect_to root_path, notice: "You can not befriend the user"
     end 
  end
 
end