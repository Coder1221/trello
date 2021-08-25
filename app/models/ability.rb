# frozen_string_literal: true 
class Ability
  include CanCan::Ability
  def initialize(user)
    can :read , Reminder ,user_id: user.id 

    if user.has_role?(:creator)
      # manage ---> [:read[index,show] , :update[edit,update] ,:destroy,:create [new,create]] 
      
      can :manage , Board , user_id: user.id
      can :manage  , List ,user_id: user.id
      
      @moderator_ids = []
      user.invitations.each do |invitation|
        if invitation.has_role?(:moderator)
          @moderator_ids << invitation.id
        end
      end 
      can :manage  , List ,user_id: @moderator_ids

      @list_ids = []
      Board.where(user_id: user.id).each do |board|
        @list_ids << board.lists.pluck(:id)
      end
      
      can :manage , Todo , :list_id => List.where(user_id: user.id).pluck(:id)
      
      @moderator_todos_ids = []

      user.invitations.each do |invitation|
        if invitation.has_role?(:moderator)
          Board.with_role(:moderator, invitation).each do |board|
            board.lists.each do |list|
              @moderator_todos_ids <<list.todos.pluck(:id)
            end
          end
        end
      end
      
      can :manage , Todo , :id => @moderator_todos_ids.flatten
      can :create , Todo
    end

    if user.has_role?(:moderator)
      can :read  ,  Board , :id => Board.with_role(:moderator, user).pluck(:id)
      can :manage , List , :board_id => Board.with_role(:moderator, user).pluck(:id)

      @list_ids = []
      Board.with_role(:moderator , user).each do |board|
        @list_ids << board.lists.pluck(:id)
      end
      can :manage ,  Todo  ,  :list_id => @list_ids.flatten
      can :create , Todo
    end
    
    if user.has_role?(:viewer)
      can :read , Board , :id => Board.with_role(:viewer,user).pluck(:id)
      
      can :read , List ,  :board_id => Board.with_role(:viewer,user).pluck(:id)
      cannot :update ,List , :board_id => Board.with_role(:viewer,user).pluck(:id)
      cannot :destroy ,List , :board_id => Board.with_role(:viewer,user).pluck(:id)
      
      @list_ids = []
      Board.with_role(:viewer ,user).each do |board|
        @list_ids << board.lists.pluck(:id)
      end
      can :read , Todo , :list_id => @list_ids.flatten
    end

  end
end