DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS enclosures;
DROP TABLE IF EXISTS staffs;

CREATE TABLE staffs(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    employeeNumber INT
);

CREATE TABLE enclosures(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    capacity INT,
    closedForMaintenance BOOLEAN
);

CREATE TABLE animals(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(255),
    age INT,
    enclosure_id INT REFERENCES enclosures(id)
);


CREATE TABLE assignments(
    id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES staffs(id),
    enclosure_id INT REFERENCES enclosures(id),
    day VARCHAR(255)
);


INSERT INTO staffs (name, employeeNumber) VALUES ('Sigourney Weaver', 12345);
INSERT INTO staffs (name, employeeNumber) VALUES ('Benedict Cumberbatch', 456789);
INSERT INTO staffs (name, employeeNumber) VALUES ('Robert Downey Jr', 56789);

INSERT INTO enclosures (name, capacity, closedForMaintenance) VALUES ('Predator Cat Enclosure', 5, false);
INSERT INTO enclosures (name, capacity, closedForMaintenance) VALUES ('Sea Animal Enclosure', 6, false);
INSERT INTO enclosures (name, capacity, closedForMaintenance) VALUES ('Bird Enclosure', 8, true);


INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Tony', 'Tiger', 59, 1);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Gin', 'Lion', 3, 1);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Joe', 'Dolphin', 5, 2);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Luis', 'Penguins', 10, 2);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Emma', 'Parrot', 2, 3);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Amy', 'Falcon', 59, 3);

INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (1, 2, 'Monday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (2, 1, 'Tuesday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (3, 1, 'Monday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (2, 2, 'Monday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (3, 2, 'Wednesday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (1, 1, 'Friday');
INSERT INTO assignments (employee_id, enclosure_id, day) VALUES (3, 3, 'Friday');

-- MVP ANSWERS:
-- Write queries to find:
-- The names of the animals in a given enclosure
SELECT a.name, a.type, e.name 
FROM enclosures AS e 
INNER JOIN animals AS a 
ON e.id = a.enclosure_id 
WHERE e.id = 1;;

-- The names of the staff working in a given enclosure
SELECT s.name, a.day, e.name
FROM staffs AS s
INNER JOIN assignments AS a
ON s.id = a.employee_id
INNER JOIN enclosures AS e
ON a.enclosure_id = e.id
WHERE e.id = 1;;

-- Extenstions Answers:
-- Write queries to find:
-- The names of staff working in enclosures which are closed for maintenance:
SELECT s.name, a.day, e.name
FROM staffs AS s
INNER JOIN assignments AS a
ON s.id = a.employee_id
INNER JOIN enclosures AS e
ON a.enclosure_id = e.id 
WHERE e.closedForMaintenance = true;

-- The name of the enclosure where the oldest animal lives. If there are two animals who are the same age choose the first one alphabetically.:
SELECT e.name, a.name,  a.age 
FROM enclosures AS e 
INNER JOIN animals AS a 
ON e.id = a.enclosure_id 
ORDER BY a.age DESC, a.name ASC LIMIT 1;

-- answer without limit:
SELECT e.name, a.name,  a.age 
FROM enclosures AS e 
INNER JOIN animals AS a 
ON e.id = a.enclosure_id 
ORDER BY a.age DESC, a.name ASC;

-- The number of different animal types a given keeper has been assigned to work with.:
SELECT COUNT(DISTINCT ani.type) FROM animals AS ani 
INNER JOIN enclosures AS e 
ON ani.enclosure_id = e.id 
INNER JOIN assignments AS assign 
ON e.id = assign.enclosure_id 
INNER JOIN staffs AS s 
ON assign.employee_id = s.id 
WHERE s.name = 'Sigourney Weaver';


-- The number of different keepers who have been assigned to work in a given enclosure:
SELECT COUNT(DISTINCT s.name) 
FROM staffs AS s 
INNER JOIN assignments AS a 
ON s.id = a.employee_id 
INNER JOIN enclosures AS e 
ON a.enclosure_id = e.id 
WHERE e.name = 'Bird Enclosure'; 

-- Another way of answering this question which gives the num of diff keepers assigned to all existing enclosure:
SELECT COUNT(s.name), e.name
FROM staffs AS s 
INNER JOIN assignments AS a 
ON s.id = a.employee_id 
INNER JOIN enclosures AS e 
ON a.enclosure_id = e.id 
GROUP BY e.name; 

-- The names of the other animals sharing an enclosure with a given animal (eg. find the names of all the animals sharing the big cat field with Tony):
SELECT a.name, a.type, e.name 
FROM enclosures AS e 
INNER JOIN animals AS a 
ON e.id = a.enclosure_id 
WHERE e.name IN 
( SELECT e.name 
FROM enclosures AS e 
INNER JOIN animals AS a 
ON e.id = a.enclosure_id 
WHERE a.name = 'Joe');
