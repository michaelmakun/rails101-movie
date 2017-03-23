class Account::MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = current_user.fav_movies.all
  end
end
