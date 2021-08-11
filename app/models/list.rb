class List < ApplicationRecord
    belongs_to :board
    has_many :todos , dependent: :destroy
end
