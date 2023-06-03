class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@newbook.id)
    else
      flash[:notice] = "error"
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @newbook = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
    @book_comment = BookComment.new
  end


  def edit
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end

    @book = Book.find(params[:id])
  end


  def update
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end

    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      flash[:notice] = "error"
      render :edit
    end
  end


  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  private


  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

end
