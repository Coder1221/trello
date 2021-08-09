class TasksController < ApplicationController

    def index
        @board_id = params[:board_id].to_i
        @tasks = Task.where(board_id: @board_id)
    end

    def show
        @tasks = Task.where(user_id: current_user.id).where(board_id: params[:id])
        @board_id = params[:id]
    end
        
    def new
        @task = Task.new()
        @board_id = params[:format].to_i
    end

    def create
        @task = Task.new(task_params)
        @task.user_id = current_user.id
        if @task.save
            redirect_to(task_path(@task.board_id))
        else
            render 'new'
        end
    end

    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        flash[:notice] = "Task-List Deleted"
        redirect_to(task_path(@task.board_id))
    end

    private

    def task_params
        params.require(:task).permit(:name ,:board_id)
    end
end