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
    director = Director.new({
      hometown: params[:director][:hometown],
      alive:    params[:director][:alive],
      age:      params[:director][:age],
      name:     params[:director][:name]
    })
    director.save

    redirect_to '/directors'
  end

  def edit
    @director = Director.find(params[:id])
  end

  def update
    director = Director.find(params[:id])
    director.update({
      hometown:   params[:director][:hometown],
      alive:      params[:director][:alive],
      age:        params[:director][:age],
      name:       params[:director][:name],
      updated_at: Time.now
    })
    director.save
    
    redirect_to "/directors/#{director.id}"
  end

  def destroy
    movies = Movie.where(director_id: params[:id])
    movies.each { |movie| movie.destroy }
    Director.destroy(params[:id])

    redirect_to "/directors"
  end
end
