
-- Aim: To understand and practice DCL and TCL commands in SQL.

-- Create Employee Table
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(30),
    Department VARCHAR(20),
    Salary DECIMAL(10,2)
);

-- Insert Records into Employee Table
INSERT INTO Employee VALUES
(101, 'Arun', 'HR', 35000),
(102, 'Priya', 'IT', 45000),
(103, 'Kavin', 'Finance', 50000),
(104, 'Divya', 'IT', 55000);

-- DCL COMMANDS

-- Grant SELECT Permission to user1
GRANT SELECT ON Employee TO user1;

-- Grant SELECT and INSERT Permissions to user1
GRANT SELECT, INSERT ON Employee TO user1;

-- Revoke INSERT Permission from user1
REVOKE INSERT ON Employee FROM user1;

-- Revoke All Permissions from user1
REVOKE ALL ON Employee FROM user1;

-- TCL COMMANDS

-- Disable Autocommit
SET AUTOCOMMIT = 0;

-- Update Salary of Employee 102
UPDATE Employee
SET Salary = 48000
WHERE EmpID = 102;

-- Create Savepoint
SAVEPOINT SP1;

-- Update Salary of Employee 104
UPDATE Employee
SET Salary = 60000
WHERE EmpID = 104;

-- Display Employee Records
SELECT * FROM Employee;

-- Rollback to Savepoint
ROLLBACK TO SP1;

-- Commit the Transaction
COMMIT;

-- Delete Employee 101
DELETE FROM Employee
WHERE EmpID = 101;

-- Rollback the Delete Operation
ROLLBACK;

-- Display Final Employee Records
SELECT * FROM Employee;
