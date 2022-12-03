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

    describe 'Then I see a link to update the director "Update Director"' do
      it 'has a link "Update Director" that goes to \'/directors/:id/edit\' has a form to edit the director\'s attributes' do
        # When I visit a parent show page
        # Then I see a link to update the parent "Update Parent"
        # When I click the link "Update Parent"
        # Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's attributes:
        # When I fill out the form with updated information
        # And I click the button to submit the form
        # Then a `PATCH` request is sent to '/parents/:id',
        # the parent's info is updated,
        # and I am redirected to the Parent's Show page where I see the parent's updated info
        visit "/directors/#{@director_guillermo.id}/edit"
        new_age = 100

        fill_in 'input_id', :with => new_age

        expect(page).to have_content("age: #{new_age}")
        click_on "Submit Changes"

        expect(current_path).to eq("/directors/#{@director_guillermo.id}")
        expect(@director_guillermo.age).to eq(100)
      end
    end
  end
end