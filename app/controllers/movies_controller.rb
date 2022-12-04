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
    parent = Director.find_by(name: params[:movie][:director_id])
    parent_id = parent.id unless parent.nil?
    
    movie = Movie.new({
      version:        params[:movie][:version],
      rating:         params[:movie][:rating],
      censored:       params[:movie][:censored],
      length_in_mins: params[:movie][:length_in_mins],
      name:           params[:movie][:name],
      director_id:    parent_id
    })
    movie.save

    redirect_to '/movies'
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    parent = Director.find_by(name: params[:movie][:director_id])
    parent_id = parent.id unless parent.nil?

    movie = Movie.find(params[:id])
    movie.update({
      version:        params[:movie][:version],
      rating:         params[:movie][:rating],
      censored:       params[:movie][:censored],
      length_in_mins: params[:movie][:length_in_mins],
      name:           params[:movie][:name],
      director_id:    parent_id,
      updated_at:     Time.now
    })
    movie.save

    redirect_to "/movies/#{movie.id}"
  end

  def destroy
    Movie.destroy(params[:id])

    redirect_to '/movies'
  end
end
