create database flightBooking;

use flightBooking;

CREATE TABLE airport (
    AirportCode CHAR(3) NOT NULL,
    AirportName VARCHAR(255) NOT NULL,
    TotalTerminals TINYINT NOT NULL,
    IsInternationalAirport BOOLEAN NOT NULL,
    DomesticTerminalCount TINYINT NOT NULL,
    City VARCHAR(255) NOT NULL,
    State VARCHAR(255) NOT NULL,
    Country VARCHAR(255) NOT NULL,
    PRIMARY KEY (AirportCode)
);

-- Data for airport
INSERT INTO airport (AirportCode, AirportName, TotalTerminals, IsInternationalAirport, DomesticTerminalCount, City, State, Country)
VALUES 
('AMD', 'Sardar Vallabhbhai Patel International Airport', 2, true, 1, 'Ahmedabad', 'Gujarat', 'India'),
('BOM', 'Chhatrapati Shivaji Maharaj International Airport', 3, true, 2, 'Mumbai', 'Maharashtra', 'India'),
('DEL', 'Indira Gandhi International Airport', 3, true, 2, 'New Delhi', 'Delhi', 'India'),
('BLR', 'Kempegowda International Airport', 2, true, 1, 'Bengaluru', 'Karnataka', 'India'),
('HYD', 'Rajiv Gandhi International Airport', 2, true, 1, 'Hyderabad', 'Telangana', 'India'),
('LHR', 'Heathrow Airport', 4, true, 2, 'London', 'England', 'United Kingdom'),
('LAX', 'Los Angeles International Airport', 9, true, 7, 'Los Angeles', 'California', 'United States'),
('DXB', 'Dubai International Airport', 3, true, 2, 'Dubai', 'Dubai', 'United Arab Emirates'),
('CDG', 'Charles de Gaulle Airport', 3, true, 2, 'Paris', 'Île-de-France', 'France'),
('SYD', 'Sydney Airport', 3, true, 2, 'Sydney', 'New South Wales', 'Australia'),
('PEK', 'Beijing Capital International Airport', 3, true, 2, 'Beijing', 'Beijing', 'China'),
('FRA', 'Frankfurt Airport', 2, true, 1, 'Frankfurt', 'Hesse', 'Germany'),
('ICN', 'Incheon International Airport', 2, true, 1, 'Incheon', 'Incheon', 'South Korea'),
('SIN', 'Changi Airport', 4, true, 3, 'Singapore', '', 'Singapore'),
('FCO', 'Leonardo da Vinci International Airport', 4, true, 3, 'Rome', 'Lazio', 'Italy'),
('NRT', 'Narita International Airport', 3, true, 2, 'Narita', 'Chiba', 'Japan'),
('ORD', 'O''Hare International Airport', 4, true, 3, 'Chicago', 'Illinois', 'United States'),
('AMS', 'Amsterdam Airport Schiphol', 6, true, 4, 'Amsterdam', 'North Holland', 'Netherlands'),
('HKG', 'Hong Kong International Airport', 2, true, 1, 'Hong Kong', '', 'Hong Kong'),
('DWC', 'Dubai World Central - Al Maktoum International Airport', 1, true, 0, 'Dubai', 'Dubai', 'United Arab Emirates'),
('MAA', 'Chennai International Airport', 3, true, 2, 'Chennai', 'Tamil Nadu', 'India'),
('CCU', 'Netaji Subhas Chandra Bose International Airport', 2, true, 1, 'Kolkata', 'West Bengal', 'India'),
('GOI', 'Goa International Airport', 1, true, 0, 'Dabolim', 'Goa', 'India'),
('COK', 'Cochin International Airport', 3, true, 2, 'Kochi', 'Kerala', 'India'),
('JAI', 'Jaipur International Airport', 2, true, 1, 'Jaipur', 'Rajasthan', 'India'),
('PNQ', 'Pune Airport', 2, false, 2, 'Pune', 'Maharashtra', 'India'),
('GAU', 'Lokpriya Gopinath Bordoloi International Airport', 1, true, 0, 'Guwahati', 'Assam', 'India'),
('TRV', 'Trivandrum International Airport', 2, true, 1, 'Thiruvananthapuram', 'Kerala', 'India'),
('RAJ', 'Rajkot Airport', 1, false, 1, 'Rajkot', 'Gujarat', 'India'),
('BBI', 'Biju Patnaik International Airport', 1, true, 0, 'Bhubaneswar', 'Odisha', 'India');


