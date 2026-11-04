
-- Aim:
-- To study and execute SQL commands for creating and using
-- Views, Sequences, Indexes, and Savepoints in a relational database.

-- 1. TABLE CREATION
CREATE TABLE STUDENT (
    ROLLNO NUMBER(5) PRIMARY KEY,
    NAME VARCHAR2(30),
    DEPARTMENT VARCHAR2(20),
    MARKS NUMBER(3)
);

-- 2. INSERT SAMPLE RECORDS
INSERT INTO STUDENT VALUES (101, 'ARUN', 'CSE', 85);
INSERT INTO STUDENT VALUES (102, 'PRIYA', 'ECE', 90);
INSERT INTO STUDENT VALUES (103, 'KUMAR', 'CSE', 78);
INSERT INTO STUDENT VALUES (104, 'DIVYA', 'IT', 88);
INSERT INTO STUDENT VALUES (105, 'RAHUL', 'CSE', 92);

COMMIT;

-- Display Student Records
SELECT * FROM STUDENT;

-- 3. CREATION OF VIEW
CREATE VIEW CSE_STUDENTS AS
SELECT ROLLNO, NAME, MARKS
FROM STUDENT
WHERE DEPARTMENT = 'CSE';

-- Display View
SELECT * FROM CSE_STUDENTS;

-- Remove View
DROP VIEW CSE_STUDENTS;

-- 4. CREATION OF SEQUENCE
CREATE SEQUENCE STUDENT_SEQ
START WITH 106
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Generate Sequence Values
SELECT STUDENT_SEQ.NEXTVAL FROM DUAL;
SELECT STUDENT_SEQ.NEXTVAL FROM DUAL;

-- Insert a Student Using Sequence
INSERT INTO STUDENT
VALUES (STUDENT_SEQ.NEXTVAL, 'SNEHA', 'CSE', 89);

COMMIT;

-- Display Student Records
SELECT * FROM STUDENT;

-- Remove Sequence
DROP SEQUENCE STUDENT_SEQ;

-- 5. CREATION OF INDEX
CREATE INDEX IDX_STUDENT_NAME
ON STUDENT(NAME);

-- Retrieve Student Using Indexed Column
SELECT * FROM STUDENT
WHERE NAME = 'ARUN';

-- Remove Index
DROP INDEX IDX_STUDENT_NAME;

-- 6. SAVEPOINT AND ROLLBACK

-- Step 1: Insert First Record
INSERT INTO STUDENT
VALUES (106, 'MOHAN', 'IT', 80);

-- Create Savepoint
SAVEPOINT SP1;

-- Step 2: Insert Second Record
INSERT INTO STUDENT
VALUES (107, 'LATHA', 'ECE', 87);

-- Display Records Before Rollback
SELECT * FROM STUDENT;

-- Step 3: Roll Back to Savepoint
ROLLBACK TO SP1;

-- Step 4: Display Records After Rollback
SELECT * FROM STUDENT;

-- Step 5: Commit Remaining Changes
COMMIT;

-- Final Student Records
SELECT * FROM STUDENT;

-- 7. TRANSACTION COMMANDS
-- ROLLBACK cancels all uncommitted changes in the current transaction.
-- ROLLBACK TO SP1 undoes changes made after savepoint SP1.
-- COMMIT saves the current transaction permanently.
