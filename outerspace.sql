CREATE TABLE stars (
    name VARCHAR(50) PRIMARY KEY,
    temp_k INT NOT NULL CHECK (temp_k > 0));

CREATE TABLE planets (
    name VARCHAR(50) PRIMARY KEY,
    orbital_period_earth_yrs FLOAT NOT NULL,
    star_orbiting_name VARCHAR(50) NOT NULL REFERENCES stars);

CREATE TABLE moons (
    name VARCHAR(50) PRIMARY KEY,
    planet_orbiting_name VARCHAR(50) NOT NULL REFERENCES planets);


INSERT INTO stars
  (name, temp_k)
  VALUES
    ('The Sun', 5800),
    ('Proxima Centauri', 3042),
    ('Gliese 876', 3192);

INSERT INTO planets
  (name,
  orbital_period_earth_yrs,
  star_orbiting_name)
  VALUES
    ('Earth', 1.00, 'The Sun'),
    ('Mars', 1.882, 'The Sun'),
    ('Venus', 0.62, 'The Sun'),
    ('Proxima Centauri b', 0.03, 'Proxima Centauri'),
    ('Gliese 876 b', 0.236, 'Gliese 876');

INSERT INTO moons
  (name, planet_orbiting_name)
  VALUES
    ('The Moon', 'Earth'),
    ('Phobos', 'Mars'),
    ('Deimos', 'Mars');

  SELECT
  planets.name AS planet,
  stars.name AS star,
  COUNT(moons.name) AS moon_count
  FROM planets
    LEFT JOIN moons
      ON moons.planet_orbiting_name = planets.name
    INNER JOIN stars
      ON planets.star_orbiting_name = stars.name
  GROUP BY planets.name, stars.name;