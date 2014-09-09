class PostsController < ApplicationController

	def new
		@post = Post.new
	end

	def index
		@posts = Post.all.paginate(page: params[:page])
	end

	def create
		@post = current_user.posts.build(post_params)
		@post.user_id = current_user.id
			if @post.save
				flash[:succes] = "Blog Posted!!"
				redirect_to @post
			else 
				@feed_items = []
				render "new"
			end
	end

	def destroy

	end

	def show
		@post = Post.find(params[:id])
	end

	private
	def post_params
		params.require(:post).permit(:title, :text)
	end
end
