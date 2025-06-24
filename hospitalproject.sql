create database Hospital1
use Hospital1

CREATE TABLE Doctor (
 DID INT PRIMARY KEY,
 Dname VARCHAR(50),
 specialization VARCHAR(50),
 contact_info VARCHAR(20)
);

CREATE TABLE Departments (
    dep_ID INT PRIMARY KEY,
    Dep_name VARCHAR(50),
    DID INT,
    FOREIGN KEY (DID) REFERENCES Doctor(DID)
);

CREATE TABLE Staff (
    SID INT PRIMARY KEY,
    S_name VARCHAR(50),
    S_type VARCHAR(50),
    assigned_dept VARCHAR(50),
    shift VARCHAR(20),
    DID INT,
    dep_ID INT,
    FOREIGN KEY (DID) REFERENCES Doctor(DID),
    FOREIGN KEY (dep_ID) REFERENCES Departments(dep_ID)
);

CREATE TABLE Patients (
    patient_ID INT PRIMARY KEY,
    Pname VARCHAR(50),
    contact_info VARCHAR(50),
    DOB DATE,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    DID INT,
    FOREIGN KEY (DID) REFERENCES Doctor(DID)
);

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY , 
    A_time TIME NOT NULL,
    A_dat DATE NOT NULL,
    patient_ID INT NOT NULL,
    DID INT NOT NULL,
    FOREIGN KEY (patient_ID) REFERENCES Patients(patient_ID),
    FOREIGN KEY (DID) REFERENCES Doctor(DID)
);

CREATE TABLE Users (
    username VARCHAR(50) PRIMARY KEY,
    role VARCHAR(20) CHECK (role IN ('doctor', 'staff')),
    password VARCHAR(100) NOT NULL,
    DID INT,
    SID INT,
    FOREIGN KEY (DID) REFERENCES Doctor(DID),
    FOREIGN KEY (SID) REFERENCES Staff(SID),
    CHECK (
        (DID IS NOT NULL AND SID IS NULL) OR
        (SID IS NOT NULL AND DID IS NULL)
    )
);

CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY ,
    Diagnosis VARCHAR(100) NOT NULL,
    TreatmentPlans TEXT NOT NULL,
    Date DATE NOT NULL,
    Notes TEXT,
    DID INT NOT NULL,
    patient_ID INT NOT NULL,
    FOREIGN KEY (DID) REFERENCES Doctor(DID),
    FOREIGN KEY (patient_ID) REFERENCES Patients(patient_ID)
);

CREATE TABLE Rooms (
    R_number INT PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    availability VARCHAR(20) CHECK (availability IN ('Available', 'Occupied', 'Maintenance'))
);

CREATE TABLE Billing (
    B_ID INT PRIMARY KEY,
    date DATE NOT NULL,
    services VARCHAR(100) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    patient_ID INT NOT NULL,
    FOREIGN KEY (patient_ID) REFERENCES Patients(patient_ID)
);

CREATE TABLE Patients_room (
    StayID INT PRIMARY KEY , 
    patient_ID INT NOT NULL,
    R_number INT NOT NULL,
    date_in DATE NOT NULL,
    date_out DATE,
    FOREIGN KEY (patient_ID) REFERENCES Patients(patient_ID),
    FOREIGN KEY (R_number) REFERENCES Rooms(R_number)
);


---------insert--------
INSERT INTO Doctor (DID, Dname, specialization, contact_info) VALUES
(1, 'Dr. Khalid', 'Cardiology', '9804723'),
(2, 'Dr. Muna', 'Pediatrics', '99887766'),
(3, 'Dr. Mariam', 'Dermatology', '77889906'),
(4, 'Dr. Salem', 'Orthopedics', '93332211'),
(5, 'Dr. Aisha', 'Neurology', '94455677'),
(6, 'Dr. Fahad', 'ENT', '95566778'),
(7, 'Dr. Huda', 'Gastroenterology', '97788990'),
(8, 'Dr. Nasser', 'Urology', '98811223'),
(9, 'Dr. Reem', 'Ophthalmology', '96677882'),
(10, 'Dr. Tariq', 'Pulmonology', '91122334'),
(11, 'Dr. Noora', 'General Surgery', '92233445'),
(12, 'Dr. Sami', 'Oncology', '93344556'),
(13, 'Dr. Leena', 'Cardiology', '94455667'),
(14, 'Dr. Ahmed', 'Nephrology', '95566789'),
(15, 'Dr. Fatima', 'Psychiatry', '96677880'),
(16, 'Dr. Yousuf', 'Dermatology', '97788991'),
(17, 'Dr. Amal', 'Family Medicine', '98811224'),
(18, 'Dr. Ibrahim', 'Endocrinology', '91122335'),
(19, 'Dr. Wafa', 'Rheumatology', '92233446'),
(20, 'Dr. Zaid', 'Hematology', '93344557');

