class Room < ApplicationRecord
    validates :user_to, {presence: true}
    validates :user_from, {presence: true}
    
end