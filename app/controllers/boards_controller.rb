class BoardsController < ApplicationController  
  before_action :authenticate_user!
  
  def new
      @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id

    if @board.save
      flash[:notice] ="Board was successfully created"
      redirect_to(home_index_path)
    else
      flash[:notice] = board.errors.messages
      render(:action => 'new')
    end
  end
  
  def destroy
    #  delete orphan records
    @board = Board.find(params[:id])
    @board.destroy
    flash[:notice] = "Board was successfully deleted."
    redirect_to(home_index_path)
  end

  private
  
  def board_params
    params.require(:board).permit(:name , :user_id)
  end

end