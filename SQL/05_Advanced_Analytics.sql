SELECT
    YEAR(AppointmentDate) AS RevenueYear,
    MONTH(AppointmentDate) AS MonthNumber,
    SUM(TotalAmount) AS MonthlyRevenue
FROM Appointments
WHERE Status = 'Completed'
GROUP BY
    YEAR(AppointmentDate),
    MONTH(AppointmentDate)
ORDER BY
    RevenueYear,
    MonthNumber;
---------------------------------------------------
WITH MonthlyRevenue AS
(
    SELECT
        YEAR(AppointmentDate) AS RevenueYear,
        MONTH(AppointmentDate) AS MonthNumber,
        SUM(TotalAmount) AS MonthlyRevenue
    FROM Appointments
    WHERE Status = 'Completed'
    GROUP BY
        YEAR(AppointmentDate),
        MONTH(AppointmentDate)
)
SELECT
    RevenueYear,
    MonthNumber,
    MonthlyRevenue,

    LAG(MonthlyRevenue) OVER
    (
        ORDER BY RevenueYear, MonthNumber
    ) AS PreviousMonthRevenue,

    MonthlyRevenue -
    LAG(MonthlyRevenue) OVER
    (
        ORDER BY RevenueYear, MonthNumber
    ) AS RevenueChange

FROM MonthlyRevenue
ORDER BY
    RevenueYear,
    MonthNumber;
    --------------------------------------------
