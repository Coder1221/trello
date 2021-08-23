class ReminderAlertJob < ApplicationJob
  queue_as :default

  def perform(global_id_of_boards)
    
    boards = []
    
    global_id_of_boards.each do |global_id|
      boards << GlobalID::Locator.locate_signed(global_id)
    end
    
    # optimization if remainders are presnet and they are created today then dont create one retunr that set
    if boards != []
      Reminder.where(:user_id =>boards.first.user_id).delete_all
    end
    
    boards.each do |board|
      board.lists.each do |list|
        list.todos.each do |todo|
          if todo.due_date.present? && todo.one_day_diff? and (todo.status_Pending? or todo.status_Working?)
            Reminder.create(
              user_id: board.user_id,
              board_name: board.name,
              list_name: list.name,
              task: todo.title,
              status: todo.status,
              due_date:todo.due_date.strftime("%d-%m-%Y")
            )
          end
        end
      end
    end

  end

end