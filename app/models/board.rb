class Board < ApplicationRecord
    resourcify
    belongs_to :user
    has_many :lists  , dependent: :destroy
end