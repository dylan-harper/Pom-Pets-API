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

  def update
    user = User.find(params[:id])
    if user_params[:settings] && user.settings.keys.include?(user_params[:settings].keys.first)
      user.update_column(:settings, user.settings.merge({ user_params[:settings].keys.first => user_params[:settings].values.first }))
      return render json: UserSerializer.new(user), status: 200
    end

    if user.update(user_params) && user_params != {}
      return render json: UserSerializer.new(user), status: 200
    else
      return render json: { error: user.errors, status: "400 Bad Request" }, status: 400
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user
      user.destroy
      return render json: { "deleted": "User #{user.id}" }, status: 200
    else
      return render json: { "error": "User with ID #{params[:id]} does not exist" }, status: 400
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
