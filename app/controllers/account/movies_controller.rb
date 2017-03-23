class Account::MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = current_user.fav_movies.all.paginate(:page => params[:page], :per_page => 5)
  end
end
