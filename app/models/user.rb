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
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"


  def pending_f_req
    self.friendships.select{|f| !f.confirmed }
  end
      
  def recieving_f_req
    self.inverse_friendships.map{|f| f if !f.confirmed}.compact
  end
  
  def self.friends
     self.friendships + self.inverse_friendships
  end


  def befriend(user)
    
  end

end
