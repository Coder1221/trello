class Todo < ApplicationRecord
    belongs_to :list
    
    enum status: {
        Pending: 0,
        Done: 1,
        Working: 2 
    }, _prefix: true
    
    def one_day_diff?
        date = due_date.to_date
        curr_date = Time.zone.today
        if curr_date.month == date.month && curr_date.year == date.year
            # puts date.day , curr_date.day
            if (date.day - curr_date.day).abs <= 1 and curr_date.day <= date.day
                return true
            end
        end
        return false
    end
end 