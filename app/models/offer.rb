class Offer < ApplicationRecord
  validates :content, {presence: true}
  validates :user_id, {presence: true}
  validates :setting, {presence: true, numericality: true}
  validates :title, {presence: true, length: {maximum: 30}}
  
  def user
    return User.find_by(id: self.user_id)
  end
  
end
