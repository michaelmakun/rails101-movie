class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  def index
    @movies = Movie.all.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews.all.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    current_user.favorite!(@movie)

    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to movies_path, notice: "电影更新成功"
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, alert: "电影删除成功"
  end

  def favorite
    @movie = Movie.find(params[:id])

    if !current_user.movie_favorite?(@movie)
      current_user.favorite!(@movie)
      flash[:notice] = "收藏成功"
    else
      flash[:warning] = "您已收藏过了"
    end
    redirect_to movie_path(@movie)
  end

  def unlike
    @movie = Movie.find(params[:id])

    if current_user.movie_favorite?(@movie)
      current_user.unlike!(@movie)
      flash[:alert] = "取消收藏"
    else
      flash[:warning] = "没有收藏，不用取消"
    end
    redirect_to movie_path(@movie)
  end

  private

  def movie_params
    params.require(:movie).permit(:title,:description)
  end
end
