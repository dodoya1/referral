class Chat < ApplicationRecord
    validates :user_id, {presence: true}
    validates :room_id, {presence: true}
    validates :message, {presence: true}

    def user
        return User.find_by(id: self.user_id)
    end
    
end