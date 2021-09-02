class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # Userのデータが削除されたとき、そのUserが投稿したコメントデータも一緒に削除されます。
  
  attachment :profile_image
  
  validates :name, presence: true ,length: { minimum: 2,maximum:20 }
  validates :introduction, length: { maximum:50 }
  validates :name, uniqueness: true
  
  # def alredy_favorited?(book)
  #   self.favorites.exists?(book_id: :book_id)
  #   # self=current_userのこと、selfに結び付いたbookのidが今bookのidをいいねしようとしているid
  #   # がexistes?＝存在するか
  # end
end
