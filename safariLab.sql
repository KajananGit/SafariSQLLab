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

INSERT INTO enclosure (name, capacity, closedForMaintenance) VALUES ('Predator Cat Enclosure', 5, false);
INSERT INTO enclosure (name, capacity, closedForMaintenance) VALUES ('Sea Animal Enclosure', 6, false);
INSERT INTO enclosure (name, capacity, closedForMaintenance) VALUES ('Bird Enclosure', 8, true);


INSERT INTO animals (name, type, age, enclosure_id) VALUES ("Tony","Tiger",59, 1);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ("Gin","Lion",3, 1);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ("Joe","Dolphin",5, 2);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ("Luis","Penguins",10, 2);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ("Emma","Parrot",2, 3);