CREATE TABLE flight (
    FlightId char(7) NOT NULL,
    AirlineName char(50),
    Origin char(3) NOT NULL,
    Destination char(3) NOT NULL,
    Departure time NOT NULL,
    Arrival time NOT NULL,
    EconomyClassAvailable bool,
    BusinessClassAvailable bool,
    NumberOfStops tinyint(2),
    primary key(FlightId)
);


-- Domestic flights
INSERT INTO flight (FlightId, Origin, Destination, Departure, Arrival, EconomyClassAvailable, BusinessClassAvailable, NumberOfStops)
VALUES
('AI101', 'DEL', 'BOM', '08:00:00', '10:00:00', true, true, 0),
('SG702', 'BOM', 'DEL', '10:30:00', '12:30:00', true, false, 0),
('6E503', 'BLR', 'HYD', '09:45:00', '11:15:00', true, true, 0),
('AI305', 'CCU', 'DEL', '14:00:00', '16:30:00', true, true, 1),
('SG621', 'DEL', 'MAA', '11:15:00', '13:30:00', true, false, 0),
('6E205', 'HYD', 'BLR', '13:30:00', '15:00:00', true, true, 0),
('AI811', 'BOM', 'CCU', '16:45:00', '19:15:00', true, true, 0),
('AI301', 'DEL', 'LHR', '21:00:00', '05:30:00', true, true, 1),
('EK501', 'BOM', 'DXB', '18:30:00', '20:00:00', true, true, 0),
('SQ503', 'DEL', 'SIN', '07:45:00', '15:30:00', true, true, 1),
('6E701', 'DEL', 'BLR', '06:30:00', '08:45:00', true, false, 0),
('AI221', 'BOM', 'DEL', '13:15:00', '15:30:00', true, true, 0),
('SG905', 'CCU', 'BOM', '10:00:00', '12:00:00', true, true, 0),
('6E407', 'HYD', 'MAA', '09:00:00', '10:15:00', true, true, 0),
('AI701', 'DEL', 'CCU', '14:30:00', '16:45:00', true, false, 0),
('SG321', 'BOM', 'HYD', '16:30:00', '18:00:00', true, false, 0),
('6E803', 'BLR', 'CCU', '12:00:00', '14:15:00', true, true, 0),
('AI121', 'DEL', 'JFK', '23:00:00', '08:30:00', true, true, 1),
('EK505', 'BOM', 'LHR', '20:15:00', '23:30:00', true, true, 0),
('SQ711', 'DEL', 'SYD', '06:00:00', '18:00:00', true, true, 1);


-- Create table for flight seat availability on particular date
CREATE TABLE flightSeatAvailability (
    FlightId char(7) NOT NULL,
    FlightDate Date NOT NULL,
    SeatsAvailableEconomy SMALLINT UNSIGNED NOT NULL,
    SeatsAvailableBusiness SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY(FlightId, FlightDate)
);

INSERT INTO flightSeatAvailability (FlightId, FlightDate, SeatsAvailableEconomy, SeatsAvailableBusiness)
VALUES
('AI101', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SG702', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('6E503', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI305', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SG621', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('6E205', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI811', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI301', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('EK501', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SQ503', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('6E701', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI221', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SG905', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('6E407', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI701', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SG321', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('6E803', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI121', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('EK505', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SQ711', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI101', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SG702', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('6E503', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI305', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SG621', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('6E205', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI811', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI301', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('EK501', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SQ503', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('6E701', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI221', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SG905', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('6E407', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI701', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SG321', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('6E803', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI121', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('EK505', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SQ711', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI101', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SG702', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('6E503', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI305', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SG621', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('6E205', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI811', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI301', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('EK501', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SQ503', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('6E701', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI221', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SG905', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('6E407', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI701', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SG321', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('6E803', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('AI121', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('EK505', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1)),
('SQ711', DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * (60 - 15 + 1) + 15) DAY), FLOOR(RAND() * (220 - 1 + 1) + 1), FLOOR(RAND() * (30 - 1 + 1) + 1));
