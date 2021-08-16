class Todo < ApplicationRecord
    belongs_to :list
    enum status: {
        Pending: 0,
        Done: 1,
        Working: 2 
    }, _prefix: true
end