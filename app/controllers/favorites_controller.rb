class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    @favorite = current_user.favorites.new(book_id: book.id)
    @favorite.save
    # redirect_to request.referer ここは非同期通信の場合削除要！
  end

  def destroy
    book = Book.find(params[:book_id])
    @favorite = current_user.favorites.find_by(book_id: book.id)
    @favorite.destroy
    # redirect_to request.referer　ここは非同期通信の場合削除要！
  end

end
