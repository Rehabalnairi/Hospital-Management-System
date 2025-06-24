
This SQL Server project models a Hospital Management System, supporting functionalities such as patient admissions, billing, room assignments, doctor schedules, and department management.

🗃️ Main Components
🔧 Tables
Patients, Doctors, Appointments, Departments, Rooms, Billing, Patients_room, MedicalRecords, Staff, Users

📄 Views
vw_DoctorSchedule: Upcoming appointments per doctor

vw_PatientSummary: Patient info with their latest visit

vw_DepartmentStats: Doctors & patients count per department

⚙️ Stored Procedures
AdmitPatient: Insert admission, update room status

GenerateInvoice: Create billing for a patient

AssignDoctorToDeptShift: Assign doctor to department and shift

➕ Functions
CalculateAge(@DOB): Returns age based on DOB

🚦 Triggers
After insert on Appointments → auto-log in MedicalRecords

Before delete on Patients → prevent deletion if bills exist

After update on Patients_room → prevent duplicate room occupancy

🔐 Security (Roles & Permissions)
Role DoctorUser: Read-only on Patients, Appointments

Role AdminUser: Full insert/update on all tables

DELETE revoked from DoctorUser

💡 Transaction Example
Patient admission process (multi-step transaction):

Insert into Patients_room

Update Rooms availability

Insert into Billing

Uses TRY...CATCH with ROLLBACK on failure

📦 How to Run
Create all tables using the provided scripts.

Insert sample data (20+ records per table recommended).

Create views, triggers, procedures, and functions.

Use roles to assign permissions as needed.

