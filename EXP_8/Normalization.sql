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
DBMS_LAB/EXP_8
/Normalization.sql
11249A073-Nitheesh
11249A073-Nitheesh
Uploaded
4b14b45
 · 
3 weeks ago
286 lines (202 loc) · 6.79 KB

Code

Blame
-- AIM:
-- To study and implement Normalization (1NF, 2NF, 3NF, 4NF, 5NF)
-- using Functional Dependencies and create normalized tables in Oracle.

-- =====================================================
-- 1. FIRST NORMAL FORM (1NF)
-- =====================================================

-- Create a table with atomic values

CREATE TABLE StudentCourse_1NF (
    SID VARCHAR2(10),
    SName VARCHAR2(30),
    Course VARCHAR2(20),
    Faculty VARCHAR2(30),
    FacultyPhone VARCHAR2(15),
    Dept VARCHAR2(10),
    HOD VARCHAR2(30),
    CONSTRAINT pk_1nf PRIMARY KEY (SID, Course)
);

-- Insert records

INSERT INTO StudentCourse_1NF VALUES
('S1', 'Arun', 'DBMS', 'Ravi', '9990001', 'CSE', 'Dr. Sharma');

INSERT INTO StudentCourse_1NF VALUES
('S1', 'Arun', 'OS', 'Meena', '9990002', 'CSE', 'Dr. Sharma');

INSERT INTO StudentCourse_1NF VALUES
('S2', 'Bala', 'DBMS', 'Ravi', '9990001', 'CSE', 'Dr. Sharma');

COMMIT;

-- Display 1NF table
SELECT * FROM StudentCourse_1NF;


-- =====================================================
-- 2. SECOND NORMAL FORM (2NF)
-- =====================================================

-- Create Student table

CREATE TABLE Student (
    SID VARCHAR2(10) PRIMARY KEY,
    SName VARCHAR2(30)
);

-- Create Course_Faculty table

CREATE TABLE Course_Faculty (
    Course VARCHAR2(20) PRIMARY KEY,
    Faculty VARCHAR2(30),
    FacultyPhone VARCHAR2(15),
    Dept VARCHAR2(10),
    HOD VARCHAR2(30)
);

-- Create Enrollment table

CREATE TABLE Enrollment (
    SID VARCHAR2(10),
    Course VARCHAR2(20),
    CONSTRAINT pk_enrollment PRIMARY KEY (SID, Course),
    CONSTRAINT fk_enroll_student FOREIGN KEY (SID)
        REFERENCES Student(SID),
    CONSTRAINT fk_enroll_course FOREIGN KEY (Course)
        REFERENCES Course_Faculty(Course)
);

-- Insert Student records

INSERT INTO Student VALUES ('S1', 'Arun');
INSERT INTO Student VALUES ('S2', 'Bala');

-- Insert Course_Faculty records

INSERT INTO Course_Faculty VALUES
('DBMS', 'Ravi', '9990001', 'CSE', 'Dr. Sharma');

INSERT INTO Course_Faculty VALUES
('OS', 'Meena', '9990002', 'CSE', 'Dr. Sharma');

-- Insert Enrollment records

INSERT INTO Enrollment VALUES ('S1', 'DBMS');
INSERT INTO Enrollment VALUES ('S1', 'OS');
INSERT INTO Enrollment VALUES ('S2', 'DBMS');

COMMIT;

-- Display 2NF tables
SELECT * FROM Student;
SELECT * FROM Course_Faculty;
SELECT * FROM Enrollment;


-- =====================================================
-- 3. THIRD NORMAL FORM (3NF)
-- =====================================================

-- Create Department table

CREATE TABLE Department (
    Dept VARCHAR2(10) PRIMARY KEY,
    HOD VARCHAR2(30)
);

-- Create Faculty_Dept table

CREATE TABLE Faculty_Dept (
    Faculty VARCHAR2(30) PRIMARY KEY,
    FacultyPhone VARCHAR2(15),
    Dept VARCHAR2(10),
    CONSTRAINT fk_faculty_dept FOREIGN KEY (Dept)
        REFERENCES Department(Dept)
);

-- Create Course_3NF table

CREATE TABLE Course_3NF (
    Course VARCHAR2(20) PRIMARY KEY,
    Faculty VARCHAR2(30),
    CONSTRAINT fk_course_faculty FOREIGN KEY (Faculty)
        REFERENCES Faculty_Dept(Faculty)
);

-- Insert Department records

INSERT INTO Department VALUES ('CSE', 'Dr. Sharma');

-- Insert Faculty records

INSERT INTO Faculty_Dept VALUES
('Ravi', '9990001', 'CSE');

INSERT INTO Faculty_Dept VALUES
('Meena', '9990002', 'CSE');

