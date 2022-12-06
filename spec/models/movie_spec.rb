require 'rails_helper'

RSpec.describe Movie, type: :model do
  it {should belong_to :director}

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
      @guillermo_movie_1 = @director_guillermo.movies.create!(version: 'Original Release',
                                                              rating: 'R',
                                                              censored: false,
                                                              length_in_mins: 106,
                                                              name: 'Devil\'s Backbone')
      @guillermo_movie_2 = @director_guillermo.movies.create!(version: 'US Release',
                                                              rating: 'R',
                                                              censored: false,
                                                              length_in_mins: 94,
                                                              name: 'Cronos')
      @guillermo_movie_3 = @director_guillermo.movies.create!(version: 'Original Release',
                                                              rating: 'R',
                                                              censored: true,
                                                              length_in_mins: 92,
                                                              name: 'Cronos')
      @corman_movie_1 = @director_corman.movies.create!(version: 'Original Release',
                                                        rating: 'UR',
                                                        censored: false,
                                                        length_in_mins: 72,
                                                        name: 'Little Shop of Horrors')
    end

    describe '#sort_movies' do
      it 'sorts movie records ascending or descending based on params keyword' do
        expect(@director_guillermo.movies.first).to eq(@guillermo_movie_1)
        expect(@director_guillermo.movies.sort_movies('asc').first).to eq(@guillermo_movie_2)
        expect(@director_guillermo.movies.sort_movies('asc').last).to eq(@guillermo_movie_1)
      end
    end

    describe '#limit_by_length' do
      it 'limits the records returned by length integer params' do
        expect(@director_guillermo.movies.count).to eq(3)
        expect(@director_guillermo.movies.limit_by_length(100).count).to eq(1)
      end
    end
  end
end
