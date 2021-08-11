class TodosController < ApplicationController
  before_action :authenticate_user!

  def index
    @subtasks = Todo.all.where(:list_id => params[:format])
  end

  def new
    @subtask = Todo.new
    @task_id = params[:id]
    @board_id = params[:board_id]
  end

  def create
    @subtask = Todo.new(subtask_params)
    @board_id = params[:todo][:board_id]
    if @subtask.save
      redirect_to(board_path(@board_id))
    else
      render('new')
    end
  end

  def show
    @todo = Todo.find_by_id(params[:id])
  end

  def edit
    @subtask  = Todo.find_by_id(params[:id])
  end
  
  def update
    @subtask  = Todo.find_by_id(params[:id])
    if @subtask.update(subtask_params)
      redirect_to(todo_path(@subtask.id))
    else
        render('edit')
    end
  end

  def destroy
    @subtask = Todo.find_by_id(params[:id])
    @board_id = @subtask.list.board_id
    @subtask.destroy
    flash[:notice] = "Todo Deleted"
    redirect_to(board_path(@board_id))
  end

  private
  def subtask_params
    params.require(:todo).permit(:list_id ,:title ,:description)
  end

end