class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @boards = User.find_by_id(current_user.id).board  
  end
  
  def show
    @tasks = Task.where(user_id: current_user.id).where(board_id: params[:id])

    # if @tasks.length == 0
    #   redirect_to(root_path)
    # end

    @board_id = params[:id]
    @index = 0
    @tasks.each do |task|
      if task.subtask.length > @index
          @index = task.subtask.length
      end
    end
  end

end
