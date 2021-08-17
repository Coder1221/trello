class ReminderAlertJob < ApplicationJob
  queue_as :default

  def perform(global_id_of_boards)
    
    Reminder.delete_all    
    
    boards = []
    
    global_id_of_boards.each do |global_id|
      boards << GlobalID::Locator.locate_signed(global_id)
    end

    boards.each do |board|
      board.lists.each do |list|
        list.todos.each do |todo|
          if todo.due_date.present? && todo.one_day_diff? and (todo.status_Pending? or todo.status_Working?)
            Reminder.create(
              board_name: board.name,
              list_name: list.name,
              task: todo.title,
              status: todo.status,
            )
          end
        end
      end
    end
  end

end