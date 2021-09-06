class Book < ApplicationRecord
belongs_to :user
has_many :favorites, dependent: :destroy
# favoritesたくさんのいいねをされる為複数形、dependent: :destroy、記事が消えた際にいいねも消える
 has_many :book_comments, dependent: :destroy
#  1人のユーザがコメントを投稿できます。
# Userモデルでの1人のユーザに対して、複数個（N個）のbook_commentsモデルを関連付けられます。

def self.search(search, word)
  if search == "forward_match"
   @book = Book.where("title LIKE?","#{word}%")
  elsif search == "backward_match"
   @book = Book.where("title LIKE?","%#{word}")
  elsif search == "perfect_match"
   @book = Book.where("#{word}")
  elsif search == "partial_match"
   @book = Book.where("title LIKE?","%#{word}%")
  else
   @book = Book.all
  end
end


 
validates :title, presence: true

validates :body, presence: true,length: { maximum:200 }


 def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
 end
end
