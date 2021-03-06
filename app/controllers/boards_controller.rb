class BoardsController < ApplicationController  
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @notifications_num = Reminder.where(user_id: current_user.id).count
    @name = current_user.username
  end
  
  def new
  end

  def create
    if @board.save
      redirect_to(boards_path)
      flash[:notice] ="Board was successfully created"
    else
      flash[:notice] = @board.errors.messages
      render('new')
    end
  end
  
  def destroy
    @board.destroy
    flash[:notice] = "Board was successfully deleted."
    redirect_to(boards_path)
  end

  private
  
  def board_params
    params.require(:board).permit(:name , :user_id)
  end

end