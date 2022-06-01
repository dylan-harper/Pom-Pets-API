class Api::V1::UsersController < ApplicationController

  def show
    user = User.find_by(id: params[:id])

    if user
      render json: UserSerializer.new(user), status: 200
    else
      render json: { error: "User not found", status: '404' }, status: 404
    end
  end

  def create
    new_user = User.create(user_params)
    if new_user.save
      render json: UserSerializer.new(new_user), status: 200
    else
      render json: { error: new_user.errors, status: "400 Bad Request" }, status: 400
    end
  end

private

  def user_params
    params.require(:user).permit(:username,
                                 :email,
                                 :profilePhoto,
                                 :settings => [:workTime, :shortPomTime, :longPomTime])
  end
end
