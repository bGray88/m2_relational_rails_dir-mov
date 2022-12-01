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

        expect(page).to have_content(@guillermo_movie_1.name)
        expect(page).to have_content(@guillermo_movie_1.version)
        expect(page).to have_content(@guillermo_movie_1.rating)
        expect(page).to have_content(@guillermo_movie_1.censored)
        expect(page).to have_content(@guillermo_movie_1.length_in_mins)
        expect(page).to have_content(@guillermo_movie_2.name)
        expect(page).to have_content(@corman_movie_1.name)
      end
    end

    describe 'When I visit \'/movies/:id' do
      it 'shows the movie with that id including the movie\'s attributes' do
        visit "/movies/#{@guillermo_movie_1.id}"

        expect(page).to have_content(@guillermo_movie_1.name)
        expect(page).to have_content(@guillermo_movie_1.version)
        expect(page).to have_content(@guillermo_movie_1.rating)
        expect(page).to have_content(@guillermo_movie_1.censored)
        expect(page).to have_content(@guillermo_movie_1.length_in_mins)
        expect(page).not_to have_content(@corman_movie_1.name)
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
end