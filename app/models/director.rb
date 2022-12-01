class Director < ApplicationRecord
  has_many :movies

  def movie_count
    self.movies.count
  end
end