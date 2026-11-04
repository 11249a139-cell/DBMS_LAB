-- Aim:
-- To write and execute SQL queries to perform Insertion, Deletion,
-- Modification, Updating, Altering, and Viewing of records using
-- DML and DDL commands.

-- Create Sample Table
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(30),
    Salary DECIMAL(10,2),
    JoinDate DATE
);

-- 1. Insertion (INSERT) - Adding a Single Record
INSERT INTO Employee (EmpID, Name, Department, Salary, JoinDate)
VALUES (101, 'Anjali Sharma', 'IT', 45000.00, '2023-06-15');

-- Insert Multiple Records
INSERT INTO Employee (EmpID, Name, Department, Salary, JoinDate)
VALUES
(102, 'Ravi Kumar', 'HR', 38000.00, '2022-03-10'),
(103, 'Priya Singh', 'Finance', 52000.00, '2021-11-01'),
(104, 'Karthik Iyer', 'IT', 47000.00, '2023-01-20');

-- 2. Viewing All Records
SELECT * FROM Employee;

-- View Records Based on Department
SELECT * FROM Employee
WHERE Department = 'IT';

-- View Records with Salary Greater Than 40000
SELECT Name, Salary FROM Employee
WHERE Salary > 40000;

-- View Records Using AND Condition
SELECT * FROM Employee
WHERE Department = 'IT' AND Salary >= 45000;

-- View Records Using BETWEEN
SELECT * FROM Employee
WHERE Salary BETWEEN 40000 AND 50000;

-- View Records Using IN
SELECT * FROM Employee
WHERE Department IN ('IT', 'Finance');

-- View Records Using LIKE
SELECT * FROM Employee
WHERE Name LIKE 'A%';

-- Sort Filtered Results by Salary in Descending Order
SELECT * FROM Employee
WHERE Department = 'IT'
ORDER BY Salary DESC;

-- 3. Updating a Single Column
UPDATE Employee
SET Salary = 48000.00
WHERE EmpID = 101;

-- Update Multiple Columns
UPDATE Employee
SET Salary = Salary + 2000,
    Department = 'Systems'
WHERE Department = 'IT';

-- View Updated Records
SELECT * FROM Employee;

-- 4. Deletion - Delete a Specific Record
DELETE FROM Employee
WHERE EmpID = 102;

-- 5. Delete Records with Salary Less Than 40000
DELETE FROM Employee
WHERE Salary < 40000;

-- View Records After Deletion
SELECT * FROM Employee;

-- 6. Delete All Records but Keep Table Structure
-- Execute only one of the following commands as needed.
-- DELETE FROM Employee;
-- TRUNCATE TABLE Employee;

-- 7. Altering Table Structure - Add a New Column
ALTER TABLE Employee
ADD Email VARCHAR(100);

-- 8. Modify the Data Type/Size of an Existing Column
-- For MySQL:
ALTER TABLE Employee
MODIFY COLUMN Name VARCHAR(80);

-- For SQL Server, use the following instead of the MySQL command:
-- ALTER TABLE Employee
-- ALTER COLUMN Name VARCHAR(80);

-- 9. Rename a Column
ALTER TABLE Employee
RENAME COLUMN Email TO ContactEmail;

-- 10. Drop a Column
ALTER TABLE Employee
DROP COLUMN ContactEmail;

-- 11. Rename the Entire Table
ALTER TABLE Employee
RENAME TO Staff;

-- View the Final Table Records
SELECT * FROM Staff;
While the code is focused, press Alt+F1 for a menu of operations.
Copied! 
