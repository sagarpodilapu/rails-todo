class UsersController < ApplicationController
  before_action :get_user, only: [:edit,:update,:destroy,:show]
  #before_action :check_auth, only: [:edit,:update,:destroy]
  def check_auth
    if session[:user_id] != @tweet.user_id
      flash[:notice] = "Sorry! You cannot edit this tweet"
      redirect_to(users_path)
    end
  end
  def index
    # show all tweets
    @users = User.all
  end
  def show
    respond_to do |format|
      format.html #show.html.erb
      format.json {render json:@user}
      format.xml {render xml:@user}
    end
  end
  def new
    @user = User.new    # Not the final implementation!
  end

  def edit
    # show a edit tweet form

  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render 'new'
    end
  end

  def update
    # udpate a tweet
    if @user.update_attributes(user_params)
      # Handle a successful update.
      redirect_to(users_path)
    else
      render 'edit'
    end
  end
  def destroy
    # delete a tweet
    @user.destroy
    flash[:success] = "user deleted"
    redirect_to users_path
  end

  def login

  end

  private

  def user_params
    params.require(:user).permit(:username, :password,:password_confirmation)
  end

  def get_user
    @user = User.find(params[:id])
  end
end
