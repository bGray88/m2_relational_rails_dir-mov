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
    describe 'When I visit \'/parents' do
      it 'shows the name of each parent record in the system' do
        visit '/directors'

        expect(page).to have_content(@director_1.name)
        expect(page).to have_content(@director_2.name)
      end
    end
  end
end