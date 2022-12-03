# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@director_guillermo = Director.create!(hometown: 'Guadalajara, Mexico',
                                        alive: true,
                                        age: 58,
                                        name: 'Guillermo del Toro')
@director_corman = Director.create!(hometown: 'Detroit, Michigan',
                                    alive: true,
                                    age: 96,
                                    name: 'Roger Corman')
@director_furie = Director.create!(hometown: 'Toronto, Canada',
                                  alive: true,
                                  age: 89,
                                  name: 'Sidney J. Furie')
@guillermo_movie_1 = @director_guillermo.movies.create!(version: 'US Release',
                                                        rating: 'R',
                                                        censored: false,
                                                        length_in_mins: 94,
                                                        name: 'Cronos')
@guillermo_movie_2 = @director_guillermo.movies.create!(version: 'Theatrical Release',
                                                        rating: 'R',
                                                        censored: true,
                                                        length_in_mins: 92,
                                                        name: 'Cronos')
@guillermo_movie_3 = @director_guillermo.movies.create!(version: 'Theatrical Release',
                                                        rating: 'R',
                                                        censored: false,
                                                        length_in_mins: 106,
                                                        name: 'The Devil\'s Backbone')
@corman_movie_1 = @director_corman.movies.create!(version: 'Theatrical Release',
                                                  rating: 'UR',
                                                  censored: false,
                                                  length_in_mins: 72,
                                                  name: 'Little Shop of Horrors')
@furie_movie_1 = @director_furie.movies.create!(version: 'Viacom Release',
                                                rating: 'PG',
                                                censored: false,
                                                length_in_mins: 94,
                                                name: 'Superman IV: The Quest for Peace')
@furie_movie_2 = @director_furie.movies.create!(version: 'Theatrical Release',
                                                rating: 'PG',
                                                censored: true,
                                                length_in_mins: 90,
                                                name: 'Superman IV: The Quest for Peace')
@director_guillermo.created_at = @director_guillermo.created_at + 10 * 600
@director_guillermo.save