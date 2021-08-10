class SubtasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @subtasks = Subtask.all.where(:task_id => params[:format])
  end

  def new
    @subtask = Subtask.new
    @task_id = params[:id]
    @board_id = params[:board_id]
  end

  def create
    @subtask = Subtask.new(subtask_params)
    @board_id = params[:subtask][:board_id]
    if @subtask.save
      redirect_to(board_path(@board_id))
    else
      render('new')
    end
  end

  def show
    @todo = Subtask.find_by_id(params[:id])
  end

  def edit
    @subtask  = Subtask.find_by_id(params[:id])
  end
  
  def update
    @subtask  = Subtask.find_by_id(params[:id])
    if @subtask.update(subtask_params)
      redirect_to(subtask_path(@subtask.id))
    else
        render('edit')
    end
  end

  def destroy
    @subtask = Subtask.find_by_id(params[:id])
    @board_id = @subtask.task.board_id
    @subtask.destroy
    flash[:notice] = "Todo Deleted"
    redirect_to(board_path(@board_id))
  end

  private
  def subtask_params
    params.require(:subtask).permit(:task_id ,:title ,:description)
  end

end