class CommentsController < ApplicationController
	 #http_basic_authenticate_with name: "lampsey", password: "250", only: :destroy

	 before_action :signed_in_user
	def create
		@post = Post.find(params[:post_id])

		@comment  = @post.comments.create(comment_params)
		@comment.commenter = current_user.name

		if @comment.save
			redirect_to post_path(@post)
		else
			flash[:notice] = "No body in the comment!"
			redirect_to post_path(@post)
		end
	end

	private

	def comment_params
		params[:comment].permit(:commenter, :body)
	end

end
