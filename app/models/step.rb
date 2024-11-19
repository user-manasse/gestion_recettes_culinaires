class Step < ApplicationRecord
  belongs_to :recipe

  validates :description, presence: true
  validates :position, presence: true, numericality: { only_integer: true }
end
