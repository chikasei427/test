class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to photographer_path(@photographer.id)
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  def login(email, password)
    @photographer = Photographer.find_by(email: email)
    if @photographer && @photographer.authenticate(password)
      # ログイン成功
      session[:user_id] = @photographer.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end