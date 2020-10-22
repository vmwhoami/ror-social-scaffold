class FriendshipsController < ApplicationController
 
  def add
   @friend = current_user.friendships.new(friend_id: params[:person_id])
    if  @friend.save
      redirect_to users_path, notice: "Friend invite sent"
    else
      redirect_to root_path, notice: "You can not befriend the user"
     end 
  end

  def accept
    @friendship = current_user.incoming_friendship_requests.find_by_user_id(params[:inviter_id])
    if @friendship.update(confirmed:true)
      redirect_to user_path(current_user)
    else
      redirect_to root_path, notice: "You can not befriend the user"
    end
  end
  
  def destroy
    @friendship = current_user.incoming_friendship_requests.find_by_user_id(params[:delete_id])
    if @friendship.destroy
      redirect_to user_path(current_user), notice: "Friend request rejected"
    else
      render user_path(current_user), notice: "Could not delete friend request"
    end
  end
  
 
end