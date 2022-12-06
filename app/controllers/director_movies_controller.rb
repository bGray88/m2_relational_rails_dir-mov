class DirectorMoviesController < ApplicationController
  def index
    @director = Director.find(params[:director_id])
    @movies   = @director.movies
    @movies   = @director.movies.order(:name) if params[:sort]
    @movies   = @director.movies.where(length_in_mins: (params[:threshold].to_i + 1)..Float::INFINITY) if params[:threshold]
  end

  def new
    @director = Director.find(params[:director_id])
  end
end
