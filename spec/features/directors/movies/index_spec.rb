require 'rails_helper'

RSpec.describe 'Director\'s movies index' do
  before :each do
    @director_1 = Director.create!(hometown: 'Guadalajara, Mexico',
                                    alive: true,
                                    age: 58,
                                    name: 'Guillermo del Toro')
    @director_2 = Director.create!(hometown: 'Detroit, Michigan',
                                    alive: true,
                                    age: 96,
                                    name: 'Roger Corman')
    @movie_1 = Movie.create!(version: 'US Release',
                              rating: 'R',
                              censored: false,
                              length_in_mins: 94,
                              name: 'Cronos')
    @movie_2 = Movie.create!(version: 'Original Release',
                              rating: 'R',
                              censored: true,
                              length_in_mins: 92,
                              name: 'Cronos')
    @movie_3 = Movie.create!(version: 'Original Release',
                              rating: 'R',
                              censored: false,
                              length_in_mins: 106,
                              name: 'The Devil\'s Backbone')
  end
  it 'links to each movies show page' do
    visit "/directors/#{@director_1.id}/songs"

    click_on @movie_1.title

    expect(current_path).to eq("/directors/#{@movie_1.id}")
  end
end