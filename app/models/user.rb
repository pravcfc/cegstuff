class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	before_save { self.email.downcase! }
	before_create :create_remember_token
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
	    uniqueness: { case_sensitive: false }

	has_many :relations, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relations, source: :followed
	has_many :reverse_relations, foreign_key: "followed_id", class_name: 'Relation', dependent: :destroy
	has_many :followers, through: :reverse_relations, source: :follower

	has_secure_password
	validates :password, length: { minimum: 6 }

	def self.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def feed
		Post.from_users_followed_by(self)
	end

	def following?(other_user)
		relations.find_by(followed_id: other_user.id)
	end

	def follow!(other_user)
		relations.create!(followed_id: other_user.id)
	end

	def unfollow!(other_user)
		relations.find_by(followed_id: other_user.id).destroy
	end

	def followed_user_ids
		self.followed_users.map(&:id).join(', ')
	end
	
	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

	def create_remember_token
		self.remember_token = User.digest( User.new_remember_token )
	end

end
