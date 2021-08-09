class TasksController < ApplicationController    
    before_action :authenticate_user!
    def new
        @task = Task.new()
        @board_id = params[:format].to_i
    end

    def create
        @task = Task.new(task_params)
        @task.user_id = current_user.id
        if @task.save
            redirect_to(home_path(@task.board_id))
        else
            render 'new'
        end
    end

    def edit
        @task = Task.find_by_id(params[:id])
    end

    def update
        @task = Task.find_by_id(params[:id])
        if @task.update(task_params)
            redirect_to(home_path(@task.board_id))
        else
            render('edit')
        end
    end
    


    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        flash[:notice] = "Task-List Deleted"
        redirect_to(home_path(@task.board_id))
    end

    private
    def task_params
        params.require(:task).permit(:name ,:board_id)
    end
    
end