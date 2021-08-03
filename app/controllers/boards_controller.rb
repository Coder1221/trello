class BoardsController < ApplicationController  
  
  def new
      @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id

    if @board.save
      redirect_to(home_index_path)
    else
      # flash notice
      # puts @board.errors.messages,'---------->'
      render(:action => 'new')
    end
  end

  
  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to(home_index_path)
  end


  private
  
  def board_params
    params.require(:board).permit(:name , :user_id)
  end

end