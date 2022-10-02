class Request < ApplicationRecord
  validates :requesting_id, {presence: true}
  validates :requested_id, {presence: true}
end
