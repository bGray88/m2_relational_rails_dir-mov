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
    binding.pry
    director = Director.new({
      hometown: params[:director][:hometown],
      alive:    params[:director][:alive],
      age:      params[:director][:age],
      name:     params[:director][:name]
    })
    director.save

    redirect_to '/directors'
  end
end
