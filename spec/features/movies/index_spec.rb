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
                                        name: 'Devil\'s Backbone',
                                        director: @director_guillermo)
    @corman_movie_1 = Movie.create!(version: 'Original Release',
                                    rating: 'UR',
                                    censored: false,
                                    length_in_mins: 72,
                                    name: 'Little Shop of Horrors',
                                    director: @director_corman)
  end

  describe 'As a visitor' do
    describe 'User Story #3' do
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

    describe 'User Story #15' do
      describe 'When I visit the movie index' do
        it 'shows only records where the boolean column is `true`' do
          visit "/movies"

          expect(page).to have_content(@guillermo_movie_2.name)
          expect(page).to_not have_content(@guillermo_movie_3.name)
        end
      end
    end

    describe 'User Story #18' do
      describe 'When I visit the movie index page' do
        it 'shows a link to edit that movie\'s info' do
          visit "/movies"

          expect(page).to have_link(text: "Cronos")
          page.find_link(text: "Edit").click

          expect(current_path).to eq("/movies/#{@guillermo_movie_2.id}/edit")
          new_length = 5000
            
          fill_in 'length_in_mins', :with => new_length
          click_on "Submit Changes"

          expect(current_path).to eq("/movies/#{@guillermo_movie_2.id}")
          expect(Movie.find(@guillermo_movie_2.id).length_in_mins).to eq(5000)
        end
      end
    end

    describe 'When I visit the Movie Index page' do
      it 'has a New Movie button routes to \'/movies/new\' where I see a form for a new movie record' do
        visit "/movies"

        click_on "New Movie"

        expect(current_path).to eq("/movies/new")
        visit "/movies/new"
        expect(page).to have_content("Name:")

        movie_count = Movie.all.count

        fill_in 'version', :with => 'Unrated Version'
        fill_in 'rating', :with => 'UR'
        choose 'censored_true'
        fill_in 'length_in_mins', :with => '118'
        fill_in 'name', :with => 'Pan\'s Labyrinth'
        fill_in 'director', :with => 'Guillermo del Toro'

        click_on "Create Movie"

        expect(current_path).to eq("/directors/#{@director_guillermo.id}/movies")
        expect(Movie.all.count).to eq(movie_count + 1)
      end
    end

    describe 'User Story #23' do
      describe 'When I visit the Movies Index Page' do
        describe 'Then I see a link to delete the movie "Delete"' do
          it 'has a link "Delete" that deletes the movie record' do
            
            visit "/movies"

            expect(page).to have_link(text: "Delete")

            expect(Movie.where(id: @guillermo_movie_1.id).first.name).to eq('Cronos')

            page.first(:link, text: "Delete").click

            expect(current_path).to eq("/movies")
            expect(Movie.find_by(id: @guillermo_movie_2.id)).to eq(nil)
          end
        end
      end
    end
  end
end