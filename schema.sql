/* Database schema to keep the structure of entire database. */


CREATE TABLE animals( 
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(20), 
    date_of_birth DATE, 
    escape_attempts INT, 
    neutered BOOLEAN, 
    weight_kg DECIMAL, 
    PRIMARY KEY(id)
);

ALTER TABLE animals 
    ADD species VARCHAR(15);

-- Create owners table
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY, 
    full_name VARCHAR(30),
    age INT, 
    PRIMARY KEY(id)
);

-- Create species table
CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY, 
    name VARCHAR(20), 
    PRIMARY KEY(id)
);

-- Remove column species
BEGIN

ALTER TABLE animals
DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
 ALTER TABLE animals 
 ADD species_id INT references species(id);

-- Add column owner_id which is a foreign key referencing owners table
 ALTER TABLE animals 
 ADD owner_id INT references owners(id);

 SAVEPOINT ADD_FOREIGN_KEY;
 COMMIT;

-- Create vet table
CREATE TABLE vets(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    name VARCHAR(25), 
    age INT,
    date_of_graduation DATE
);

-- create join table 
CREATE TABLE specializations (
   species_id INT references species(id)
   vet_id INT references vets(id),
);

CREATE TABLE visits (
   animal_id INT references animals(id),
   vet_id INT references vets(id),
   visit_date DATE 
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Add index to optimize record
BEGIN;
CREATE INDEX owners_email_index ON owners(email);
COMMIT;