------
INSERT INTO Departments (dep_ID, Dep_name, DID) VALUES
(1, 'Cardiology', 1),
(2, 'Pediatrics', 2),
(3, 'Dermatology', 3),
(4, 'Orthopedics', 4),
(5, 'Neurology', 5),
(6, 'ENT', 6),
(7, 'Gastroenterology', 7),
(8, 'Urology', 8),
(9, 'Ophthalmology', 9),
(10, 'Pulmonology', 10),
(11, 'General Surgery', 11),
(12, 'Oncology', 12),
(13, 'Nephrology', 13),
(14, 'Psychiatry', 14),
(15, 'Family Medicine', 15),
(16, 'Endocrinology', 16),
(17, 'Rheumatology', 17),
(18, 'Hematology', 18),
(19, 'Emergency Medicine', 19),
(20, 'Anesthesiology', 20);

----
INSERT INTO Staff (SID, S_name, S_type, shift, DID, dep_ID) VALUES
(1, 'Samir', 'Nurse', 'Night', 1, 1),
(2, 'Rania', 'Assistant', 'Morning', 2, 2),
(3, 'Ahmed', 'Nurse', 'Night', 3, 3),
(4, 'Layla', 'Technician', 'Morning', 1, 1),
(5, 'Noura', 'Assistant', 'Evening', 2, 2),
(6, 'Khaled', 'Nurse', 'Morning', 4, 4),
(7, 'Mona', 'Technician', 'Night', 5, 5),
(8, 'Faisal', 'Assistant', 'Evening', 6, 6),
(9, 'Salma', 'Nurse', 'Morning', 7, 7),
(10, 'Omar', 'Technician', 'Night', 8, 8),
(11, 'Huda', 'Assistant', 'Morning', 9, 9),
(12, 'Tariq', 'Nurse', 'Evening', 10, 10),
(13, 'Lina', 'Technician', 'Night', 11, 11),
(14, 'Sami', 'Assistant', 'Morning', 12, 12),
(15, 'Aisha', 'Nurse', 'Evening', 13, 13),
(16, 'Yousef', 'Technician', 'Morning', 14, 14),
(17, 'Fatima', 'Assistant', 'Night', 15, 15),
(18, 'Ibrahim', 'Nurse', 'Morning', 16, 16),
(19, 'Wafa', 'Technician', 'Evening', 17, 17),
(20, 'Zaid', 'Assistant', 'Night', 18, 18);
----
INSERT INTO Patients (patient_ID, Pname, contact_info, DOB, Gender, DID) VALUES
(101, 'Ahmad', '91234567', '1990-05-01', 'M', 1),
(102, 'Salma', '91122334', '1985-11-15', 'F', 2),
(103, 'Mariam', '93322100', '1992-08-21', 'F', 3),
(104, 'Faisal', '99887766', '2000-03-10', 'M', 4),
(105, 'Layla', '91123456', '1995-12-05', 'F', 5),
(106, 'Omar', '91123567', '1988-07-19', 'M', 6),
(107, 'Huda', '91234568', '1993-09-23', 'F', 7),
(108, 'Khaled', '91122335', '1979-02-11', 'M', 8),
(109, 'Noora', '93322000', '1987-06-17', 'F', 9),
(110, 'Sami', '93333000', '1991-10-10', 'M', 10),
(111, 'Rania', '91133456', '1994-04-01', 'F', 11),
(112, 'Yousef', '91133567', '1986-01-22', 'M', 12),
(113, 'Fatima', '91234678', '1990-08-30', 'F', 13),
(114, 'Ibrahim', '91133678', '1998-11-09', 'M', 14),
(115, 'Wafa', '91133789', '1992-03-16', 'F', 15),
(116, 'Zaid', '91234789', '1989-05-25', 'M', 16),
(117, 'Aisha', '91133890', '1995-07-12', 'F', 17),
(118, 'Tariq', '91133901', '1984-09-18', 'M', 18),
(119, 'Lina', '91134012', '1993-01-07', 'F', 19),
(120, 'Nasser', '91134123', '1990-12-21', 'M', 20);
-----
INSERT INTO Appointments (AppointmentID, A_time, A_dat, patient_ID, DID) VALUES
(1, '09:00:00', '2025-06-24', 101, 1),
(2, '10:30:00', '2025-06-24', 102, 2),
(3, '11:15:00', '2025-06-25', 103, 3),
(4, '13:00:00', '2025-06-26', 104, 4),
(5, '14:30:00', '2025-06-26', 105, 5),
(6, '09:15:00', '2025-06-27', 106, 6),
(7, '10:45:00', '2025-06-27', 107, 7),
(8, '11:30:00', '2025-06-28', 108, 8),
(9, '13:15:00', '2025-06-29', 109, 9),
(10, '14:45:00', '2025-06-29', 110, 10),
(11, '09:30:00', '2025-06-30', 111, 11),
(12, '10:50:00', '2025-06-30', 112, 12),
(13, '11:40:00', '2025-07-01', 113, 13),
(14, '13:20:00', '2025-07-02', 114, 14),
(15, '14:55:00', '2025-07-02', 115, 15),
(16, '09:45:00', '2025-07-03', 116, 16),
(17, '10:55:00', '2025-07-03', 117, 17),
(18, '11:50:00', '2025-07-04', 118, 18),
(19, '13:30:00', '2025-07-05', 119, 19),
(20, '14:59:00', '2025-07-05', 120, 20);
------
INSERT INTO Appointments (AppointmentID, A_time, A_dat, patient_ID, DID) VALUES
(21, '09:00:00', '2025-07-06', 101, 1),
(22, '10:30:00', '2025-07-06', 102, 2),
(23, '11:00:00', '2025-07-07', 103, 3),
(24, '12:00:00', '2025-07-07', 104, 4),
(25, '13:00:00', '2025-07-08', 105, 5),
(26, '14:00:00', '2025-07-08', 106, 6),
(27, '15:00:00', '2025-07-09', 107, 7),
(28, '09:30:00', '2025-07-09', 108, 8),
(29, '10:30:00', '2025-07-10', 109, 9),
(30, '11:30:00', '2025-07-10', 110, 10),
(31, '12:30:00', '2025-07-11', 111, 11),
(32, '13:30:00', '2025-07-11', 112, 12),
(33, '14:30:00', '2025-07-12', 113, 13),
(34, '15:30:00', '2025-07-12', 114, 14),
(35, '09:00:00', '2025-07-13', 115, 15),
(36, '10:00:00', '2025-07-13', 116, 16),
(37, '11:00:00', '2025-07-14', 117, 17),
(38, '12:00:00', '2025-07-14', 118, 18),
(39, '13:00:00', '2025-07-15', 119, 19),
(40, '14:00:00', '2025-07-15', 120, 20);

