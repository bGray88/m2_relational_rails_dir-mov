require 'rails_helper'

RSpec.describe 'Movies index' do
  before :each do
    @movie_1 = Movie.create!(version: 'US Release',
                              rating: 'R',
                              censored: false,
                              length_in_mins: 94,
                              name: 'Cronos')
    @movie_2 = Movie.create!(version: 'Original Release',
                              rating: 'R',
                              censored: true,
                              length_in_mins: 92,
                              name: 'Cronos')
    @movie_3 = Movie.create!(version: 'Original Release',
                              rating: 'R',
                              censored: false,
                              length_in_mins: 106,
                              name: 'The Devil\'s Backbone')
  end

  describe 'As a visitor' do
    describe 'When I visit \'/movies' do
      it 'shows each movie in the system including the movie\'s attributes' do
        visit '/movies'

        expect(page).to have_content(@movie_1.name)
        expect(page).to have_content(@movie_1.version)
        expect(page).to have_content(@movie_1.rating)
        expect(page).to have_content(@movie_1.censored)
        expect(page).to have_content(@movie_1.length_in_mins)
        expect(page).to have_content(@movie_2.name)
        expect(page).to have_content(@movie_3.name)
      end
    end

    describe 'When I visit \'/movies/:id' do
      it 'shows the movie with that id including the movie\'s attributes' do
        visit "/movies/#{@movie_1.id}"

        expect(page).to have_content(@movie_1.name)
        expect(page).to have_content(@movie_1.version)
        expect(page).to have_content(@movie_1.rating)
        expect(page).to have_content(@movie_1.censored)
        expect(page).to have_content(@movie_1.length_in_mins)
        expect(page).not_to have_content(@movie_2.name)
        expect(page).not_to have_content(@movie_3.name)
      end
    end
  end
end