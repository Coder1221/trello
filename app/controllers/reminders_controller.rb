class RemindersController < ApplicationController
    before_action :authenticate_user!

    def index
        @reminders = Reminder.all()
    end
end
