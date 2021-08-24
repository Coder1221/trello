class ListsController < ApplicationController    
    before_action :authenticate_user!
    load_and_authorize_resource
    
    def index
        @lists = @lists.where(:board_id => params[:board_id])
        @board_id = params[:board_id]
        @title  = @lists.length > 0 ? @lists.first.board.name : "EMPTY BOARD"
    end

    def new
        @board_id = params[:format]
    end

    def create
        # load_and_authorize will defaulty look for its list_params
        # @list.user_id = current_user.id will also create user with id 
        #  so we dont have to 
        # @list = List.new(list_params)
        if @list.save
            redirect_to(lists_path(:board_id =>@list.board_id))
        else
            render('new')
        end
    end

    def edit
        # @list = List.find_by_id(params[:id])
    end

    def update
        # @task = List.find_by_id(params[:id])
        if @list.update(list_params)
            redirect_to(lists_path(:board_id => @list.board_id))
        else
            render('edit')
        end
    end
    
    def destroy
        # @task = List.find(params[:id])
        @list.destroy
        flash[:notice] = "Task-List Deleted"
        redirect_to(lists_path(:board_id => @list.board_id))
    end

    private

    def list_params
        params.require(:list).permit(:name ,:board_id)
    end
end