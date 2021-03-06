class UsersController < ApplicationController
  skip_before_action :signed_in_user, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page] )
  end

  def news_feed
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def show 
  	@user =  User.find(params[:id] )
    @posts = @user.posts.paginate(page: params[:page] )
  end

  def create
    @user = User.new(user_params)
    if @user.save and UserMailer.signup_confirmation(@user).deliver
      sign_in @user
      flash[:success] = "Welcome to SAAS Forum!"
      redirect_to root_url
    else 
       render "new"
    end
  end

  def edit 
    @user = User.find(params[:id] )
  end

  def update 
    @user = User.find(params[:id] )

    if @user.update_attributes(user_params)
      flash[:alert] = "profile updated sucessfully!!"
      redirect_to @user
    else
      flash[:alert] = "password and confirmation incorrect!!"
      render "edit"
    end
    
  end

  def following 
    @user = User.find(params[:id])
    @followed_users = @user.followed_users
  end

  def followers 
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:succes] = "User succesfully deleted!"
    redirect_to users_url
  end


private 

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id] )
    redirect_to root_url , alert: 'Cannot perform this action!!' unless current_user?(@user)
  end
end
