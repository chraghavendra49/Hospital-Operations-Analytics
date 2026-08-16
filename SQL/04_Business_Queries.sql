SELECT COUNT(*) AS TotalAppointments
FROM Appointments;
-------------------------------------------------------------------------------------------
SELECT
    Status,
    COUNT(*) AS AppointmentCount
FROM Appointments
GROUP BY Status
ORDER BY AppointmentCount DESC;
-------------------------------------------------------------------------------------------------
SELECT
    d.DepartmentName,
    COUNT(*) AS TotalAppointments
FROM Appointments a
JOIN Doctors doc
    ON a.DoctorID = doc.DoctorID
JOIN Departments d
    ON doc.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalAppointments DESC;
--------------------------------------------------------------------------------------------------
SELECT
    doc.DoctorName,
    d.DepartmentName,
    COUNT(a.AppointmentID) AS TotalAppointments,
    SUM(CASE WHEN a.Status = 'Completed' THEN 1 ELSE 0 END) AS CompletedAppointments
FROM Doctors doc
JOIN Departments d
    ON doc.DepartmentID = d.DepartmentID
LEFT JOIN Appointments a
    ON doc.DoctorID = a.DoctorID
GROUP BY
    doc.DoctorName,
    d.DepartmentName
ORDER BY TotalAppointments DESC;
---------------------------------------------------------------------------------------------------
SELECT
    SUM(TotalAmount) AS TotalRevenue
FROM Appointments
WHERE Status = 'Completed';
---------------------------------------------------------------------------------------------------
SELECT
    d.DepartmentName,
    COUNT(a.AppointmentID) AS TotalAppointments
FROM Departments d
JOIN Doctors doc
    ON d.DepartmentID = doc.DepartmentID
JOIN Appointments a
    ON doc.DoctorID = a.DoctorID
GROUP BY d.DepartmentName
HAVING COUNT(a.AppointmentID) > 3000
ORDER BY TotalAppointments DESC;
------------------------------------------------------------------------------------------------------
SELECT
    d.DepartmentName,
    COUNT(a.AppointmentID) AS TotalAppointments,
    SUM(CASE
            WHEN a.Status = 'Cancelled' THEN 1
            ELSE 0
        END) AS CancelledAppointments,

    ROUND(
        100.0 * SUM(CASE
                        WHEN a.Status = 'Cancelled' THEN 1
                        ELSE 0
                    END)
        / COUNT(a.AppointmentID),
        2
    ) AS CancellationPercentage

FROM Departments d
JOIN Doctors doc
    ON d.DepartmentID = doc.DepartmentID
JOIN Appointments a
    ON doc.DoctorID = a.DoctorID

GROUP BY d.DepartmentName
ORDER BY CancellationPercentage DESC;
-----------------------------------------------------------------------------------------------
SELECT
    doc.DoctorName,
    d.DepartmentName,
    COUNT(a.AppointmentID) AS CompletedAppointments,

    RANK() OVER
    (
        PARTITION BY d.DepartmentName
        ORDER BY COUNT(a.AppointmentID) DESC
    ) AS DepartmentRank

FROM Doctors doc
JOIN Departments d
    ON doc.DepartmentID = d.DepartmentID
JOIN Appointments a
    ON doc.DoctorID = a.DoctorID

WHERE a.Status = 'Completed'

GROUP BY
    doc.DoctorName,
    d.DepartmentName;
----------------------------------------------------------------------------------------------
SELECT
    YEAR(AppointmentDate) AS AppointmentYear,
    MONTH(AppointmentDate) AS MonthNumber,
    SUM(TotalAmount) AS MonthlyRevenue
FROM Appointments
WHERE Status = 'Completed'
GROUP BY
    YEAR(AppointmentDate),
    MONTH(AppointmentDate)
ORDER BY
    AppointmentYear,
    MonthNumber;