----
INSERT INTO Users (username, role, password, DID, SID) VALUES
('ahmad_doc', 'doctor', 'pass123', 1, NULL),
('muna_doc', 'doctor', 'pass234', 2, NULL),
('mariam_doc', 'doctor', 'pass345', 3, NULL),
('salem_doc', 'doctor', 'pass456', 4, NULL),
('aisha_doc', 'doctor', 'pass567', 5, NULL),
('fahad_doc', 'doctor', 'pass678', 6, NULL),
('huda_doc', 'doctor', 'pass789', 7, NULL),
('nasser_doc', 'doctor', 'pass890', 8, NULL),
('reem_doc', 'doctor', 'pass901', 9, NULL),
('tariq_doc', 'doctor', 'pass012', 10, NULL),
('samir_staff', 'staff', 'staff123', NULL, 1),
('rania_staff', 'staff', 'staff234', NULL, 2),
('ahmed_staff', 'staff', 'staff345', NULL, 3),
('layla_staff', 'staff', 'staff456', NULL, 4),
('noura_staff', 'staff', 'staff567', NULL, 5),
('khaled_staff', 'staff', 'staff678', NULL, 6),
('mona_staff', 'staff', 'staff789', NULL, 7),
('faisal_staff', 'staff', 'staff890', NULL, 8),
('salma_staff', 'staff', 'staff901', NULL, 9),
('omar_staff', 'staff', 'staff012', NULL, 10);
--
INSERT INTO MedicalRecords (RecordID, Diagnosis, TreatmentPlans, Date, Notes, DID, patient_ID) VALUES
(1, 'Flu', 'Rest and hydration', '2025-06-24', 'Mild symptoms', 1, 101),
(2, 'Diabetes', 'Insulin therapy', '2025-06-25', 'Monitor blood sugar', 2, 102),
(3, 'Skin Rash', 'Topical ointment', '2025-06-26', 'Check for allergies', 3, 103),
(4, 'Fracture', 'Cast application', '2025-06-27', 'Follow-up in 2 weeks', 4, 104),
(5, 'Migraine', 'Pain management', '2025-06-28', 'Avoid triggers', 5, 105),
(6, 'Sinusitis', 'Antibiotics', '2025-06-29', 'Complete full course', 6, 106),
(7, 'Hypertension', 'Lifestyle changes', '2025-06-30', 'Regular checkups', 7, 107),
(8, 'Urinary Tract Infection', 'Antibiotics', '2025-07-01', 'Drink plenty of fluids', 8, 108),
(9, 'Cataract', 'Surgery planned', '2025-07-02', 'Pre-op assessment', 9, 109),
(10, 'Asthma', 'Inhaler use', '2025-07-03', 'Avoid allergens', 10, 110),
(11, 'Appendicitis', 'Surgical removal', '2025-07-04', 'Monitor recovery', 11, 111),
(12, 'Cancer', 'Chemotherapy', '2025-07-05', 'Side effects monitored', 12, 112),
(13, 'Kidney Stones', 'Hydration and meds', '2025-07-06', 'Dietary advice', 13, 113),
(14, 'Depression', 'Therapy and meds', '2025-07-07', 'Regular follow-ups', 14, 114),
(15, 'Flu', 'Rest and fluids', '2025-07-08', 'Mild case', 15, 115),
(16, 'Eczema', 'Topical creams', '2025-07-09', 'Avoid irritants', 16, 116),
(17, 'Common Cold', 'Rest', '2025-07-10', 'Hydrate well', 17, 117),
(18, 'Diabetes', 'Diet control', '2025-07-11', 'Regular monitoring', 18, 118),
(19, 'Arthritis', 'Physical therapy', '2025-07-12', 'Pain management', 19, 119),
(20, 'Anemia', 'Iron supplements', '2025-07-13', 'Monitor levels', 20, 120);

