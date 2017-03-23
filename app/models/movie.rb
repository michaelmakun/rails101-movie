class Movie < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_many :reviews

  scope :recent, -> { order("created_at DESC") }

  has_many :movie_favs
  has_many :members, through: :movie_favs, source: :user
end
