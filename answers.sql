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
SELECT DISTINCT GROUP_CONCAT(p.name) AS Pokemon, tr.trainername AS Trainer,
GROUP_CONCAT(pt.pokelevel) AS PokeLevels, GROUP_CONCAT(t.name) AS Primary_Types,
GROUP_CONCAT(s.name) AS Secondary_Types, Stats.total
FROM pokemon_trainer pt
JOIN (
      SELECT trainerID, AVG(pokelevel + hp + maxhp + attack + defense + spatk + spdef + speed) AS total
      FROM pokemon_trainer
      GROUP BY trainerID
) AS Stats ON Stats.trainerID = pt.trainerID
JOIN pokemons p ON p.id = pt.pokemon_id
JOIN trainers tr ON tr.trainerID = pt.trainerID
JOIN types t ON t.id = p.primary_type
JOIN types s ON s.id = p.secondary_type
GROUP BY Stats.total, tr.trainerID, tr.trainername
ORDER BY Stats.total DESC;

# Reasoning: I took the averages of all the pokemons stats including level, attack, defense...etc
# and whichever trainer had the highest average for their pokemon determines their rank.