-----
INSERT INTO Rooms (R_number, type, availability) VALUES
(101, 'ICU', 'Available'),
(102, 'Surgery', 'Occupied'),
(103, 'Consultation', 'Available'),
(104, 'ICU', 'Maintenance'),
(105, 'General Ward', 'Available'),
(106, 'Recovery', 'Occupied'),
(107, 'Pediatrics', 'Available'),
(108, 'Maternity', 'Available'),
(109, 'Radiology', 'Occupied'),
(110, 'Laboratory', 'Available'),
(111, 'Pharmacy', 'Available'),
(112, 'Physiotherapy', 'Occupied'),
(113, 'Dialysis', 'Available'),
(114, 'Oncology', 'Available'),
(115, 'Emergency', 'Occupied'),
(116, 'Psychiatry', 'Available'),
(117, 'Neurology', 'Available'),
(118, 'Dermatology', 'Occupied'),
(119, 'Cardiology', 'Available'),
(120, 'ENT', 'Available');

---
INSERT INTO Billing (B_ID, date, services, total, patient_ID) VALUES
(1, '2025-06-24', 'Consultation', 50.00, 101),
(2, '2025-06-25', 'X-Ray', 150.00, 102),
(3, '2025-06-26', 'Medication', 75.00, 103),
(4, '2025-06-27', 'Surgery', 2000.00, 104),
(5, '2025-06-28', 'Blood Test', 40.00, 105),
(6, '2025-06-29', 'MRI', 500.00, 106),
(7, '2025-06-30', 'Physiotherapy', 120.00, 107),
(8, '2025-07-01', 'Consultation', 50.00, 108),
(9, '2025-07-02', 'CT Scan', 600.00, 109),
(10, '2025-07-03', 'Ultrasound', 200.00, 110),
(11, '2025-07-04', 'Vaccination', 30.00, 111),
(12, '2025-07-05', 'Dental Cleaning', 80.00, 112),
(13, '2025-07-06', 'Eye Exam', 60.00, 113),
(14, '2025-07-07', 'Surgery', 2500.00, 114),
(15, '2025-07-08', 'Medication', 90.00, 115),
(16, '2025-07-09', 'Consultation', 50.00, 116),
(17, '2025-07-10', 'Blood Test', 40.00, 117),
(18, '2025-07-11', 'MRI', 550.00, 118),
(19, '2025-07-12', 'Physiotherapy', 130.00, 119),
(20, '2025-07-13', 'Vaccination', 35.00, 120);


