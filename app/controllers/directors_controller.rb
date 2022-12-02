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
      hometown: params[:hometown],
      alive:    params[:alive],
      age:      params[:age],
      name:     params[:name]
    })
    director.save

    redirect_to '/directors'
  end
end
