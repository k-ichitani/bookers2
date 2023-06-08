class ChatsController < ApplicationController
  before_action :following_check, only: [:show]

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    if user_rooms.nil?
      chat_room = Room.new
      chat_room.save
      UserRoom.create(user_id: @user.id, room_id: chat_room.id)
      UserRoom.create(user_id: current_user.id, room_id: chat_room.id)
    else
      chat_room = user_rooms.room
    end

    @chats = @room.chats
    @chat = Chat.new(room_id: chat_room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    # redirect_to request.referer 非同期通信のため削除
    chat_room = @chat.room
    @chats = chat_room.chats
  end

  private

  def following_check
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to books_path
    end
  end

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

end
