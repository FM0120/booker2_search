class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # Userのデータが削除されたとき、そのUserが投稿したコメントデータも一緒に削除されます。
  
  has_many :relationships,class_name: "Relationship",  foreign_key: "follower_id",dependent: :destroy
  has_many :passive_relationships,class_name: "Relationship", foreign_key: "followed_id",dependent: :destroy
  has_many :followings, through: :relationships,source: :followed
  has_many :followers, through: :passive_relationships,source: :follower


def self.search(search,word)
  # if method == "forward_match"
  # self.where("name LIKE?","#{word}%")
  # elsif method == "backward_match"
  # self.where("name LIKE?","%#{word}")
  # elsif method == "perfect_match"
  # self.where(name: word)
  # elsif method == "partial_match"
  # self.where("name LIKE?","%#{word}%")
  # else
  # self.all
  # end
  case search
  when "forward_match" then where("name LIKE?","#{word}%")
  when "backward_match" then where("name LIKE?","%#{word}")
  when "perfect_match" then where(name: word)
  when "partial_match" then where("name LIKE?","%#{word}%")
  else all
  end
end


  def follow(user_id)
      unless self == user_id
       self.relationships.find_or_create_by(followed_id: user_id.to_i, follower_id: self.id)
      end
  end
  
  def unfollow(user_id)
      relationships.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
      followings.include?(user)
  end

  
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
