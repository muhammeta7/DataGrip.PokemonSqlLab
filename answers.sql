### PART 2 Simple Selects and Counts

# What are all the types of pokemon that a pokemon can have?
SELECT name AS pokemon_types FROM types;

# What is the name of the pokemon with id 45?
 SELECT name FROM pokemons WHERE id = 45;

 # How many pokemon are there?
SELECT COUNT(id) AS total_pokemon FROM pokemons;

# How many types are there?
SELECT COUNT(id) AS total_types FROM types;

# How many pokemon have a secondary type?
SELECT COUNT(id) AS pokemon_with_secondary_type
FROM pokemons WHERE secondary_type IS NOT NULL;

### PART 3 Joins and Groups
#######################################################

# What is each pokemons primary type?
SELECT p.name AS Pokemon, t.name AS Primary_Type
FROM types t
JOIN pokemons p ON t.id = p.primary_type;

# What is Rufflets secondary type?
SELECT p.name AS Pokemon, t.name AS Secondary_Type
FROM types t
JOIN pokemons p ON t.id = p.secondary_type
WHERE p.name = 'Rufflet';

# What are the names of the pokemon that belong to the trainer with trainerID 303?
SELECT p.name AS Trainer_303_Pokemon
FROM pokemon_trainer pt
JOIN pokemons p ON pt.pokemon_id = p.id
WHERE pt.trainerID = 303;

# How many pokemon have a secondary type Poison
SELECT COUNT(p.secondary_type) AS Number_Of_Pokemon_With_Secondary_Type_Poison
FROM pokemons p
JOIN types t ON t.id = p.secondary_type
WHERE p.secondary_type = 7;

# What are all the primary types and how many pokemon have that type?
SELECT t.name AS Primary_Type, COUNT(p.primary_type) AS Pokemon_Per_Type
FROM pokemons p
JOIN types t ON t.id = p.primary_type
GROUP BY t.name;

# How many pokemon at level 100 does each trainer with at least
# one level 100 pokemone have?
# (Hint: your query should not display a trainer
SELECT COUNT(pokelevel) AS Numb_Of_Level100_Pokemon
FROM pokemon_trainer
WHERE pokelevel = 100
GROUP BY trainerID;

# How many pokemon only belong to one trainer and no other?
SELECT DISTINCT pokemon_id, 
COUNT(*) FROM pokemon_trainer
GROUP BY pokemon_id HAVING count(*) = 1;

### Part 4 FINAL Report
#######################################################
SELECT pokemons.name AS Pokemon_Name, trainers.trainername AS Trainer_Name,
pokemon_trainer.pokelevel AS Level,primary_type.name AS Primary_Type,
secondary_type.name AS Secondary_Type

FROM pokemons
JOIN pokemon_trainer ON pokemons.id = pokemon_trainer.pokemon_id
JOIN trainers ON trainers.trainerID = pokemon_trainer.trainerID
JOIN types primary_type ON pokemons.primary_type = primary_type.id
JOIN types secondary_type ON pokemons.secondary_type = secondary_type.id

SELECT (pokelevel + hp + maxhp + attack + defense + spatk + spdef + speed) AS Stats
FROM pokemon_trainer
JOIN trainers ON pokemon_trainer.trainerID = trainers.trainerID
GROUP BY pokemon_trainer.trainerID
ORDER BY Stats;

# This defines the strongest trainer as the trainer with the highest total stats.
# Total stats for each Pokemon are calculated by getting the sum of its hp, maxhp,
# attack, defense, spatk, spdef, speed, and pokelevel.  The trainers total stats
# is the sum of all of their Pokemons total stats.
