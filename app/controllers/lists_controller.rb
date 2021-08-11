class ListsController < ApplicationController    
    before_action :authenticate_user!

    def new
        @task = List.new
        @board_id = params[:format]
    end

    def create
        @task = List.new(list_params)
        @task.user_id = current_user.id
        if @task.save
            redirect_to(board_path(@task.board_id))
        else
            render('new')
        end
    end

    def edit
        @task = List.find_by_id(params[:id])
    end

    def update
        @task = List.find_by_id(params[:id])
        if @task.update(list_params)
            redirect_to(board_path(@task.board_id))
        else
            render('edit')
        end
    end
    
    def destroy
        @task = List.find(params[:id])
        @task.destroy
        flash[:notice] = "Task-List Deleted"
        redirect_to(board_path(@task.board_id))
    end

    private

    def list_params
        params.require(:list).permit(:name ,:board_id)
    end
end
