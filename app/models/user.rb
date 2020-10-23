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
  has_many :incoming_invitations, class_name: 'Friendship', foreign_key: 'friend_id'

  # These are the friendships
  has_many :incoming_friendship_requests, -> { where confirmed: false },
           class_name: 'Friendship', foreign_key: 'friend_id'
  # These are the users
  has_many :pending_friends, through: :incoming_friendship_requests, source: :user

  #######################
  # Unconfirmed sent requests

  # These are the friendships
  has_many :unconfirmed_initiated_friendships, -> { where confirmed: false },
           class_name: 'Friendship', foreign_key: 'user_id'
  # These are the users
  has_many :unconfirmed_friends, through: :unconfirmed_initiated_friendships, source: :friend

  ##################

  # These are the friendships
  has_many :confirmed_initiated_friendships, -> { where confirmed: true },
           class_name: 'Friendship', foreign_key: 'user_id'
  # These are the users
  has_many :initiated_friends, through: :confirmed_initiated_friendships, source: :friend

  # These are the friendships
  has_many :confirmed_accepted_friendships, -> { where confirmed: true },
           class_name: 'Friendship', foreign_key: 'friend_id'
  # These are the users
  has_many :confirmed_friends, through: :confirmed_accepted_friendships, source: :user

  def friends
    initiated_friends + confirmed_friends
  end

  def accept_friend(user)
    u = incoming_friendship_requests.find_by_user_id(user)
    u.confirmed = true
    u.save
  end

  def reject(user)
    friendship = incoming_friendship_requests.find_by_user_id(user)
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end

  def sent_req?(user)
    unconfirmed_friends.include?(user)
  end
end
