class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000,
                                                too_long: '1000 characters in post is the maximum allowed.' }

  belongs_to :user

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.user_friends_posts(user)
    ids = user.friends.pluck(:id) << user.id
    where(user_id: ids).order(created_at: :desc)
  end
end
