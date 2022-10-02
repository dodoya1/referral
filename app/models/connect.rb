class Connect < ApplicationRecord
  validates :connecting_id, {presence: true}
  validates :connected_id, {presence: true}
end
