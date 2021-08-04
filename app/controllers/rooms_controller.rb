class RoomsController < ApplicationController
  before_action :authenticate_user, {
    only: [
      :new,
      :create,
      :posts,
      :edit,
      :update,
      :destroy
    ]
  }

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(params.require(:room).permit(:name, :introduction, :price, :address, :image))
    @room.user_id = session[:user_id]
    if @room.save
      flash[:notice] = "ルームを登録しました"
      redirect_to "/rooms/posts"
    else
      render("new")
    end
  end

  def show
    @room = Room.find(params[:id])
    @user = User.find(@room.user_id)
    @reservation = Reservation.new
  end

  def rooms
    @rooms = Room.where(user_id: session[:user_id])
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(params.require(:room).permit(:name, :introduction, :price, :address, :image))
      flash[:notice] = "ルーム情報を更新しました"
      redirect_to("/rooms/posts")
    else
      render("edit")
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "削除しました"
    redirect_to("/rooms/posts")
  end

  def search_area
    if params[:search].present?
      @rooms = Room.where("address LIKE ?", "%#{params[:search]}%")
    else
      @rooms = Room.all
    end
    @count = @rooms.count
    render "index"
  end

  def search_keyword
    if params[:search].present?
      @rooms = Room.where("name LIKE ? OR introduction LIKE ? OR address LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @rooms = Room.all
    end
    @count = @rooms.count
    render "index"
  end

end
