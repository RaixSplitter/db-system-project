USE Dhe_Hejking_Store;

-- POPULATE THE TABLES --

-- Insert values into Store table --
INSERT Store (StoreID, StoreName, StoreAddress, Telephone, StoreStatus) VALUES
('00000', 'Dhe Hejking Amager', 'Amagerbrogade 15', '99887766', 'Active'),
('00001', 'Dhe Hejking Kbh', 'Nørrebrogade 65', '88776655', 'Active'),
('00002', 'Dhe Hejking Valby', 'Valbygade 30', '11223344', 'Active'),
('00003', 'Dhe Hejking Lyngby', 'Lyngbyvej 10', '77665544', 'Active'),
('00004', 'Dhe Hejking DTU', 'Anker Engelunds Vej', '66554433', 'Active');

-- Insert values into Products table --
INSERT Products (ProductID, ProductName, Brand, ProductPrice) VALUES
('54321', 'Hiking shoes', 'Peak', 500.95),
('54322', 'Hiking shoes', 'Columbia', 749.99),
('54323', 'Hiking shoes', 'The North Face', 499.99),
('12345', 'Hiking socks', 'Peak', 350.95),
('11111', 'Hiking pants', 'The North Face', 350.95),
('31111', 'Nightflash', 'Nitecore', 250.00),
('11112', 'Hiking pants', 'Columbia', 400.00),
('11113', 'Hiking pants', 'Columbia', 600.00),
('11114', 'Hiking pants', 'Columbia', 750.00);

-- Insert values into Category table --
INSERT Category (CategoryID, CategoryName) VALUES
('98765', 'Footwear'),
('56789', 'Male'),
('12345', 'Female'),
('54321', 'Non-gender'),
('10000', 'Outdoor Clothes'),
('20000', 'Equipment'),
('30000', 'Underwear');

-- Insert values into Categories table --
INSERT Categories (ProductID, CategoryID) VALUES
('54321', '98765'),
('54321', '54321'),
('12345', '98765'),
('12345', '12345'),
('11111', '98765'),
('31111', '20000'),
('11112', '10000'),
('11112', '56789');

-- Insert values into Stock table --
INSERT Stock (ProductID, StoreID, StockQuantity) VALUES
('54321', '00000', 4),
('12345', '00001', 20),
('54321', '00002', 3),
('54321', '00003', 4),
('12345', '00004', 20),
('54321', '00004', 3),
('11111', '00001', 10),
('31111', '00001', 20),
('11113', '00001', 5),
('11114', '00001', 10),
('11111', '00002', 10),
('31111', '00002', 20),
('11113', '00003', 5),
('11114', '00003', 10),
('11111', '00004', 10),
('31111', '00004', 20),
('11113', '00004', 5)
;

-- 
INSERT INTO Staff (StaffID, StoreID, WorkingStatus) VALUES
('A1000', '00000', 'Active'),
('A2000', '00001', 'Active'),
('A3000', '00002', 'Active'),
('A4000', '00003', 'Active'),
('B5000', '00004', 'Active'),
('B6000', '00001', 'Inactive'),
('C7000', '00000', 'Inactive'), 
('C8000', '00000', 'Inactive'),
('C9000', '00000', 'Active');


-- Insert values into StaffPrivateInfo table --
INSERT StaffPrivateInfo (StaffID, FirstName, Surname, StaffAddress, Telephone) VALUES
('A1000', 'Sebas', 'Jensen', 'Valbyparken 1', '11223344'),
('A2000', 'Marcus', 'Christensen', 'Lyngbyvej 23', '22334455'),
('A3000', 'Adiya', 'Smith', 'Kongevej 56', '11112222'),
('A4000', 'Aran', 'Rasmussen', 'Birkevej 12', '22223333'),
('B5000', 'Anna', 'Ibsen', 'Fasangade 34', '33344444'),
('B6000', 'Mark', 'Newman', 'Vesterbrogade 85', '44445555'),
('C7000', 'John', 'Andersen', 'Vesterbrogade 85', '66665555'),
('C8000', 'Robert', 'Duval', 'Nørrebrogade 99', '55557777'),
('C9000', 'Linda', 'Sacks', 'Amagerbrogade 77', '88887777');

INSERT INTO Customer (CustomerID, FirstName, Surname, CustomerAddress, Telephone) VALUES
('C0001', 'Lars', 'Nielsen', 'Søndergade 1', '11111111'),
('C0002', 'Mette', 'Pedersen', 'Bakkevej 2', '22222222'),
('C0003', 'Anders', 'Jensen', 'Skovvej 3', '33333333'),
('C0004', 'Hanne', 'Hansen', 'Fjordvej 4', '44444444'),
('C0005', 'Anne', 'Andersen', 'Strandvej 5', '55555555'),
('C0006', 'Ole', 'Olesen', 'Bredgade 6', '66666666'),
('C0007', 'Lise', 'Larsen', 'Møllevej 7', '77777777');

-- Insert values into Orders table --
INSERT INTO Orders (CustomerID, StoreID, StaffID, TotalPrice, OrderDate, ShippingDate, RequiredDate) VALUES
('C0001', '00000', 'A1000', 1503.30, '2024-03-17', '2024-03-18', '2024-03-19'),
('C0002', '00001', 'A2000', 500.95, '2024-03-17', '2024-03-18', '2024-03-19'),
('C0003', '00002', 'A3000', 1951.89, '2024-03-17', '2024-03-18', '2024-03-19'),
('C0004', '00003', 'A4000', 1499.97, '2024-03-17', '2024-03-18', '2024-03-19'),
('C0005', '00004', 'B5000', 2000.00, '2024-03-17', '2024-03-18', '2024-03-19'),
('C0007', '00000', 'C9000', NULL, '2024-03-17', '2024-03-18', '2024-03-19');

-- Insert values into OrderItem table --
INSERT INTO OrderItem (OrderID, SerialID, OrderQuantity, ProductID, BatchPrice) VALUES
(1, UUID(), 2, '54321', 1001.90),
(1, UUID(), 1, '12345', 200.50),
(2, UUID(), 1, '54321', 500.95),
(3, UUID(), 1, '54322', 749.99),
(3, UUID(), 2, '11111', 701.90),
(4, UUID(), 3, '54323', 1499.97);
