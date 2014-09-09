class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	validates :title, presence: true, length: {minimum: 5}
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true

	def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relations
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end
