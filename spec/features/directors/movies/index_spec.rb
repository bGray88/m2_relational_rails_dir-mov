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
    @guillermo_movie_2 = @director_guillermo.movies.create!(version: 'Theatrical Release',
                                        rating: 'R',
                                        censored: true,
                                        length_in_mins: 92,
                                        name: 'Cronos')
    @guillermo_movie_3 = @director_guillermo.movies.create!(version: 'Theatrical Release',
                                        rating: 'R',
                                        censored: false,
                                        length_in_mins: 106,
                                        name: 'The Devil\'s Backbone')
    @corman_movie_1 = @director_corman.movies.create!(version: 'Theatrical Release',
                                                      rating: 'UR',
                                                      censored: false,
                                                      length_in_mins: 72,
                                                      name: 'Little Shop of Horrors')
  end

  describe 'As a visitor' do
    describe 'When I visit /directors/:id/movies' do
      it 'shows links to each movies show page' do
        visit "/directors/#{@director_guillermo.id}/movies"

        click_on @guillermo_movie_3.name

        expect(current_path).to eq("/movies/#{@guillermo_movie_3.id}")
      end
    end
  end

  describe 'When I visit any page on the site' do
    it 'shows a link at the top of the page for both of the director & movie indexes' do
      visit "/directors/#{@director_guillermo.id}/movies"

      click_on 'Movies List'

      expect(current_path).to eq("/movies")

      visit "/movies"

      click_on 'Directors List'

      expect(current_path).to eq("/directors")
    end
  end

  describe 'When I visit the directors page on the site' do
    it 'shows a link to sort the movies alpabetically when redirected to the director\'s movies index page' do
      visit "/directors/#{@director_guillermo.id}/movies"
      expect(page).to have_link('Sort List', href: '/directors/1/movies')

      click_on 'Sort List'
      result = page.find(:link, text: 'Cronos: Theatrical')

      expect(current_path).to eq("/directors/#{@director_guillermo.id}/movies")
      expect(result.path.include?('[1]')).to be true
    end
  end
end
