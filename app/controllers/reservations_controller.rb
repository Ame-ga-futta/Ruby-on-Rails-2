class ReservationsController < ApplicationController
  before_action :authenticate_user, {
    only: [
      :reservations,
      :confirm,
      :create
    ]
  }

  def reservations
    @reservations = Reservation.where(user_id: session[:user_id])
  end

  def confirm
    @reservation = Reservation.new(params.require(:reservation).permit(:start_date, :end_date, :people, :room_id))
    @user = User.find(session[:user_id])
    @room = Room.find(@reservation.room_id)
    if @reservation.valid?
      if (@reservation.end_date - @reservation.start_date).to_i < 1
        @reservation.errors.add(:end_date, "は開始日より後にしてください")
        @room = Room.find(params[:id])
        @user = User.find(@room.user_id)
        render("rooms/show")
      else
        @reservation.user_id = @user.id
        @reservation.room_image = @room.image
        @reservation.room_name = @room.name
        @reservation.room_introduction = @room.introduction
        @reservation.room_total_price = @room.price * @reservation.people * (@reservation.end_date - @reservation.start_date).to_i
      end
    else
      @room = Room.find(params[:id])
      @user = User.find(@room.user_id)
      render("rooms/show")
    end
  end

  def create
    @reservation = Reservation.new(params.require(:reservation).permit(:room_id, :user_id, :start_date, :end_date, :people, :room_image, :room_name, :room_introduction, :room_total_price))
    if @reservation.save
      flash[:notice] = "予約されました"
      redirect_to "/reservations"
    else
      flash[:notice] = "もう一度やり直してください"
      redirect_to "/"
    end
  end
end
