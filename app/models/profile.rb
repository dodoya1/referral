class Profile < ApplicationRecord
  validates :user_id, {presence: true}
  validates :current, {presence: true}
  validates :occupation, {presence: true}
  validates :introduction, {presence: true}
  validates :ability, {presence: true}
  validates :career, {presence: true}

end
