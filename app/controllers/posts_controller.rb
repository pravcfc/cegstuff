class PostsController < ApplicationController

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
end
