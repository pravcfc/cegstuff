class TaggingsController < ApplicationController
	def show 
		@tag = Tag.find params[:id]
		@taggings = Tagging.where(tag_id: params[:id])
		@posts = @taggings.map{ |tagging| Post.find(tagging.post_id) }
	end
end
