class DirectorMoviesController < ApplicationController
  def index
    @director = Director.find(params[:director_id])
    @movies   = @director.movies
    @movies   = @director.movies.order(:name) if params[:sort] == 'true'
  end
end
