/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = true;
SELECT * from animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Update animals table by setting the species to unspecified
BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

-- Delete all animals
BEGIN;
DELETE from animals;
ROLLBACK;
SELECT * FROM animals;

-- Delete all animals born after Jan 1st, 2022.
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction.
SAVEPOINT DELETE_DATE_OF_BIRTH;

-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint, Update all animals' weights that are negative to be their weight multiplied by -1. commit
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO DELETE_DATE_OF_BIRTH;

UPDATE animals SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;

SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, COUNT(escape_attempts) from animals
GROUP BY neutered;

SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals 
GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN'1990-01-01' AND '2000-12-31'
GROUP BY species;


-- What animals belong to Melody Pond?
SELECT name FROM animals 
JOIN owners ON owners.id = animals.owner_id 
WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT A.name FROM animals A 
JOIN species S ON S.id = A.species_id 
WHERE S.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT full_name, name FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT COUNT(A.name), S.name FROM animals A
JOIN species S ON S.id = A.species_id
GROUP BY S.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT A.name FROM animals A
JOIN species S ON A.species_id = S.id
JOIN owners O on A.owner_id = O.id
WHERE O.full_name = 'Jennifer Orwell' AND S.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT A.name FROM animals A
JOIN owners O ON O.id = A.owner_id
WHERE O.full_name = 'Dean Winchester' AND A.escape_attempts = 0;

-- Who owns the most animals?
SELECT full_name FROM owners O
JOIN animals A ON A.owner_id = O.id
GROUP BY full_name
ORDER BY COUNT(A.name) DESC;

-- Who was the last animal seen by William Tatcher
SELECT A.name FROM animals A
JOIN visits S ON A.id = S.animal_id
JOIN vets V ON V.id = S.vet_id
WHERE V.name = 'William Tatcher'
ORDER BY S.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(A.name) FROM animals A
JOIN visits S ON A.id = S.animal_id
JOIN vets V ON V.id = S.vet_id
WHERE V.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT V.name, S.name FROM vets V
LEFT JOIN specializations ON V.id = specializations.vet_id
LEFT JOIN species S ON S.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT A.name FROM animals A
JOIN visits V ON  V.animal_id = A.id 
JOIN vets S ON V.vet_id = S.id
WHERE S.name = 'Stephanie Mendez'
AND V.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT A.name, COUNT(A.name) FROM animals A
JOIN visits ON visits.animal_id = A.id
JOIN vets V ON visits.vet_id = V.id
GROUP BY A.name
ORDER BY COUNT(A.name) DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT A.name FROM animals A
JOIN visits ON visits.animal_id = A.id
JOIN vets V ON visits.vet_id = V.id
WHERE V.name = 'Maisy Smith'
ORDER BY visits.visit_date
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.*, visits.visit_date, vets.* FROM animals
JOIN visits ON animals.id = visits.animal_id 
JOIN vets ON vets.id = visits.vet_id
ORDER BY visits.visit_date DESC 
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, COUNT(vets.name) AS number_of_visits FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN visits ON visits.vet_id = specializations.vet_id
WHERE specializations.species_id IS NULL
GROUP BY vets.name, specializations.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT COUNT(A.name) AS animal_visited, S.name as animal_type FROM animals A
JOIN visits ON A.name = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
JOIN species S ON S.id = A.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY S.name
ORDER BY COUNT(A.name) DESC;

