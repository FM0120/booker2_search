class Book < ApplicationRecord
belongs_to :user
has_many :favorites, dependent: :destroy
# favoritesたくさんのいいねをされる為複数形、dependent: :destroy、記事が消えた際にいいねも消える
 has_many :book_comments, dependent: :destroy
#  1人のユーザがコメントを投稿できます。
# Userモデルでの1人のユーザに対して、複数個（N個）のbook_commentsモデルを関連付けられます。

 
validates :title, presence: true

validates :body, presence: true,length: { maximum:200 }


 def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
 end
end
