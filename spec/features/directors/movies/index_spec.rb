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

  describe '' do
    describe '' do
      it 'links to each movies show page' do
        visit "/directors/#{@director_guillermo.id}/movies"

        click_on @guillermo_movie_3.name

        expect(current_path).to eq("/movies/#{@guillermo_movie_3.id}")
      end
    end
  end

  describe 'When I visit any page on the site' do
    it 'shows a link at the top of the page that takes me to the Child Index' do
      visit "/directors/#{@director_guillermo.id}/movies"

      click_on 'Movies List'

      expect(current_path).to eq("/movies")

      visit "/directors/#{@director_guillermo.id}/movies"

      click_on 'Directors List'

      expect(current_path).to eq("/directors")
    end
  end
end
