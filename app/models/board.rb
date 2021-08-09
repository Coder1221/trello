class Board < ApplicationRecord 
    belongs_to :user
    has_many :task  , dependent: :destroy
end