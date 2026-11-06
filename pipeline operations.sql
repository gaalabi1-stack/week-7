-- 1 pipeline_operations table
CREATE TABLE pipeline_operations (
    operation_id INT PRIMARY KEY,
    date VARCHAR(10),
    flow_rate_bpd INT,
    pressure_bar INT,
    operating_hours INT
);

-- Inserting records into pipeline_operations
INSERT INTO pipeline_operations (operation_id, date, flow_rate_bpd, pressure_bar, operating_hours) VALUES
(1, '01-Sep', 10000, 72, 24),
(2, '02-Sep', 10500, 74, 24),
(3, '03-Sep', 9800, 71, 23),
(4, '04-Sep', 10200, 73, 24),
(5, '05-Sep', 7500, 68, 18),
(6, '06-Sep', 10300, 74, 24),
(7, '07-Sep', 10100, 72, 24),
(8, '08-Sep', 9700, 70, 23),
(9, '09-Sep', 10400, 75, 24),
(10, '10-Sep', 7600, 67, 18);

-- Create daily_incidents table
CREATE TABLE daily_incidents (
    incident_id INT PRIMARY KEY,
    operation_id INT,
    incident_type VARCHAR(50),
    downtime_hours INT,
    FOREIGN KEY (operation_id) REFERENCES pipeline_operations(operation_id)
);

-- Insert records into daily_incidents
INSERT INTO daily_incidents (incident_id, operation_id, incident_type, downtime_hours) VALUES
(1, 5, 'Equipment inspection', 6),
(2, 10, 'Pump interruption', 6);

-- 2 Filter Low Flow Rates (< 9,000 bpd)
SELECT date, flow_rate_bpd, pressure_bar, operating_hours
FROM pipeline_operations
WHERE flow_rate_bpd < 9000;


-- 3 Summary Statistics
SELECT 
    AVG(flow_rate_bpd) AS avg_flow_rate,
    MAX(flow_rate_bpd) AS max_flow_rate,
    MIN(flow_rate_bpd) AS min_flow_rate,
    AVG(pressure_bar) AS avg_pressure
FROM pipeline_operations;

-- 4 LEFT JOIN Operations and Incidents
SELECT 
    p.operation_id,
    p.date,
    p.flow_rate_bpd,
    p.pressure_bar,
    p.operating_hours,
    i.incident_type,
    i.downtime_hours
FROM pipeline_operations p
LEFT JOIN daily_incidents i ON p.operation_id = i.operation_id;


