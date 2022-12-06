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

    describe 'When I visit \'/directors' do
      it 'shows records ordered by most recently created first
      And next to each of the records I see when it was created' do

        @director_guillermo.created_at = @director_guillermo.created_at + 10 * 60
        @director_guillermo.save

        visit '/directors'

        expected = @director_corman.created_at < @director_guillermo.created_at

        expect(page).to have_content(@director_guillermo.name)
        expect(page).to have_content(@director_corman.name)
        expect(page).to have_content(@director_guillermo.created_at)
        expect(page).to have_content(@director_corman.created_at)
        expect(Director.all).to eq([@director_corman, @director_guillermo])
        expect(expected).to be true

        @director_corman.created_at = @director_corman.created_at + 10 * 600
        @director_corman.save

        visit '/directors'

        expected = @director_corman.created_at > @director_guillermo.created_at

        expect(Director.all).to eq([@director_guillermo, @director_corman])
        expect(expected).to be true
      end
    end
    
    describe 'When I visit a parent show page (/parents/:id)' do
     it 'shows a link to take me to that parent\'s `child_table_name` page' do
        visit "/directors/#{@director_guillermo.id}"

        click_on "#{@director_guillermo.name} Movie List"

        expect(current_path).to eq("/directors/#{@director_guillermo.id}/movies")
      end
    end

    describe 'When I visit the Director Index page' do
      it 'has a New Director button routes to \'/directors/new\' where I see a form for a new director record' do
        visit "/directors"

        click_on "New Director"

        expect(current_path).to eq("/directors/new")
        expect(page).to have_content("Name:")
        
        director_count = Director.all.count

        fill_in 'Hometown', :with => 'Denver, Colorado'
        choose 'alive_true'
        fill_in 'age', :with => 50
        fill_in 'name', :with => 'Oliver Whiting'

        click_on "Create Director"

        expect(current_path).to eq("/directors")
        expect(Director.all.count).to eq(director_count + 1)
      end
    end

    describe 'When I visit the parent index page' do
      it 'shows a link to edit that parent\'s info' do
        visit "/directors"

        page.first(:link, text: "Edit").click

        expect(current_path).to eq("/directors/#{@director_guillermo.id}/edit")
        new_age = 100
        
        fill_in 'age', :with => new_age
        click_on "Submit Changes"

        expect(current_path).to eq("/directors/#{@director_guillermo.id}")
        expect(Director.find(@director_guillermo.id).age).to eq(100)
      end
    end
  end
end