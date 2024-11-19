class Step < ApplicationRecord
  belongs_to :recipe

  validates :description, presence: true
  validates :position, presence: false, numericality: { only_integer: true }
end
