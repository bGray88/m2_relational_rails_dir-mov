require 'rails_helper'

RSpec.describe 'Director\'s movies index' do
  before :each do
    @director_guillermo = Director.create!(hometown: 'Guadalajara, Mexico',
                                    alive: true,
                                    age: 58,
                                    name: 'Guillermo del Toro')
    @director_corman = Director.create!(hometown: 'Detroit, Michigan',
                                    alive: true,
                                    age: 96,
                                    name: 'Roger Corman')
    @guillermo_movie_1 = @director_guillermo.movies.create!(version: 'US Release',
                                        rating: 'R',
                                        censored: false,
                                        length_in_mins: 94,
                                        name: 'Cronos')
    @guillermo_movie_2 = @director_guillermo.movies.create!(version: 'Original Release',
                                        rating: 'R',
                                        censored: true,
                                        length_in_mins: 92,
                                        name: 'Cronos')
    @guillermo_movie_3 = @director_guillermo.movies.create!(version: 'Original Release',
                                        rating: 'R',
                                        censored: false,
                                        length_in_mins: 106,
                                        name: 'The Devil\'s Backbone')
    @corman_movie_1 = @director_corman.movies.create!(version: 'Original Release',
                                                      rating: 'UR',
                                                      censored: false,
                                                      length_in_mins: 72,
                                                      name: 'Little Shop of Horrors')
  end

  describe 'When I visit \'/directors/:id' do
    it 'shows the director with that id including the director\'s attributes' do
      visit "/directors/#{@director_guillermo.id}"

      expect(page).to have_content(@director_guillermo.name)
      expect(page).to have_content(@director_guillermo.age)
      expect(page).to have_content(@director_guillermo.hometown)
      expect(page).to have_content(@director_guillermo.alive)
      expect(page).not_to have_content(@director_corman.name)
    end
  end
end