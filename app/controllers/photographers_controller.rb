class PhotographersController < ApplicationController
  def new
    @photographer = Photographer.new
  end
  
  def index
  end
  
  def show
    @photographer = Photographer.find(params[:id])
  end
  
  def create
    @photographer = Photographer.new(photographer_params)
    if @photographer.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to photographer_path(@photographer.id)
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

 private
  def photographer_params
    params.require(:photographer).permit(:name, :email, :password, :password_confirmation)
  end

end
