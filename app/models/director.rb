class Director < ApplicationRecord
  has_many :movies
  default_scope { order(:created_at) }

  validates :hometown, presence: true, allow_blank: false
  validates :alive, presence: true, allow_blank: false
  validates :age, presence: true, allow_blank: false
  validates :name, presence: true, allow_blank: false

  def movie_count
    self.movies.count
  end
end