-- =====================================================
-- Seed Data
-- Project : Public Transportation Analytics
-- Focus   : TransJakarta Corridor 9
-- Purpose : Populate database with dummy data
--           for analysis and visualization
-- =====================================================

-- =====================
-- ROUTES
-- =====================
INSERT INTO routes (corridor_code, corridor_name)
VALUES ('9', 'TransJakarta Corridor 9');

-- =====================
-- VEHICLES
-- =====================
INSERT INTO vehicles (route_id, vehicle_code, capacity) VALUES
(1, 'TJ9-01', 80),
(1, 'TJ9-02', 80),
(1, 'TJ9-03', 80);

-- =====================
-- STOPS (INBOUND)
-- =====================
-- Pluit → Pinang Ranti
INSERT INTO stops (stop_name, stop_sequence, direction) VALUES
('Pluit', 1, 'INBOUND'),
('Penjaringan', 2, 'INBOUND'),
('Jembatan Tiga', 3, 'INBOUND'),
('Jembatan Dua', 4, 'INBOUND'),
('Jembatan Besi', 5, 'INBOUND'),
('Kali Grogol', 6, 'INBOUND'),
('Grogol Reformasi', 7, 'INBOUND'),
('Tanjung Duren', 8, 'INBOUND'),
('Kota Bambu', 9, 'INBOUND'),
('Kemanggisan', 10, 'INBOUND'),
('Petamburan', 11, 'INBOUND'),
('Senayan', 12, 'INBOUND'),
('Semanggi', 13, 'INBOUND'),
('Widya Chandra', 14, 'INBOUND'),
('Denpasar', 15, 'INBOUND'),
('Simpang Kuningan', 16, 'INBOUND'),
('Tegal Parang', 17, 'INBOUND'),
('Pancoran', 18, 'INBOUND'),
('Pancoran Tugu', 19, 'INBOUND'),
('Tebet Eco Park', 20, 'INBOUND'),
('Cikoko', 21, 'INBOUND'),
('Ciliwung', 22, 'INBOUND'),
('Cawang', 23, 'INBOUND'),
('BNN', 24, 'INBOUND'),
('Cawang Sentral', 25, 'INBOUND'),
('Makasar', 26, 'INBOUND'),
('Pinang Ranti', 27, 'INBOUND');


-- =====================
-- STOPS (OUTBOUND)
-- =====================
-- Pinang Ranti → Pluit 
INSERT INTO stops (stop_name, stop_sequence, direction) VALUES
('Pinang Ranti', 1, 'OUTBOUND'),
('Makasar', 2, 'OUTBOUND'),
('Cawang Sentral', 3, 'OUTBOUND'),
('BNN', 4, 'OUTBOUND'),
('Cawang', 5, 'OUTBOUND'),
('Ciliwung', 6, 'OUTBOUND'),
('Cikoko', 7, 'OUTBOUND'),
('Tebet Eco Park', 8, 'OUTBOUND'),
('Pancoran Tugu', 9, 'OUTBOUND'),
('Pancoran', 10, 'OUTBOUND'),
('Tegal Parang', 11, 'OUTBOUND'),
('Simpang Kuningan', 12, 'OUTBOUND'),
('Denpasar', 13, 'OUTBOUND'),
('Widya Chandra', 14, 'OUTBOUND'),
('Semanggi', 15, 'OUTBOUND'),
('Senayan', 16, 'OUTBOUND'),
('Petamburan', 17, 'OUTBOUND'),
('Kemanggisan', 18, 'OUTBOUND'),
('Kota Bambu', 19, 'OUTBOUND'),
('Tanjung Duren', 20, 'OUTBOUND'),
('Grogol Reformasi', 21, 'OUTBOUND'),
('Kali Grogol', 22, 'OUTBOUND'),
('Jembatan Besi', 23, 'OUTBOUND'),
('Jembatan Dua', 24, 'OUTBOUND'),
('Jembatan Tiga', 25, 'OUTBOUND'),
('Penjaringan', 26, 'OUTBOUND'),
('Pluit', 27, 'OUTBOUND');
