class FavoritesController < ApplicationController
    def create
        post = Post.find(params[:favorite_id])
        current_photographer.favorite(post)
        flash[:success] = '投稿をお気に入りに追加しました。'
        redirect_to posts_path
    end
    
    def destroy
        post = Post.find(params[:favorite_id])
        current_photographer.unfavorite(post)
        flash[:success] = '投稿のお気に入りを解除しました。'
        redirect_to posts_path
    end
end
