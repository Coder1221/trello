class HomeController < ApplicationController
  before_action :authenticate_user! # check if user is logged in or not
  #  we can add except to (not to login) 
  #  protect every thing by default and then white list some of the methods

  def index
    @user_obj = User.find_by_id(current_user.id)  
    @boards  = @user_obj.boards
  end
  
end
