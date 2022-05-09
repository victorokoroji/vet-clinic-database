/* Populate database with sample data. */

INSERT INTO animals(name, date_of_birth, weight_kg, neutered, escape_attempts) 
VALUES('Agumon', '2020-02-03', 10.23, true, 0), 
('Gabumon', '2018-11-15', 8.00, true, 2),
 ('Pikachu', '2021-01-07', 15.04, false, 1),
  ('Devimon', '2017-05-12', 11.00, true, 5);
   ('Charmander', '2020-02-08', -11, false, 0), 
    ('Plantmon', '2021-11-15', -5.7, true, 2), 
     ('Squirtle', '1993-04-02', -12.13, false, 3),
      ('Angemon', '2005-06-12', -45, true, 1), 
        ('Boarmon', '2005-06-07', 20.4, true, 7),
         ('Blossom', '1998-10-13', 17, true, 3), 
           ('Ditto', '2022-05-14', 22, true, 4);

-- Add datas into the owners table
BEGIN
 INSERT INTO owners(full_name, age) 
 VALUES('Sam Smith', 34), 
 ('Jennifer Orwell', 19), 
 ('Bob', 45), 
 ('Melody Pond', 77), 
 ('Dean Winchester', 14), 
 ('Jodie Whittaker', 38);

 INSERT INTO species(name) 
 VALUES('Pokemon'), ('Digimon');
COMMIT;


 BEGIN
-- Modify your inserted animals to include species information (species_id)
 UPDATE animals 
 SET species_id = 2 WHERE name LIKE '%mon';

 UPDATE animals 
 SET species_id = 1 WHERE name NOT LIKE '%mon';

-- Modify your inserted animals to include owner information (owner_id)
 UPDATE animals 
 SET owner_id = 1 WHERE name = 'Agumon';

 UPDATE animals 
 SET owner_id = 2 WHERE name = 'Gabumon';

 UPDATE animals 
 SET owner_id = 2 WHERE name = 'Pikachu';

 UPDATE animals 
 SET owner_id = 3 WHERE name = 'Devimon';

 UPDATE animals 
 SET owner_id = 3 WHERE name = 'Plantmon';

 UPDATE animals 
 SET owner_id = 4 WHERE name = 'Charmander';

 UPDATE animals
 SET owner_id = 4 WHERE name = 'Squirtle';

 UPDATE animals 
 SET owner_id = 4 WHERE name = 'Blossom';

 UPDATE animals 
 SET owner_id = 5 WHERE name = 'Angemon';

 UPDATE animals 
 SET owner_id = 5 WHERE name = 'Boarmon';

 COMMIT

BEGIN
-- Insert the following data for vets:
 INSERT INTO vets(name, age, date_of_graduation) 
 VALUES('William Tatcher', 45, '2000-04-23'), 
 ('Maisy Smith', 26, '2019-01-17'), 
 ('Stephanie Mendez', 64,'1981-05-04'), 
 ('Jack Harkness', 38, '2008-06-08');

-- Insert the following datas for speciaties
INSERT INTO specializations(species_id, vet_id)
VALUES(1, 1), 
(2, 3),
(1, 3),
(2, 4)

-- Insert the following datas for visits
INSERT INTO visits (vet_id, animal_id, visit_date) 
VALUES (1, 1, '2020-05-24'),
(3, 1, '2020-07-22'),
(4, 2, '2020-02-02'),
(2, 3, '2020-01-05'),
(2, 3, '2020-03-08'),
(2, 3, '2020-05-14'),
(3, 4, '2021-05-04'),
(4, 5, '202-02-24'),
(2, 6, '2019-12-21'),
(1, 6, '2020-08-10'),
(2, 6, '2021-04-07'),
(3, 7, '2019-09-29'),
(4, 8, '2020-10-03'),
(4, 8, '2019-11-04'),
(2, 9, '2019-01-24'),
(2, 9, '2019-05-15'),
(2, 9, '2020-02-27'),
(2, 9, '2020-08-03'),
(3, 10, '2020-05-24'),
(1, 10, '2021-01-11');
SAVEPOINT JOIN_TABLES
COMMIT;

-- Insert the following data for testing the optimization
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
