class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = User.all
    @books = @user.books
    @newbook = Book.new
  end

  def edit
   @user = User.find(params[:id])
   if @user == current_user
     render"edit"
   else
    redirect_to user_path(current_user)
   end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      flash[:notice] = ""
      render "edit"
    end
  end

  def index
    @user = current_user
    @users = User.all
    @newbook = Book.new
  end



  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
