class PostsController < ApplicationController
	before_action :correct_user, only: [:edit, :update]

	def new
		@post = Post.new
	end

	def index
		@posts = Post.from_users_not_followed(current_user).paginate(page: params[:page])
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

	def edit 
    @post = Post.find(params[:id] )
  end

  def update 
    @post = Post.find(params[:id] )

    if @post.update_attributes(post_params)
      flash[:notice] = "Blog updated successfully!!"
      redirect_to @post
    else
    	flash[:notice] = "Blog failed to update!!"
      render "new"
    end
    
  end

	def destroy
		Post.find(params[:id]).delete
		redirect_to root_url, alert: 'Blog deleted!!'
	end

	def show
		@post = Post.find(params[:id])
	end

	private
	def post_params
		params.require(:post).permit(:title, :text)
	end

	def correct_user 
	  @post = Post.find(params[:id] )
		redirect_to root_url , alert: 'Cannot perform this action!!' unless current_user?(@post.user)
	end
end
