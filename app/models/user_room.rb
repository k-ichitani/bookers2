class UserRoom < ApplicationRecord
  # userテーブルとroomsテーブルの中間テーブル

  belongs_to :user
  belongs_to :room
  
end