---
INSERT INTO Patients_room (StayID, patient_ID, R_number, date_in, date_out) VALUES
(1, 101, 101, '2025-06-20', '2025-06-24'),
(2, 102, 103, '2025-06-22', '2025-06-25'),
(3, 103, 101, '2025-06-25', '2025-06-28'),
(4, 104, 102, '2025-06-21', '2025-06-27'),
(5, 105, 105, '2025-06-23', '2025-06-29'),
(6, 106, 106, '2025-06-24', '2025-06-30'),
(7, 107, 107, '2025-06-25', '2025-07-01'),
(8, 108, 108, '2025-06-26', '2025-07-02'),
(9, 109, 109, '2025-06-27', '2025-07-03'),
(10, 110, 110, '2025-06-28', '2025-07-04'),
(11, 111, 111, '2025-06-29', '2025-07-05'),
(12, 112, 112, '2025-06-30', '2025-07-06'),
(13, 113, 113, '2025-07-01', '2025-07-07'),
(14, 114, 114, '2025-07-02', '2025-07-08'),
(15, 115, 115, '2025-07-03', '2025-07-09'),
(16, 116, 116, '2025-07-04', '2025-07-10'),
(17, 117, 117, '2025-07-05', '2025-07-11'),
(18, 118, 118, '2025-07-06', '2025-07-12'),
(19, 119, 119, '2025-07-07', '2025-07-13'),
(20, 120, 120, '2025-07-08', '2025-07-14');


-----Queries to Test (DQL)----
--List all patients who visited a certain doctor. 
SELECT DISTINCT p.patient_ID, p.Pname, p.contact_info
FROM Patients p
JOIN Appointments a ON p.patient_ID = a.patient_ID
WHERE a.DID = 1;

--Count of appointments per department.
SELECT d.Dep_name, COUNT(a.AppointmentID) AS AppointmentCount
FROM Appointments a
JOIN Doctor doc ON a.DID = doc.DID
JOIN Departments d ON doc.DID = d.DID
GROUP BY d.Dep_name;

-- Retrieve doctors who have more than 5 appointments in a month.
SELECT doc.DID, doc.Dname, COUNT(a.AppointmentID) AS AppointmentCount
FROM Appointments a
JOIN Doctor doc ON a.DID = doc.DID
WHERE MONTH(a.A_dat) = 6 AND YEAR(a.A_dat) = 2025
GROUP BY doc.DID, doc.Dname
HAVING COUNT(a.AppointmentID) > 5;

--Use JOINs across 3–4 tables.
SELECT 
    p.Pname, 
    a.A_time, a.A_dat, 
    doc.Dname, 
    dep.Dep_name
FROM Patients p
JOIN Appointments a ON p.patient_ID = a.patient_ID
JOIN Doctor doc ON a.DID = doc.DID
JOIN Departments dep ON doc.DID = dep.DID
WHERE a.A_dat BETWEEN '2025-06-01' AND '2025-06-30'
ORDER BY a.A_dat, a.A_time;

--Use GROUP BY, HAVING, and aggregate functions.
SELECT doc.Dname, COUNT(DISTINCT a.patient_ID) AS NumberOfPatients
FROM Appointments a
JOIN Doctor doc ON a.DID = doc.DID
WHERE YEAR(a.A_dat) = 2025
GROUP BY doc.Dname
HAVING COUNT(DISTINCT a.patient_ID) > 10;

