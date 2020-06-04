class PhotographersController < ApplicationController
  before_action :require_photographer_logged_in, only: [:index, :show, :favorittings, :favorite, :unfavorite, :favoriting?]

  def new
    @photographer = Photographer.new
  end
  
  def index
    @photographers = Photographer.order(id: :desc).page(params[:page]).per(15)
    render layout: "special_layout"
  end

  def show
    @photographer = Photographer.find(params[:id])
    @posts_row = @photographer.posts.order(id: :desc).each_slice(2).to_a
  end

  def create
    @photographer = Photographer.new(photographer_params)
    if @photographer.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to login_path
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def favorittings
    @photographer = Photographer.find(params[:id])
    @favorites_row = @photographer.favorites.order(id: :desc).each_slice(2).to_a
  end
  
  def favorite(post)
    unless self == post
        self.favorites.find_or_create_by(post_id: post.id)
    end
  end
  
  def unfavorite(post)
    favorite = self.favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
  end
  
  def favoriting?(post)
    self.favoritings.include?(post)
  end

 private
  def photographer_params
    params.require(:photographer).permit(:name, :email, :password, :password_confirmation)
  end

end
