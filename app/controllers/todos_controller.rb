class TodosController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @todos = @todos.where(:list_id => params[:list_id])
  end

  def new
    # @todo = Todo.new
    @task_id = params[:id]
    @board_id = params[:board_id]
  end 

  def create
    @todo = Todo.new(todo_params)
    @board_id = params[:todo][:board_id]
    if @todo.save
      ReminderAlertJob.set(wait_until: @todo.due_date).perform_later(@todo)
      redirect_to(lists_path(:board_id => @board_id))
    else
      render('new')
    end
  end

  def show
    @todo = Todo.find_by_id(params[:id])
  end

  def edit
    @todo  = Todo.find_by_id(params[:id])
  end
  
  def update
    @todo  = Todo.find_by_id(params[:id])
    
    if @todo.update(todo_params)
      redirect_to(todo_path(@todo.id))
    else
        render('edit')
    end
  end

  def destroy
    @todo = Todo.find_by_id(params[:id])
    @list_id = @todo.list.id
    @todo.destroy
    flash[:notice] = "Todo Deleted"
    redirect_to(todos_path(:list_id => @list_id))
  end 

  private

  def todo_params
    params.require(:todo).permit(:list_id ,:title ,:description ,:due_date ,:status)
  end

end