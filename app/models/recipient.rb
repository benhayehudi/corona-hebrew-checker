class Recipient < ApplicationRecord
  validates :number, presence: true
  validates :number, uniqueness: true
end
