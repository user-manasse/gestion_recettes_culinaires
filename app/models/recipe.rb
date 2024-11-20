class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :utensils, dependent: :destroy
  has_many :steps, -> { order(:position) }, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true
  validates :description, presence: true
  validates :preparation_time, presence: false
  validates :difficulty, inclusion: { in: [1, 2, 3] }, allow_nil: true
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  accepts_nested_attributes_for :utensils, allow_destroy: true
  accepts_nested_attributes_for :steps, allow_destroy: true
end
