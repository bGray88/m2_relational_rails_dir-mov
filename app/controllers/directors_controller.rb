class DirectorsController < ApplicationController
  def index
    @directors = Director.all
  end

  def show
    @director = Director.find(params[:id])
  end

  def new
  end

  def create
    director = Director.create(director_params)

    redirect_to '/directors'
  end

  def edit
    @director = Director.find(params[:id])
  end

  def update
    director = Director.find(params[:id])
    director.update(director_params)
    
    redirect_to "/directors/#{director.id}"
  end

  def destroy
    movies = Director.find(params[:id]).movies.where(director_id: params[:id])
    movies.each { |movie| movie.destroy }

    Director.destroy(params[:id])

    redirect_to "/directors"
  end

  private
  
  def director_params
    params.permit(
      :hometown,
      :alive,
      :age,
      :name
    )
  end
end
