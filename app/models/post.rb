class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	validates :title, presence: true, length: {minimum: 5}
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
  has_many :taggings
  has_many :tags, through: :taggings
  after_save :create_taggings

	def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relations WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end

  def self.from_users_not_followed_by(user)
  	unfollowed_user_ids = (User.all.map(&:id) - user.followed_users.map(&:id) - [user.id]).join(', ')
  	where("user_id IN (#{unfollowed_user_ids})", user_id: user.id) unless unfollowed_user_ids.blank?
  end

  def create_taggings
    content = self.text
    match_data = slice_tags(content)
    while !match_data.nil? do 
      content.gsub! match_data[0].to_s.strip, ''
      Tagging.check_and_create(match_data[0].to_s.strip.gsub('#', ''), self.id)
      match_data = slice_tags(content)
    end
  end  

  def link_tags
    match_data = slice_tags(self.text)
    while !match_data.nil? do
      tag = Tag.find_by_name(match_data[1])
      self.text.gsub!(match_data[0].strip, "<a href=\"/posts/#{self.id}/taggings/#{tag.id}\">#{match_data[0]}</a>")
      match_data = slice_tags(self.text)
    end
    self.text
  end

  private

  def slice_tags(content)
    /(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i.match content
  end
end
