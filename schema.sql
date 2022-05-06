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
    full_name VARCHAR(30), age INT, 
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

