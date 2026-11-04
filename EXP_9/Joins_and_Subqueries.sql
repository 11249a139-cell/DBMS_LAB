11249A073-Nitheesh
DBMS_LAB
Repository navigation
Code
Issues
Pull requests
Actions
Projects
Security and quality
Insights
DBMS_LAB/EXP_9
/Joins_and_Subqueries.sql
11249A073-Nitheesh
11249A073-Nitheesh
Uploaded
4b14b45
 · 
3 weeks ago
213 lines (145 loc) · 3.99 KB

Code

Blame
-- AIM:
-- To create related tables in a relational database using primary and foreign keys,
-- and retrieve related data using different types of JOIN operations and sub-queries.



1. Create database and tables

CREATE DATABASE CollegeDB;
USE CollegeDB;

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    dept_id INT,
    cgpa DECIMAL(3,2),
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(60) NOT NULL,
    dept_id INT,
    credits INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Enrollment (
    enroll_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    semester INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);



2. Insert sample records

INSERT INTO Department VALUES
(10, 'CSE', 'Block A'),
(20, 'ECE', 'Block B'),
(30, 'IT', 'Block C'),
(40, 'MECH', 'Block D');

INSERT INTO Student VALUES
(101, 'Anu', 10, 8.70),
(102, 'Bala', 10, 7.90),
(103, 'Charan', 20, 8.20),
(104, 'Divya', 30, 9.10),
(105, 'Esha', NULL, 7.50);

INSERT INTO Course VALUES
(501, 'DBMS', 10, 4),
(502, 'Data Structures', 10, 4),
(503, 'Digital Systems', 20, 3),
(504, 'Web Technology', 30, 3);

INSERT INTO Enrollment VALUES
(1, 101, 501, 5, 88),
(2, 101, 502, 5, 91),
(3, 102, 501, 5, 76),
(4, 103, 503, 5, 84),
(5, 104, 504, 5, 95);



3. JOIN queries
3.1 INNER JOIN — Students with department names

SELECT s.student_id, s.student_name, d.dept_name
FROM Student s
INNER JOIN Department d
ON s.dept_id = d.dept_id;



3.2 LEFT JOIN — All students

SELECT s.student_id, s.student_name, d.dept_name
FROM Student s
LEFT JOIN Department d
ON s.dept_id = d.dept_id;



3.3 LEFT JOIN — All departments and students

SELECT d.dept_id, d.dept_name, s.student_name
FROM Department d
LEFT JOIN Student s
ON d.dept_id = s.dept_id
ORDER BY d.dept_id;



3.4 Students and enrolled courses

SELECT s.student_name, c.course_name, e.marks
FROM Enrollment e
INNER JOIN Student s ON e.student_id = s.student_id
INNER JOIN Course c ON e.course_id = c.course_id
ORDER BY s.student_id, e.enroll_id;



3.5 Students who scored more than 80

SELECT s.student_name, c.course_name, e.marks
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN Course c ON e.course_id = c.course_id
WHERE e.marks > 80;



3.6 RIGHT JOIN — All departments and students

SELECT d.dept_name, s.student_name
FROM Student s
RIGHT JOIN Department d
ON s.dept_id = d.dept_id
ORDER BY d.dept_id, s.student_id;



4. Sub-query operations
4.1 Students with CGPA above average

SELECT student_id, student_name, cgpa
FROM Student
WHERE cgpa > (SELECT AVG(cgpa) FROM Student);



4.2 Students in the CSE department

SELECT student_id, student_name
FROM Student
WHERE dept_id = (
    SELECT dept_id
    FROM Department
    WHERE dept_name = 'CSE'
);



4.3 Students enrolled in DBMS

SELECT student_id, student_name
FROM Student
WHERE student_id IN (
    SELECT student_id
    FROM Enrollment
    WHERE course_id = (
        SELECT course_id
        FROM Course
        WHERE course_name = 'DBMS'
    )
)
ORDER BY student_id;



4.4 Courses with credits greater than ANY ECE course

SELECT course_id, course_name, credits
FROM Course
WHERE credits > ANY (
    SELECT credits
    FROM Course
    WHERE dept_id = 20
);



4.5 Correlated sub-query — CGPA above department average

SELECT s.student_id, s.student_name, s.dept_id, s.cgpa
FROM Student s
WHERE s.dept_id IS NOT NULL
AND s.cgpa > (
    SELECT AVG(s2.cgpa)
    FROM Student s2
    WHERE s2.dept_id = s.dept_id
);



4.6 Student with the highest CGPA

SELECT student_id, student_name, cgpa
FROM Student
WHERE cgpa = (SELECT MAX(cgpa) FROM Student);



5. Verify tables

SHOW TABLES;

SELECT * FROM Department;
SELECT * FROM Student;
SELECT * FROM Course;
SELECT * FROM Enrollment;
While the code is focused, press Alt+F1 for a menu of operations.
Copied! 
