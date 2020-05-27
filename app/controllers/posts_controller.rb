class PostsController < ApplicationController
  def index
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = current_photographer.posts.build(post_params)
    if @post.save
      flash[:success] = '作品を投稿しました。'
      redirect_to photographer_path(current_photographer.id)
    else
      # @microposts = current_user.feed_microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render :new
    end
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
  
end