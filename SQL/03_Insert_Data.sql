INSERT INTO Departments
    (DepartmentID, DepartmentName, Location)
VALUES
    (1, 'Cardiology', 'Block A'),
    (2, 'Neurology', 'Block A'),
    (3, 'Orthopedics', 'Block B'),
    (4, 'Pediatrics', 'Block B'),
    (5, 'Dermatology', 'Block C'),
    (6, 'General Medicine', 'Block C'),
    (7, 'ENT', 'Block D'),
    (8, 'Ophthalmology', 'Block D'),
    (9, 'Gynecology', 'Block E'),
    (10, 'Urology', 'Block E'),
    (11, 'Oncology', 'Block F'),
    (12, 'Gastroenterology', 'Block F'),
    (13, 'Pulmonology', 'Block G'),
    (14, 'Psychiatry', 'Block G'),
    (15, 'Emergency Medicine', 'Block H');
select * from Departments


;WITH Numbers AS
(
    SELECT TOP (100)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)
INSERT INTO Doctors
(
    DoctorID,
    DoctorName,
    DepartmentID,
    Specialization,
    ExperienceYears,
    ConsultationFee
)
SELECT
    n AS DoctorID,

    'Dr. ' +
    CASE ((n - 1) % 20) + 1
        WHEN 1 THEN 'Arjun Rao'
        WHEN 2 THEN 'Priya Sharma'
        WHEN 3 THEN 'Rahul Reddy'
        WHEN 4 THEN 'Ananya Patel'
        WHEN 5 THEN 'Vikram Singh'
        WHEN 6 THEN 'Sneha Kumar'
        WHEN 7 THEN 'Kiran Verma'
        WHEN 8 THEN 'Neha Reddy'
        WHEN 9 THEN 'Amit Shah'
        WHEN 10 THEN 'Pooja Rao'
        WHEN 11 THEN 'Sandeep Kumar'
        WHEN 12 THEN 'Divya Singh'
        WHEN 13 THEN 'Manoj Patel'
        WHEN 14 THEN 'Kavya Sharma'
        WHEN 15 THEN 'Rohit Reddy'
        WHEN 16 THEN 'Meera Nair'
        WHEN 17 THEN 'Aditya Rao'
        WHEN 18 THEN 'Swathi Kumar'
        WHEN 19 THEN 'Nikhil Verma'
        WHEN 20 THEN 'Lakshmi Reddy'
    END
    + ' ' + CAST(n AS VARCHAR(10)),

    ((n - 1) % 15) + 1,

    CASE ((n - 1) % 15) + 1
        WHEN 1 THEN 'Cardiologist'
        WHEN 2 THEN 'Neurologist'
        WHEN 3 THEN 'Orthopedic Specialist'
        WHEN 4 THEN 'Pediatrician'
        WHEN 5 THEN 'Dermatologist'
        WHEN 6 THEN 'General Physician'
        WHEN 7 THEN 'ENT Specialist'
        WHEN 8 THEN 'Ophthalmologist'
        WHEN 9 THEN 'Gynecologist'
        WHEN 10 THEN 'Urologist'
        WHEN 11 THEN 'Oncologist'
        WHEN 12 THEN 'Gastroenterologist'
        WHEN 13 THEN 'Pulmonologist'
        WHEN 14 THEN 'Psychiatrist'
        WHEN 15 THEN 'Emergency Physician'
    END,

    2 + (ABS(CHECKSUM(NEWID())) % 24),

    500 + (ABS(CHECKSUM(NEWID())) % 11) * 100
FROM Numbers;



;WITH Numbers AS
(
    SELECT TOP (10000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)
INSERT INTO Patients
(
    PatientID,
    PatientName,
    Gender,
    DateOfBirth,
    Phone,
    City,
    RegistrationDate
)
SELECT
    n AS PatientID,

    'Patient ' + CAST(n AS VARCHAR(10)) AS PatientName,

    CASE
        WHEN n % 2 = 0 THEN 'Male'
        ELSE 'Female'
    END AS Gender,

    DATEADD(
        DAY,
        -(18 * 365 + ABS(CHECKSUM(NEWID())) % (62 * 365)),
        CAST(GETDATE() AS DATE)
    ) AS DateOfBirth,

    '9' + RIGHT(
        '000000000' + CAST(
            100000000 + ABS(CHECKSUM(NEWID())) % 900000000
            AS VARCHAR(9)
        ),
        9
    ) AS Phone,

    CASE (n % 10)
        WHEN 0 THEN 'Hyderabad'
        WHEN 1 THEN 'Bangalore'
        WHEN 2 THEN 'Chennai'
        WHEN 3 THEN 'Mumbai'
        WHEN 4 THEN 'Delhi'
        WHEN 5 THEN 'Pune'
        WHEN 6 THEN 'Kolkata'
        WHEN 7 THEN 'Vijayawada'
        WHEN 8 THEN 'Visakhapatnam'
        WHEN 9 THEN 'Warangal'
    END AS City,

    DATEADD(
        DAY,
        -(ABS(CHECKSUM(NEWID())) % 1500),
        CAST(GETDATE() AS DATE)
    ) AS RegistrationDate

FROM Numbers;


;WITH Numbers AS
(
    SELECT TOP (50000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)
INSERT INTO Appointments
(
    AppointmentID,
    PatientID,
    DoctorID,
    AppointmentDate,
    AppointmentTime,
    Status,
    TotalAmount
)
SELECT
    n AS AppointmentID,

    -- Patient between 1 and 10,000
    ((n - 1) % 10000) + 1 AS PatientID,

    -- Doctor between 1 and 100
    ((n - 1) % 100) + 1 AS DoctorID,

    -- Appointment dates over the last 2 years
    DATEADD(
        DAY,
        -(ABS(CHECKSUM(NEWID())) % 730),
        CAST(GETDATE() AS DATE)
    ) AS AppointmentDate,

    -- Appointment time between 9 AM and 5 PM
    DATEADD(
        MINUTE,
        (ABS(CHECKSUM(NEWID())) % 480),
        CAST('09:00:00' AS TIME)
    ) AS AppointmentTime,

    -- Appointment status
    CASE
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 70 THEN 'Completed'
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 85 THEN 'Cancelled'
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 95 THEN 'Pending'
        ELSE 'No Show'
    END AS Status,

    -- Consultation amount
    500 + (ABS(CHECKSUM(NEWID())) % 11) * 100 AS TotalAmount

FROM Numbers;

SELECT TOP 10
    a.AppointmentID,
    p.PatientName,
    d.DoctorName,
    dep.DepartmentName,
    a.AppointmentDate,
    a.Status,
    a.TotalAmount
FROM Appointments a
JOIN Patients p
    ON a.PatientID = p.PatientID
JOIN Doctors d
    ON a.DoctorID = d.DoctorID
JOIN Departments dep
    ON d.DepartmentID = dep.DepartmentID
ORDER BY a.AppointmentID;