# frozen_string_literal: true 
class Ability
  include CanCan::Ability
  def initialize(user)
    can :index , Reminder ,user_id: user.id 

    # its own boards
    if user.has_role?(:creator)
      can :index  ,  Board , user_id: user.id
      can :create  , Board , user_id: user.id
      can :destroy , Board , user_id: user.id

      can :index  ,  List  , user_id: user.id
      can :create , List ,user_id: user.id
      can :destroy , List ,user_id: user.id
      can :update , List ,user_id: user.id
      
      @list_ids = []
      Board.where(user_id: user.id).each do |board|
        @list_ids << board.lists.pluck(:id)
      end
      
      # can :create , Todo , :list_id => List.where(user_id: user.id).pluck(:id)
      # can :create , Todo ,:all
      
      can :index , Todo , :list_id => List.where(user_id: user.id).pluck(:id)
      can :show , Todo  , :list_id => List.where(user_id: user.id).pluck(:id)
      can :destroy  , Todo , :list_id => List.where(user_id: user.id).pluck(:id)
      can :update  ,  Todo , :list_id => List.where(user_id: user.id).pluck(:id)
      
    end
    
    if user.has_role?(:viewer)
      can :index , Board , :id => Board.with_role(:viewer,user).pluck(:id)
      
      can :index , List ,  :board_id => Board.with_role(:viewer,user).pluck(:id)
      cannot :update ,List , :board_id => Board.with_role(:viewer,user).pluck(:id)
      cannot :destroy ,List , :board_id => Board.with_role(:viewer,user).pluck(:id)

      # cannot :create ,List , :board_id => Board.with_role(:viewer,user).pluck(:id)
      # cannot :create , Todo , :list_id => List.where(user_id: user.id).pluck(:id)

      
      @list_ids = []
      Board.with_role(:viewer ,user).each do |board|
        @list_ids << board.lists.pluck(:id)
      end
      
      can :index , Todo , :list_id => @list_ids.flatten
      can :show , Todo , :list_id => @list_ids.flatten
    end

  end
end