--Use SUBQUERIES and EXISTS.
SELECT Dname
FROM Doctor doc
WHERE EXISTS (
    SELECT 1
    FROM Appointments a
    WHERE a.DID = doc.DID
    AND a.patient_ID = 101
);


---Functions & Stored Procedures---
--Scalar function to calculate patient age from DOB.
CREATE FUNCTION dbo.CalculateAge(@DOB DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @DOB, GETDATE())
    - CASE 
     WHEN DATEADD(YEAR, DATEDIFF(YEAR, @DOB, GETDATE()), @DOB) > GETDATE() THEN 1
     ELSE 0
     END;
END;

SELECT Pname, dbo.CalculateAge(DOB) AS Age FROM Patients;

--Stored procedure to admit a patient (insert to Admissions, update Room availability). 
 CREATE PROCEDURE dbo.AdmitPatient
    @patient_ID INT,
    @R_number INT,
    @date_in DATE
AS
BEGIN
    BEGIN TRANSACTION;

    
    INSERT INTO Patients_room (StayID, patient_ID, R_number, date_in, date_out)
    VALUES ((SELECT ISNULL(MAX(StayID), 0) + 1 FROM Patients_room), @patient_ID, @R_number, @date_in, NULL);

    UPDATE Rooms
    SET availability = 'Occupied'
    WHERE R_number = @R_number;

    COMMIT TRANSACTION;
END;

--Procedure to generate invoice (insert into Billing based on treatments).
CREATE PROCEDURE dbo.GenerateInvoice
    @B_ID INT,
    @date DATE,
    @services VARCHAR(100),
    @total DECIMAL(10,2),
    @patient_ID INT
AS
BEGIN
    INSERT INTO Billing (B_ID, date, services, total, patient_ID)
    VALUES (@B_ID, @date, @services, @total, @patient_ID);
END;

--Procedure to assign doctor to department and shift.
CREATE PROCEDURE dbo.AssignDoctorToDeptShift
    @DID INT,
    @dep_ID INT,
    @shift VARCHAR(20)
AS
BEGIN
    UPDATE Staff
    SET dep_ID = @dep_ID,
        shift = @shift
    WHERE DID = @DID;
END;


-- Triggers--
--After insert on Appointments → auto log in MedicalRecords.
CREATE TRIGGER trg_AfterInsertAppointment
ON Appointments
AFTER INSERT
AS
BEGIN
    INSERT INTO MedicalRecords (RecordID, Diagnosis, TreatmentPlans, Date, Notes, DID, patient_ID)
    SELECT 
        (SELECT ISNULL(MAX(RecordID), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) 
         FROM MedicalRecords),
        'Pending Diagnosis',           
        'To be updated by doctor',    
        GETDATE(),                     
        NULL,                        
        i.DID,
        i.patient_ID
    FROM inserted i;
END;

