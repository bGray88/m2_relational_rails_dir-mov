class DirectorsController < ApplicationController
  def index
    @directors = Director.all.sort_by { |director| director.created_at }.reverse
  end

  def show
    @director = Director.find(params[:id])
  end
end
