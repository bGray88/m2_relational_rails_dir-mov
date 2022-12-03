class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
  end

  def create
    movie = Movie.new({
      version:        params[:movie][:version],
      rating:         params[:movie][:rating],
      censored:       params[:movie][:censored],
      length_in_mins: params[:movie][:length_in_mins],
      name:           params[:movie][:name]
    })
    movie.save

    redirect_to '/movies'
  end
end