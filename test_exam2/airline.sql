-- airline.sql file for creating and populating the Airline database.
-- Referential integrity constraints are deliberately omitted from airline.sql, 
-- and they must be added to keep the database consistent.

DROP DATABASE IF EXISTS Airline;
CREATE DATABASE Airline;
USE Airline;

DROP TABLE IF EXISTS FlightPassengers;
DROP TABLE IF EXISTS Flight;
DROP TABLE IF EXISTS Plane;
DROP TABLE IF EXISTS Airport;
DROP TABLE IF EXISTS Customer;

CREATE TABLE Airport (
     airportID VARCHAR(5) PRIMARY KEY, -- e.g. CPH
     city VARCHAR(20) NOT NULL
);

CREATE TABLE Plane (
     planeID SMALLINT PRIMARY KEY,
     capacity INT NOT NULL -- number of available seats
);

CREATE TABLE Customer (
     CNO VARCHAR(10) PRIMARY KEY,
     name VARCHAR(50)
);

CREATE TABLE Flight(
     flightID VARCHAR(10) PRIMARY KEY,
     depDate DATE NOT NULL,
     depTime TIME NOT NULL, -- in CET time zone
     duration TIME NOT NULL,
     fromAirport VARCHAR(5) NOT NULL,
     toAirport VARCHAR(5) NOT NULL,
     planeID SMALLINT 
);

CREATE TABLE FlightPassengers (
     flightID VARCHAR(10),
     CNO CHAR(10), 
     price INT NOT NULL,
     PRIMARY KEY (flightID, CNO)
);
        
INSERT INTO Airport(airportID, city)
VALUES  ('CPH',	'Copenhagen'),
        ('MXP', 'Milano'),
        ('LIN', 'Milano'),
        ('CDG',	'Paris'),
        ('ORY', 'Paris');
	
INSERT INTO Plane (planeID, capacity)
VALUES	(1, 2),
	(2, 250),
	(3, 300) ;

INSERT INTO Customer (CNO, name)
VALUES	('C1', 'Giovanni'), 
        ('C2', 'Alberto'),
        ('C3', 'Anne'),
        ('C4', 'Karin') ;
        
INSERT INTO 
Flight(flightID, depDate,      depTime,    duration,   fromAirport,  toAirport, planeID)
VALUES ('AirDK322', '2023-05-01', '10:30:00', '02:00:00', 'CPH',      'MXP',       2),
       ('AirDK450', '2023-05-04', '14:00:00', '02:00:00', 'MXP',      'CPH',       2),
       ('AirDK500', '2023-05-07', '08:00:00', '01:50:00', 'CPH',      'CDG',       1),
       ('AirDK700', '2023-06-21', '20:00:00', '02:10:00', 'CPH',      'LIN',       null), 
       ('AirDK800', '2023-07-30', '16:00:00', '02:10:00', 'LIN',      'CPH',       2),
       ('AirDK820', '2023-07-30', '20:00:00', '02:10:00', 'CPH',      'LIN',       2),
       ('AirDK900', '2023-08-25', '08:00:00', '01:50:00', 'CPH',      'CDG',       null)
       ; 

INSERT INTO FlightPassengers(flightID, CNO, price)
VALUES  ('AirDK322', 'C1', 1000),
        ('AirDK322', 'C2', 1250),
        ('AirDK450', 'C1', 1000),
        ('AirDK500', 'C1', 5000),
	('AirDK500', 'C2', 5000),
        ('AirDK500', 'C3', 5000),
        ('AirDK700', 'C1',  900);

SELECT * FROM Customer;
SELECT * FROM Plane;
SELECT * FROM Airport;
SELECT * FROM Flight;
SELECT * FROM FlightPassengers;
