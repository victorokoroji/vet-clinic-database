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
 COMMIT;