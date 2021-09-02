class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates_uniqueness_of :book_id, scop: :user_id
  # ユーザーは一つの投稿に一つしかいいねできない
end
