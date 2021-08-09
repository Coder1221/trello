class SubtasksController < ApplicationController
  before_action :authenticate_user!
  # attr_accessor :board_id
  # before_action only: [:new , :create , :show, :edit, :update, :destroy] do
  #   bord_id_param
  # end

  def new
    @subtask = Subtask.new
    @task_id = params[:id].to_i
    @board_id = params[:board_id].to_i

  end

  def create
    @subtask = Subtask.new(subtask_params)
    @board_id = params[:subtask][:board_id]
    if @subtask.save
      redirect_to(home_path(@board_id))
    else
      render('new')
    end
  end

  def show
    @todo = Subtask.find_by_id(params[:id].to_i)
  end

  def edit
    @subtask  = Subtask.find_by_id(params[:id].to_i)
  end
  
  def update
    @subtask  = Subtask.find_by_id(params[:id].to_i)
    if @subtask.update(subtask_params)
      redirect_to(subtask_path(@subtask.id))
    else
        render('edit')
    end
  end

  def destroy
    @subtask = Subtask.find_by_id(params[:id].to_i)
    @board_id = @subtask.task.board_id
    @subtask.destroy
    flash[:notice] = "Todo-List Deleted"
    redirect_to(home_path(@board_id))
  end

  private
  def subtask_params
    params.require(:subtask).permit(:task_id ,:title ,:description)
  end
  
  # def bord_id_param
  #   @board_id = params[:board_id]
  #   puts "Bord_id#{@board_id}"
  # end

end