--Before delete on Patients → prevent deletion if pending bills exist.
CREATE TRIGGER trg_PreventDeleteIfBillsExist
ON Patients
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM Billing b
        JOIN deleted d ON b.patient_ID = d.patient_ID
    )
    BEGIN
        RAISERROR('Cannot delete patient: Pending bills exist.', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        DELETE FROM Patients
        WHERE patient_ID IN (SELECT patient_ID FROM deleted);
    END
END;


--After update on Rooms → ensure no two patients occupy same room.
CREATE TRIGGER trg_PreventRoomConflict
ON Patients_room
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT R_number
        FROM Patients_room
        WHERE date_out IS NULL
        GROUP BY R_number
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR('Room conflict: More than one active patient in the same room.', 16, 1);
        ROLLBACK;
    END
END;


---Security (DCL)--
--Create at least two user roles: DoctorUser, AdminUser. 
--Add rollback logic in case of failure.
CREATE ROLE DoctorUser;
CREATE ROLE AdminUser;

CREATE USER DrAhmed FOR LOGIN DrAhmedLogin;
EXEC sp_addrolemember 'DoctorUser', 'DrAhmed';

CREATE USER AdminSara FOR LOGIN AdminSaraLogin;
EXEC sp_addrolemember 'AdminUser', 'AdminSara';


-- GRANT SELECT for DoctorUser on Patients and Appointments only. 
GRANT SELECT ON Patients TO DoctorUser;
GRANT SELECT ON Appointments TO DoctorUser;


-- GRANT INSERT, UPDATE for AdminUser on all tables. 

GRANT INSERT, UPDATE ON Patients TO AdminUser;
GRANT INSERT, UPDATE ON Appointments TO AdminUser;
GRANT INSERT, UPDATE ON Billing TO AdminUser;
GRANT INSERT, UPDATE ON Rooms TO AdminUser;
GRANT INSERT, UPDATE ON Departments TO AdminUser;
GRANT INSERT, UPDATE ON Staff TO AdminUser;
GRANT INSERT, UPDATE ON Doctor TO AdminUser;
GRANT INSERT, UPDATE ON MedicalRecords TO AdminUser;
GRANT INSERT, UPDATE ON Patients_room TO AdminUser;
GRANT INSERT, UPDATE ON Users TO AdminUser;

-- REVOKE DELETE for Doctors
REVOKE DELETE ON Patients TO DoctorUser;
REVOKE DELETE ON Appointments TO DoctorUser;
REVOKE DELETE ON MedicalRecords TO DoctorUser;
REVOKE DELETE ON Billing TO DoctorUser;
REVOKE DELETE ON Staff TO DoctorUser;
REVOKE DELETE ON Rooms TO DoctorUser;
REVOKE DELETE ON Departments TO DoctorUser;

--Transactions (TCL)--
BEGIN TRY
    BEGIN TRANSACTION;

    DECLARE @patient_ID INT = 101;
    DECLARE @R_number INT = 105;
    DECLARE @StayID INT = (SELECT ISNULL(MAX(StayID), 0) + 1 FROM Patients_room);
    DECLARE @B_ID INT = (SELECT ISNULL(MAX(B_ID), 0) + 1 FROM Billing);
    DECLARE @today DATE = GETDATE();

 
    INSERT INTO Patients_room (StayID, patient_ID, R_number, date_in, date_out)
    VALUES (@StayID, @patient_ID, @R_number, @today, NULL);


    UPDATE Rooms
    SET availability = 'Occupied'
    WHERE R_number = @R_number;

   
    INSERT INTO Billing (B_ID, date, services, total, patient_ID)
    VALUES (@B_ID, @today, 'Admission Fee', 100.00, @patient_ID);

   
    COMMIT;
    PRINT 'Transaction committed successfully.';

END TRY
BEGIN CATCH
  
    ROLLBACK;

    PRINT 'Transaction failed and rolled back.';
    PRINT ERROR_MESSAGE();
END CATCH;

---Views--- 
--vw_DoctorSchedule: Upcoming appointments per doctor.
CREATE VIEW vw_DoctorSchedule AS
SELECT 
    d.DID,
    d.Dname,
    a.patient_ID,
    p.Pname,
    a.A_dat AS AppointmentDate,
    a.A_time AS AppointmentTime
FROM Doctor d
JOIN Appointments a ON d.DID = a.DID
JOIN Patients p ON a.patient_ID = p.patient_ID
WHERE a.A_dat >= CAST(GETDATE() AS DATE);

--vw_PatientSummary: Patient info with their latest visit.
CREATE VIEW vw_PatientSummary AS
SELECT 
    p.patient_ID,
    p.Pname,
    p.Gender,
    p.contact_info,
    MAX(a.A_dat) AS LastVisitDate
FROM Patients p
LEFT JOIN Appointments a ON p.patient_ID = a.patient_ID
GROUP BY p.patient_ID, p.Pname, p.Gender, p.contact_info;

-- vw_DepartmentStats: Number of doctors and patients per department.
CREATE VIEW vw_DepartmentStats AS
SELECT 
    dep.dep_ID,
    dep.Dep_name,
    COUNT(DISTINCT doc.DID) AS DoctorCount,
    COUNT(DISTINCT pat.patient_ID) AS PatientCount
FROM Departments dep
LEFT JOIN Doctor doc ON dep.DID = doc.DID
LEFT JOIN Patients pat ON doc.DID = pat.DID
GROUP BY dep.dep_ID, dep.Dep_name;
