class UsersController < ApplicationController

	def new
    @user = User.new
  end


	def create
    @current_user = current_user

    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.json { head :no_content }
        format.js

      else
        format.json { render json: @user.errors.full_messages, status: :unprocessable_entity }
      end
    end
    sign_in(@current_user)

  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name,:email,:password)
    end
end
