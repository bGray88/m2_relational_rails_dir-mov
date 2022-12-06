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

  describe 'As a visitor' do
    describe 'User Story #2' do
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

    describe 'User Story #7' do
      it 'shows count of the number of movies associated with this director' do
        visit "/directors/#{@director_guillermo.id}"

        expect(page).to have_content("Number of Movies: 3")
      end
    end

    describe 'User Story #10' do
      describe 'at the director show page' do
        it 'shows a link to take me to that parent\'s `child_table_name` page' do
          visit "/directors/#{@director_guillermo.id}"

          click_on "#{@director_guillermo.name} Movie List"

          expect(current_path).to eq("/directors/#{@director_guillermo.id}/movies")
        end
      end
    end

    describe 'User Story #12' do
      describe 'Then I see a link to update the director "Update Director"' do
        it 'has a link "Update Director" that goes to \'/directors/:id/edit\' has a form to edit the director\'s attributes' do
          
          visit "/directors/#{@director_guillermo.id}/edit"
          new_age = 100
          
          fill_in 'age', :with => new_age
          click_on "Submit Changes"

          expect(current_path).to eq("/directors/#{@director_guillermo.id}")
          expect(Director.find(@director_guillermo.id).age).to eq(100)
        end
      end
    end

    describe 'User Story #19' do
      describe 'Then I see a link to delete the director "Delete Director"' do
        it 'has a link "Delete Director" that deletes director and all of their movies' do
          
          visit "/directors/#{@director_guillermo.id}"

          expect(page).to have_link(text: "Delete")

          expect(Director.where(id: @director_guillermo.id).first.name).to eq('Guillermo del Toro')

          page.first(:link, text: "Delete").click

          expect(current_path).to eq("/directors")
          expect(Director.where(id: @director_guillermo.id).first).to eq(nil)
          expect(Movie.where(director_id: @director_guillermo.id).first).to eq(nil)
        end
      end
    end
  end
end