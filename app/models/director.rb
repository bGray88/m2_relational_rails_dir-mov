class Director < ApplicationRecord
  has_many :movies

  # validates :hometown, presence: true, allow_blank: false
  # validates :alive, inclusion: { in: [ true, false ] }
  # validates :age, presence: true, allow_blank: false
  # validates :name, presence: true, allow_blank: false
  
  default_scope { order(:created_at) }

  def movie_count
    self.movies.count
  end
end