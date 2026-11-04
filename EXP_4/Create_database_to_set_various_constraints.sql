-- Aim:
-- To create tables and demonstrate SQL constraints:
-- PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, CHECK, and DEFAULT.
-- Also, to add and remove constraints on an existing table.

-- Step 1: Create Database
CREATE DATABASE CollegeDB;
USE CollegeDB;

-- Create Department Table
CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL UNIQUE
);

-- Create Student Table with Constraints
CREATE TABLE Student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT CHECK (age >= 17 AND age <= 30),
    email VARCHAR(50) UNIQUE,
    gender VARCHAR(10) DEFAULT 'Not Specified',
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- Step 2: Insert Sample Records into Department
INSERT INTO Department VALUES (1, 'Computer Science');
INSERT INTO Department VALUES (2, 'Electronics');

-- Insert Valid Records into Student
INSERT INTO Student (roll_no, name, age, email, gender, dept_id)
VALUES (101, 'Arun', 20, 'arun@email.com', 'Male', 1);

INSERT INTO Student (roll_no, name, age, email, dept_id)
VALUES (102, 'Priya', 21, 'priya@email.com', 2);

-- View Student Records
SELECT * FROM Student;

-- Step 3: Constraint Violations
-- Execute each statement separately.
-- Each statement is expected to fail due to a constraint violation.

-- (a) NOT NULL Violation
-- INSERT INTO Student (roll_no, name, age, email, dept_id)
-- VALUES (103, NULL, 22, 'test1@email.com', 1);

-- (b) UNIQUE Violation: Duplicate Email
-- INSERT INTO Student (roll_no, name, age, email, dept_id)
-- VALUES (104, 'Kumar', 23, 'arun@email.com', 1);

-- (c) PRIMARY KEY Violation: Duplicate Roll Number
-- INSERT INTO Student (roll_no, name, age, email, dept_id)
-- VALUES (101, 'Ravi', 22, 'ravi@email.com', 1);

-- (d) CHECK Violation: Invalid Age
-- INSERT INTO Student (roll_no, name, age, email, dept_id)
-- VALUES (105, 'Sita', 35, 'sita@email.com', 1);

-- (e) FOREIGN KEY Violation: Non-existent Department
-- INSERT INTO Student (roll_no, name, age, email, dept_id)
-- VALUES (106, 'Meena', 20, 'meena@email.com', 9);

-- Step 4: Add a Constraint to an Existing Table
ALTER TABLE Student
ADD CONSTRAINT chk_name CHECK (LENGTH(name) >= 3);

-- Step 5: Drop the Constraint
-- MySQL syntax:
ALTER TABLE Student
DROP CHECK chk_name;

-- Step 6: View Table Structure
DESC Student;

-- View Department Records
SELECT * FROM Department;

-- View Student Records
SELECT * FROM Student;
