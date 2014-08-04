class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to root_url, notice: 'Employee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
      end
    end
  end

  def user_params
    params.require(:user).permit(:timezone, :name)
  end

end
