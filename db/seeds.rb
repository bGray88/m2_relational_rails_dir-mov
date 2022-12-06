Director.create!([
  {hometown: "Toronto, Canada", alive: true, age: 89, name: "Sidney J. Furie"},
  {hometown: "Versailles, France", alive: true, age: 59, name: "Michel Gondry"},
  {hometown: "Guadalajara, Mexico", alive: true, age: 58, name: "Guillermo del Toro"},
  {hometown: "Detroit, Michigan", alive: true, age: 96, name: "Roger Corman"}
])
Movie.create!([
  {version: "Theatrical Release", rating: "R", censored: false, length_in_mins: 106, name: "Devil's Backbone", director_id: 1},
  {version: "US Release", rating: "R", censored: false, length_in_mins: 94, name: "Cronos", director_id: 1},
  {version: "Viacom Release", rating: "PG", censored: false, length_in_mins: 94, name: "Superman IV: The Quest for Peace", director_id: 3},
  {version: "Theatrical Release", rating: "PG", censored: true, length_in_mins: 90, name: "Superman IV: The Quest for Peace", director_id: 3},
  {version: "Theatrical Release", rating: "R", censored: false, length_in_mins: 108, name: "Eternal Sunshine of the Spotless Mind", director_id: 4},
  {version: "Theatrical Release", rating: "R", censored: true, length_in_mins: 96, name: "Cronos", director_id: 1},
  {version: "Theatrical Release", rating: "R", censored: true, length_in_mins: 104, name: "Science of Sleep", director_id: 4},
  {version: "Theatrical Release", rating: "R", censored: false, length_in_mins: 123, name: "Shape of Water", director_id: 1},
  {version: "Theatrical Release", rating: "R", censored: false, length_in_mins: 94, name: "Suburbia", director_id: 6},
  {version: "Theatrical Release", rating: "PG-13", censored: true, length_in_mins: 76, name: "Little Shop of Horrors", director_id: 6}
])
