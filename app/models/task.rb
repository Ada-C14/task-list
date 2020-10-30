class Task < ApplicationRecord
  # prevent an attempt to enter an empty field
  validates :name, presence: true
  validates :description, presence: true
end
