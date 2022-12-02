class Director < ApplicationRecord
  has_many :movies
  default_scope { order(:created_at) }

  def movie_count
    self.movies.count
  end
end