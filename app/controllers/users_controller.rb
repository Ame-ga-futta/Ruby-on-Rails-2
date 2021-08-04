class UsersController < ApplicationController
  before_action :authenticate_user, {
    only: [
    :logout,
    :account,
    :profile,
    :edit,
    :update_profile,
    :update_account,
    :destroy
    ]
  }
  before_action :forbid_login_user, {
    only: [
    :login_form,
    :login,
    :signup_form,
    :create,
    ]
  }

  def top
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(
      email: params[:email],
      password: params[:password]
    )
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/")
    else
      @input = params[:email]
      @error_message = "メールアドレス もしくはパスワードが不正です"
      render "login_form"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/users/log_in")
  end

  def signup_form
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録しました"
      redirect_to("/")
    else
      render "signup_form"
    end
  end

  def account
    @user = User.find(session[:user_id])
  end

  def profile
    @user = User.find(session[:user_id])
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update_profile
    @user = User.find(session[:user_id])
    if @user.update(params.require(:user).permit(:icon, :name, :introduction))
      flash[:notice] = "プロフィール情報を更新しました"
      redirect_to :users_profile
    else
      render "profile"
    end
  end

  def update_account
    @user = User.find(session[:user_id])
    @user_update = User.new(params.require(:user).permit(:email, :password, :password_reset, :password_reset_confirmation))
    if @user.password == @user_update.password
      if @user.update(params.require(:user).permit(:email, :password, :password_reset, :password_reset_confirmation))
        unless @user.password_reset.empty?
          @user.password = @user.password_reset
          @user.save
        end
        flash[:notice] = "アカウント情報を更新しました"
        redirect_to("/users/account")
      else
        render "edit"
      end
    else
      @error_message = "パスワードが間違っています"
      render "edit"
    end
  end

  def destroy
    @user = User.find(session[:user_id])
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "退会しました"
    redirect_to("/")
  end
end
