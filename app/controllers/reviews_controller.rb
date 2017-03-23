class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
    @movie = Movie.find(params[:movie_id])
    @review = Review.all.order("created_at DESC")
  end

  def show
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @review = Review.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @review = Review.new(review_params)
    @review.movie = @movie
    @review.user = current_user

    if @review.save
      redirect_to movie_path(@movie)
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    @review.movie = @movie
    @review.user = current_user

    if @review.update(review_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to movie_reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
