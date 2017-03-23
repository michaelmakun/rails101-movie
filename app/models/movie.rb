class Movie < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_many :reviews

  scope :recent, -> { order("created_at DESC") }
end
