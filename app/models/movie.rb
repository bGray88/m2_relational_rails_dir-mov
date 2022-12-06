class Movie < ApplicationRecord
  belongs_to :director

  validates :version, presence: true, allow_blank: false
  validates :rating, presence: true, allow_blank: false
  validates :censored, inclusion: { in: [ true, false ] }
  validates :length_in_mins, presence: true, allow_blank: false
  validates :name, presence: true, allow_blank: false

  def self.limit_by(params)
    self.all.where(params)
  end

  def self.sort_movies(params)
    self.all.order(name: params)
  end

  def self.limit_by_length(params)
    self.all.where(length_in_mins: (params.to_i + 1)..Float::INFINITY)
  end
end