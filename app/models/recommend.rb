class Recommend < ApplicationRecord
  validates :user_from, {presence: true}
  validates :user_to, {presence: true}
  validates :content, {presence: true}
  
  # インスタンスメソッドuserを定義してください
  def user
    return User.find_by(id: self.user_from)
  end
  
end
