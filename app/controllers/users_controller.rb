class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @book = Book.new
    @user = User.find(params[:id])
    # @user = current_user
    @books = @user.books
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = current_user
  end

  def update
    # binding.pry
    if @user.update(user_params)
      # binding.pry
      redirect_to user_path, notice: "You have updated user successfully."
    else
      render "show"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
