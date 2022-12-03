require 'rails_helper'

RSpec.describe 'Movies index' do
  before :each do
    @director_guillermo = Director.create!(hometown: 'Guadalajara, Mexico',
                                            alive: true,
                                            age: 58,
                                            name: 'Guillermo del Toro')
    @director_corman = Director.create!(hometown: 'Detroit, Michigan',
                                        alive: true,
                                        age: 96,
                                        name: 'Roger Corman')
    @guillermo_movie_1 = Movie.create!(version: 'US Release',
                                        rating: 'R',
                                        censored: false,
                                        length_in_mins: 94,
                                        name: 'Cronos',
                                        director: @director_guillermo)
    @guillermo_movie_2 = Movie.create!(version: 'Original Release',
                                        rating: 'R',
                                        censored: true,
                                        length_in_mins: 92,
                                        name: 'Cronos',
                                        director: @director_guillermo)
    @guillermo_movie_3 = Movie.create!(version: 'Original Release',
                                        rating: 'R',
                                        censored: false,
                                        length_in_mins: 106,
                                        name: 'The Devil\'s Backbone',
                                        director: @director_guillermo)
    @corman_movie_1 = Movie.create!(version: 'Original Release',
                                    rating: 'UR',
                                    censored: false,
                                    length_in_mins: 72,
                                    name: 'Little Shop of Horrors',
                                    director: @director_corman)
  end

  describe 'As a visitor' do
    describe 'When I visit \'/movies' do
      it 'shows each movie in the system including the movie\'s attributes' do
        visit '/movies'

        expect(page).to have_content(@guillermo_movie_2.name)
        expect(page).to have_content(@guillermo_movie_2.version)
        expect(page).to have_content(@guillermo_movie_2.rating)
        expect(page).to have_content(@guillermo_movie_2.censored)
        expect(page).to have_content(@guillermo_movie_2.length_in_mins)
        expect(page).to have_content(@guillermo_movie_2.name)
      end
    end
  end

  describe 'When I visit the Movie Index page' do
    it 'has a New Movie button routes to \'/movies/new\' where I  see a form for a new movie record' do
      visit "/movies"

      click_on "New Movie"

      expect(current_path).to eq("/movies/new")
      visit "/movies/new"
      movie_count = Movie.all

      expect(page).to have_content("Name:")
      fill_in 'movie[director_id]', :with => 'Guillermo del Toro'
      click_on "Create Movie"

      expect(current_path).to eq("/movies")
      expect(Movie.all).to eq(movie_count)
    end
  end

  describe 'When I visit the child index' do
    it 'shows only records where the boolean column is `true`' do
      visit "/movies"

      expect(page).to have_content(@guillermo_movie_2.name)
      expect(page).to_not have_content(@guillermo_movie_3.name)
    end
  end
end