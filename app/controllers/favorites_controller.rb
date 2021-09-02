class FavoritesController < ApplicationController
  def create
    @favorite = current_user.favorites.create(book_id: params[:book_id])
    # current_userに結び付いたいいねを作成
    redirect_back(fallback_location:root_path)
    # redirect_back,いいねをした際に前の画面に戻る
    
  end
  
  def destroy
    book = Book.find(params[:book_id])
    # どのbookに結び付いたいいねを消すのか
    favorite = current_user.favorites.find_by(book_id: book.id)
    # 11行目で取得したbookをbook_idに入れる
    favorite.destroy
    redirect_back(fallback_location:root_path)
    # fallback_location:root_path、ひとつ前のurlが見つからなかったらroot_pathに遷移する。
  end
end
