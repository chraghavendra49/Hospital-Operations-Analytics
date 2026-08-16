USE HospitalAnalytics;

CREATE TABLE Departments
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);

CREATE TABLE Doctors
(
    DoctorID INT PRIMARY KEY,
    DoctorName VARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,
    Specialization VARCHAR(100),
    ExperienceYears INT,
    ConsultationFee DECIMAL(10,2),

    CONSTRAINT FK_Doctors_Departments
        FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);

CREATE TABLE Patients
(
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(100) NOT NULL,
    Gender VARCHAR(20),
    DateOfBirth DATE,
    Phone VARCHAR(20),
    City VARCHAR(100),
    RegistrationDate DATE
);

CREATE TABLE Appointments
(
    AppointmentID INT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME,
    Status VARCHAR(30),
    TotalAmount DECIMAL(10,2),

    CONSTRAINT FK_Appointments_Patients
        FOREIGN KEY (PatientID)
        REFERENCES Patients(PatientID),

    CONSTRAINT FK_Appointments_Doctors
        FOREIGN KEY (DoctorID)
        REFERENCES Doctors(DoctorID)
);

CREATE TABLE Bills
(
    BillID INT PRIMARY KEY,
    AppointmentID INT NOT NULL,
    BillDate DATE NOT NULL,
    ConsultationAmount DECIMAL(10,2),
    MedicineAmount DECIMAL(10,2),
    TestAmount DECIMAL(10,2),
    TotalAmount AS
        (ConsultationAmount + MedicineAmount + TestAmount) PERSISTED,
    PaymentStatus VARCHAR(30),

    CONSTRAINT FK_Bills_Appointments
        FOREIGN KEY (AppointmentID)
        REFERENCES Appointments(AppointmentID)
);