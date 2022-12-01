require 'rails_helper'

RSpec.describe 'Directors index' do
  before :each do
    @director_guillermo = Director.create!(hometown: 'Guadalajara, Mexico',
                                            alive: true,
                                            age: 58,
                                            name: 'Guillermo del Toro')
    @director_corman = Director.create!(hometown: 'Detroit, Michigan',
                                        alive: true,
                                        age: 96,
                                        name: 'Roger Corman')
  end

  describe 'As a visitor' do
    describe 'When I visit \'/directors' do
      it 'shows the name of each director record in the system' do
        visit '/directors'

        expect(page).to have_content(@director_guillermo.name)
        expect(page).to have_content(@director_corman.name)
      end
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

    describe 'When I visit \'/directors' do
      it 'shows records ordered by most recently created first
      And next to each of the records I see when it was created' do
        visit '/directors'

        expected = @director_guillermo.created_at <= @director_corman.created_at

        expect(page).to have_content(@director_guillermo.name)
        expect(page).to have_content(@director_corman.name)
        expect(expected).to be true
        expect(page).to have_content(@director_guillermo.created_at)
        expect(page).to have_content(@director_corman.created_at)
      end
    end
    
    describe 'When I visit a parent show page (/parents/:id)' do
     it 'shows a link to take me to that parent\'s `child_table_name` page' do
        visit "/directors/#{@director_guillermo.id}"

        click_on "#{@director_guillermo.name} Movie List"

        expect(current_path).to eq("/directors/#{@director_guillermo.id}/movies")
      end
    end
  end
end