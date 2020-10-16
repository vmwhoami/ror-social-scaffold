class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"


    # Users who have yet to confirme friend requests
    def pending_friends
      friendships.map{|friendship| friendship.friend if !friendship.confirmed}.compact
    end
end 