class TodosController < ApplicationController
  before_action :authenticate_user!

  def index
    @subtasks = Todo.all.where(:list_id => params[:format])
    
    # @board_id = params[:format]
    # s
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
      redirect_to(lists_path(:board_id => @board_id))
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
    @todo = Todo.find_by_id(params[:id])
    @list_id = @todo.list.id
    @todo.destroy
    flash[:notice] = "Todo Deleted"
    redirect_to(todos_path(@list_id))
  end 

  private

  def subtask_params
    params.require(:todo).permit(:list_id ,:title ,:description ,:due_date ,:status)
  end

end