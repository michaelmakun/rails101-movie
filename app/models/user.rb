class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :movies
  has_many :reviews

  has_many :movie_favs
  has_many :fav_movies, :through => :movie_favs, :source => :movie

  def movie_favorite?(movie)
    fav_movies.include?(movie)
  end

  def favorite!(movie)
    fav_movies << movie
  end

  def unlike!(movie)
    fav_movies.delete(movie)
  end
end
