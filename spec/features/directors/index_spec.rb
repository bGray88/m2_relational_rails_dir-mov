require 'rails_helper'

RSpec.describe 'Directors index' do
  before :each do
    @director_1 = Director.create!(hometown: 'Guadalajara, Mexico',
                                  alive: true,
                                  age: 58,
                                  name: 'Guillermo del Toro')
    @director_2 = Director.create!(hometown: 'Detroit, Michigan',
                                  alive: true,
                                  age: 96,
                                  name: 'Roger Corman')
  end

  describe 'As a visitor' do
    describe 'When I visit \'/directors' do
      it 'shows the name of each director record in the system' do
        visit '/directors'

        expect(page).to have_content(@director_1.name)
        expect(page).to have_content(@director_2.name)
      end
    end

    describe 'When I visit \'/parents/:id' do
      it 'shows the director with that id including the director\'s attributes' do
        visit "/directors/#{@director_1.id}"

        expect(page).to have_content(@director_1.name)
        expect(page).not_to have_content(@director_2.name)
      end
    end
  end
end