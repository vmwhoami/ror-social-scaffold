class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :invitations, class_name:"Friendship", foreign_key: "friend_id"



 def friends
  (invitations.select{|f| f.confirmed == true}) + (friendships.select{|f| f.confirmed == true})
 end
  
 def incoming_friend_requests
  invitations.select{|f| f.confirmed == false}
 end
 
 def outgoing_friend_requests
  friendships.select{|f| f.confirmed == false}
 end

 def befriend(user)
  friend = incoming_friend_requests.find{|f| f.user == user}
  friend.confirmed = true
  friend.save!
  
 end
 

end
