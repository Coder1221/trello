class BoardsController < ApplicationController  
  before_action :authenticate_user!
  
  def index
    @boards = User.find_by_id(current_user.id).boards
  end
  
  def new
      @board = Board.new
  end

  def show
    @tasks = Task.where(user_id: current_user.id).where(board_id: params[:id])
    @board_id = params[:id]
    @index = 0
    @tasks.each do |task|
      if task.subtask.length > @index
          @index = task.subtask.length
      end
    end
  end

  def create
    @board = current_user.boards.new(board_params)
    if @board.save
      redirect_to(boards_path)
      flash[:notice] ="Board was successfully created"
    else
      flash[:notice] = board.errors.messages
      render('new')
    end
  end
  
  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    flash[:notice] = "Board was successfully deleted."
    redirect_to(boards_path)
  end

  private
  
  def board_params
    params.require(:board).permit(:name , :user_id)
  end

end