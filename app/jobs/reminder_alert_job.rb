class ReminderAlertJob < ApplicationJob
  queue_as :default

  def perform(todo)
    if todo.due_date.present? and (todo.status_Pending? or todo.status_Working?)
      Reminder.create(
        user_id: todo.list.board.user_id,
        board_name: todo.list.board.name ,
        list_name: todo.list.name,
        task: todo.title,
        status: todo.status,
        due_date:todo.due_date.strftime("%d-%m-%Y")
      )
    end
  end

end