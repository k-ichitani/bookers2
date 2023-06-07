class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = User.all
    @newbook = Book.new
    @books = @user.books
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
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

  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "日付を選択してください"
    else
      create_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ?', "#{create_at}%"]).count
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
