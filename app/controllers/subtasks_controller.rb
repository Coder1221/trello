class SubtasksController < ApplicationController

  def new
    @subtask = Subtask.new
    @task_id = params[:id].to_i 
    @board_id = params[:board_id].to_i
  end

  def create
    @subtask = Subtask.new(subtask_params)
    @board_id = params[:subtask][:board_id]
    if @subtask.save
      redirect_to(task_path(@board_id))
    else
      render 'new'
    end
  end

  private
  def subtask_params
    params.require(:subtask).permit(:task_id ,:title ,:description)
  end
end