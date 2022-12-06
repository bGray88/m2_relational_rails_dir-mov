class MoviesController < ApplicationController
  def index
    @movies = Movie.where(censored: true)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
  end

  def create
    parent = Director.find_by(name: movie_params[:director_id])
    parent_id = parent.id unless parent.nil?
    
    new_params = movie_params.except(:director_id)
    new_params[:director_id] = parent_id

    movie = Movie.create(new_params)

    redirect_to '/movies'
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    parent = Director.find_by(name: movie_params[:director])
    parent_id = parent.id unless parent.nil?

    new_params = movie_params.except(:director)
    new_params[:director_id] = parent_id

    movie = Movie.find_by(id: params[:id])
    movie.update(new_params)

    redirect_to "/movies/#{movie.id}"
  end

  def destroy
    Movie.destroy(params[:id])

    redirect_to '/movies'
  end

  private
  
  def movie_params
    params.permit(
      :version,
      :rating,
      :censored,
      :length_in_mins,
      :name,
      :director
    )
  end
end
