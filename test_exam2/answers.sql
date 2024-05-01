-- In next line, insert your student ID after the colon.
-- Student ID:

-- Below, you must at most make one SQL query for each question. If you make several, they will be ignored.
-- -----------------------------------------------------------------------------------------------------
-- q1: Answer to question 1 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
SELECT flightID
FROM Flight
    JOIN Airport on Flight.toAirport = Airport.airportID
WHERE
    Airport.city = 'Milano';
-- -----------------------------------------------------------------------------------------------------
-- q2: Answer to question 2 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
SELECT FlightPassengers.flightID, MAX(FlightPassengers.price)
FROM FlightPassengers
GROUP BY
    FlightPassengers.flightID
HAVING
    MAX(FlightPassengers.price) < 1200;
-- -----------------------------------------------------------------------------------------------------
-- q3: Answer to question 3 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
SELECT FlightPassengers.CNO
FROM FlightPassengers
    JOIN FLIGHT ON FlightPassengers.flightID = Flight.flightID
WHERE
    toAirport != 'CPH';
-- -----------------------------------------------------------------------------------------------------
-- q4: Answer to question 4 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
SELECT Plane.capacity - COUNT(*) as freeseats
FROM
    Flight
    JOIN FlightPassengers ON Flight.flightID = FlightPassengers.flightID
    JOIN Plane ON Flight.planeID = Plane.planeID
GROUP BY
    FlightPassengers.FlightID
HAVING
    freeseats > 0;

-- -----------------------------------------------------------------------------------------------------
-- q5: Answer to question 5 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER Flight_Before_Insert BEFORE 
INSERT ON Flight FOR EACH ROW 
BEGIN 
	IF NEW.fromAirport = NEW.toAirport THEN SIGNAL SQLSTATE '45000'
	SET
	    MESSAGE_TEXT = 'Departure and arrival airports must be different';
END
	IF;
END; 

-- -----------------------------------------------------------------------------------------------------
-- q6: Answer to question 6 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
INSERT INTO
    Flight (
        flightID, depDate, depTime, duration, fromAirport, toAirport, planeID
    )
VALUES (
        'AirDK322', '2023-05-01', '10:30:00', '02:00:00', 'CPH', 'CPH', 2
    )