-- Insert Course records

INSERT INTO Course_3NF VALUES ('DBMS', 'Ravi');
INSERT INTO Course_3NF VALUES ('OS', 'Meena');

COMMIT;

-- Display normalized data using JOIN

SELECT c.Course, f.Faculty, f.FacultyPhone,
       f.Dept, d.HOD
FROM Course_3NF c
JOIN Faculty_Dept f ON c.Faculty = f.Faculty
JOIN Department d ON f.Dept = d.Dept;


-- =====================================================
-- 4. FOURTH NORMAL FORM (4NF)
-- =====================================================

-- Create Faculty_Course table

CREATE TABLE Faculty_Course (
    Faculty VARCHAR2(30),
    Course VARCHAR2(20),
    CONSTRAINT pk_faculty_course PRIMARY KEY (Faculty, Course)
);

-- Create Faculty_Language table

CREATE TABLE Faculty_Language (
    Faculty VARCHAR2(30),
    Language VARCHAR2(20),
    CONSTRAINT pk_faculty_language PRIMARY KEY (Faculty, Language)
);

-- Insert Faculty_Course records

INSERT INTO Faculty_Course VALUES ('Ravi', 'DBMS');
INSERT INTO Faculty_Course VALUES ('Ravi', 'OS');

-- Insert Faculty_Language records

INSERT INTO Faculty_Language VALUES ('Ravi', 'English');
INSERT INTO Faculty_Language VALUES ('Ravi', 'Hindi');

COMMIT;

-- Display 4NF tables

SELECT * FROM Faculty_Course;
SELECT * FROM Faculty_Language;


-- =====================================================
-- 5. FIFTH NORMAL FORM (5NF)
-- =====================================================

-- Create Faculty_Course_5NF table

CREATE TABLE Faculty_Course_5NF (
    Faculty VARCHAR2(30),
    Course VARCHAR2(20),
    CONSTRAINT pk_fc_5nf PRIMARY KEY (Faculty, Course)
);

-- Create Course_Textbook_5NF table

CREATE TABLE Course_Textbook_5NF (
    Course VARCHAR2(20),
    Textbook VARCHAR2(30),
    CONSTRAINT pk_ct_5nf PRIMARY KEY (Course, Textbook)
);

-- Create Faculty_Textbook_5NF table

CREATE TABLE Faculty_Textbook_5NF (
    Faculty VARCHAR2(30),
    Textbook VARCHAR2(30),
    CONSTRAINT pk_ft_5nf PRIMARY KEY (Faculty, Textbook)
);

-- Insert Faculty_Course records

INSERT INTO Faculty_Course_5NF VALUES ('Ravi', 'DBMS');
INSERT INTO Faculty_Course_5NF VALUES ('Meena', 'OS');

-- Insert Course_Textbook records

INSERT INTO Course_Textbook_5NF VALUES ('DBMS', 'Korth');
INSERT INTO Course_Textbook_5NF VALUES ('DBMS', 'Navathe');
INSERT INTO Course_Textbook_5NF VALUES ('OS', 'Silberschatz');

-- Insert Faculty_Textbook records

INSERT INTO Faculty_Textbook_5NF VALUES ('Ravi', 'Korth');
INSERT INTO Faculty_Textbook_5NF VALUES ('Ravi', 'Navathe');
INSERT INTO Faculty_Textbook_5NF VALUES ('Meena', 'Silberschatz');

COMMIT;

-- Reconstruct the relation using a three-way JOIN

SELECT fc.Faculty, fc.Course, ct.Textbook
FROM Faculty_Course_5NF fc
JOIN Course_Textbook_5NF ct
    ON fc.Course = ct.Course
JOIN Faculty_Textbook_5NF ft
    ON fc.Faculty = ft.Faculty
    AND ct.Textbook = ft.Textbook;


-- =====================================================
-- 6. VERIFYING NORMALIZATION IN ORACLE
-- =====================================================

-- Display all tables created in the current schema

SELECT table_name
FROM user_tables
ORDER BY table_name;

-- View the structure of Faculty_Dept

DESC Faculty_Dept;

-- View primary key and foreign key constraints

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE table_name IN (
    'STUDENT',
    'COURSE_3NF',
    'FACULTY_DEPT',
    'DEPARTMENT'
)
ORDER BY table_name;

-- View primary key and foreign key columns

SELECT a.table_name, a.column_name, c.constraint_type
FROM user_cons_columns a
JOIN user_constraints c
    ON a.constraint_name = c.constraint_name
WHERE c.constraint_type IN ('P', 'R')
ORDER BY a.table_name, a.position;
While the code is focused, press Alt+F1 for a menu of operations.
Copied!
