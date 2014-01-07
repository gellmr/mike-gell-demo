class HomeController < ApplicationController
  def index
  end
  
  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      render action: "index"
    end
  end
end
