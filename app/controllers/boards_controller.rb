class BoardsController < ApplicationController  
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    global_id_of_boards = []

    @boards.each do |board|
      global_id_of_boards << board.to_sgid.to_s
    end
    
    ReminderAlertJob.perform_later(global_id_of_boards)
    # @boards = User.find_by_id(current_user.id).boards
  end
  
  def new
  end

  def create
    # @board = current_user.boards.new(board_params)  
    if @board.save
      redirect_to(boards_path)
      flash[:notice] ="Board was successfully created"
    else
      flash[:notice] = @board.errors.messages
      render('new')
    end
  end
  
  def destroy
    # @board = Board.find(params[:id])
    @board.destroy
    flash[:notice] = "Board was successfully deleted."
    redirect_to(boards_path)
  end

  private
  
  def board_params
    params.require(:board).permit(:name , :user_id)
  end

end