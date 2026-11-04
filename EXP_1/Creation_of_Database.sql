-- Ex.No: 1
-- Aim: To create a database, create tables, insert records into the tables,
-- and write SQL queries to retrieve information from the database.

-- Create Database
CREATE DATABASE CollegeDB;

-- Use Database
USE CollegeDB;

-- Create Table
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(30),
    Department VARCHAR(20),
    Age INT,
    CGPA DECIMAL(3,2)
);

-- Insert Records
INSERT INTO Student VALUES
(101, 'Anu', 'CSE', 20, 8.90),
(102, 'Bala', 'ECE', 21, 8.50),
(103, 'Charles', 'IT', 20, 9.10),
(104, 'Divya', 'CSE', 22, 8.70),
(105, 'Esha', 'AIDS', 21, 9.20);

-- Retrieve All Records
SELECT * FROM Student;

-- Retrieve CSE Students
SELECT * FROM Student
WHERE Department = 'CSE';

-- Retrieve Students with CGPA Greater Than 8.8
SELECT * FROM Student
WHERE CGPA > 8.8;

-- Sort Students by CGPA in Descending Order
SELECT * FROM Student
ORDER BY CGPA DESC;

-- Count Students
SELECT COUNT(*) AS TotalStudents
FROM Student;

-- Calculate Average CGPA
SELECT AVG(CGPA) AS AverageCGPA
FROM Student;
