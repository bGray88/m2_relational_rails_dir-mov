class Movie < ApplicationRecord
  belongs_to :director

  validates :version, presence: true, allow_blank: false
  validates :rating, presence: true, allow_blank: false
  validates :censored, inclusion: { in: [ true, false ] }
  validates :length_in_mins, presence: true, allow_blank: false
  validates :name, presence: true, allow_blank: false
end