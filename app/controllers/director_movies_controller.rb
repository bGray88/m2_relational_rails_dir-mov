class DirectorMoviesController < ApplicationController
  def index
    @director = Director.find(params[:director_id])
    @movies   = @director.movies
    @movies   = @director.movies.sort_movies(params[:sort]) if params[:sort]
    @movies   = @director.movies.limit_by_length(params[:threshold]) if params[:threshold]
  end

  def new
    @director = Director.find(params[:director_id])
  end
end
