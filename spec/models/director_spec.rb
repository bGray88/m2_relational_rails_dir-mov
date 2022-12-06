require 'rails_helper'

RSpec.describe Director, type: :model do
  it {should have_many :movies}

  describe 'instance methods' do
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
      describe 'User Story #7' do
        it 'shows count of the number of movies associated with this director' do
          expect(@director_guillermo.movie_count).to eq(3)
        end
      end
    end
  end
end
