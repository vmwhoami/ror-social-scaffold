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
  has_many :incoming_invitations, class_name:"Friendship", foreign_key: "friend_id"

   #These are the friendships
  has_many :incoming_friendship_requests,->{where confirmed: false},class_name:"Friendship", foreign_key: "friend_id"
    #These are the users
  has_many :pending_friends, through: :incoming_friendship_requests, source: :user

  #These are the friendships
  has_many :confirmed_initiated_friendships,->{where confirmed: true},class_name:"Friendship", foreign_key: "user_id"
  #These are the users
  has_many :initiated_friends, through: :confirmed_initiated_friendships, source: :user
 

  
  #These are the friendships
  has_many :confirmed_accepted_friendships,->{where confirmed: true},class_name:"Friendship", foreign_key: "friend_id"
  #These are the users
  has_many :confirmed_friends, through: :confirmed_accepted_friendships, source: :user
 
 def friends
       initiated_friends +  confirmed_friends
 end


end
