class Tag < ActiveRecord::Base
	before_save { self.name.downcase! }
	validates_uniqueness_of :name
	validates_presence_of :name
	has_many :taggings
  has_many :posts, through: :taggings
end
