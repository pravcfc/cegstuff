class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :post
  default_scope -> { order('created_at DESC') }

  def self.check_and_create(name, id)
  	@tag = Tag.find_by_name name
  	if @tag.nil?
  		@tag = Tag.create! name: name
  	end
  	Tagging.create!(post_id: id, tag_id: @tag.id)
	end

end
