class PostsController < ApplicationController
  before_action :require_photographer_logged_in
  before_action :correct_photographer, only: [:destroy]
  def index
    @posts = Post.order(id: :desc).page(params[:page]).per(4)
    @posts_slice = Post.order(id: :desc).page(params[:page]).per(4).each_slice(2).to_a
  end
  
  def show
    @post = Post.find(params[:id])
    render layout: "special_layout"
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = current_photographer.posts.build(post_params)
    if @post.save
      flash[:success] = "タイトル「#{@post.title}」を投稿しました。"
      redirect_to photographer_path(current_photographer.id)
    else
      # @microposts = current_user.feed_microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = "タイトル「#{@post.title}」の投稿に失敗しました"
      render :new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    unless @post.photographer == current_photographer
      flash[:danger] = '不正なアクセスです。'
      redirect_to posts_path
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "タイトル「#{@post.title}」を編集しました。"
      redirect_to photographer_path(current_photographer.id)
    else
      # @microposts = current_user.feed_microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = "タイトル「#{@post.title}」の編集に失敗しました。"
      render :new
    end
  end
  
  def destroy
    @post.destroy
    flash[:success] = "タイトル「#{@post.title}」 を削除しました。"
    redirect_to root_path
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :content, :picture)
  end

  def correct_photographer
    @post = current_photographer.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end

