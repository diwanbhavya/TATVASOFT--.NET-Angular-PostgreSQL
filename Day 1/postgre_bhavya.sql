CREATE TABLE student (
  Firstname VARCHAR(255),
  Lastname VARCHAR(255),
  Enroll INT,
  Branch VARCHAR(50)
);

INSERT INTO student(Firstname, Lastname, Enroll, Branch)
VALUES
('Aarav', 'Sharma', 11, 'ECE'),
('Meera', 'Singh', 23, 'ECE'),
('Kabir', 'Verma', 56, 'ECE'),
('Ishaan', 'Gupta', 41, 'MECH'),
('Riya', 'Kapoor', 19, 'CIVIL'),
('Saanvi', 'Mehta', 28, 'CIVIL'),
('Vivaan', 'Jain', 33, 'MECH'),
('Anaya', 'Agarwal', 39, 'MECH'),
('Arjun', 'Chopra', 47, 'ECE'),
('Diya', 'Bansal', 29, 'ECE');

SELECT Firstname, Enroll FROM student;
SELECT * FROM student;

UPDATE student
SET Department = CASE
    WHEN Branch IN ('ECE', 'EEE') THEN 'Electronics'
    WHEN Branch IN ('CIVIL', 'MECH') THEN 'Engineering'
    ELSE Department
END;

DELETE FROM student WHERE enroll='17';
ALTER TABLE student RENAME COLUMN Branch TO Stream;

SELECT * FROM student WHERE Enroll=5;
SELECT * FROM student WHERE Enroll<25;
SELECT * FROM student WHERE Enroll<=25;
SELECT * FROM student WHERE Enroll>25;
SELECT * FROM student WHERE Enroll>=25;
SELECT * FROM student WHERE Enroll!=5;
SELECT * FROM student WHERE Firstname LIKE 'V%';
SELECT * FROM student WHERE Firstname LIKE 'Ish%';
SELECT * FROM student WHERE Firstname ILIKE 'ISH%';
SELECT * FROM student ORDER BY Enroll DESC;
SELECT * FROM student LIMIT 10;
SELECT * FROM student OFFSET 5 LIMIT 10;

SELECT COUNT(*) FROM student;
SELECT AVG(Enroll) FROM student;
SELECT MAX(Enroll), MIN(Enroll) FROM student;
SELECT Stream, COUNT(*) FROM student GROUP BY Stream;
SELECT Stream, COUNT(*) FROM student GROUP BY Stream HAVING COUNT(*) > 2;
SELECT Stream, COUNT(*) FROM student GROUP BY Stream HAVING COUNT(*) < 3;

CREATE TABLE temp_enrollments(enrollment INT);
SELECT * FROM temp_enrollments;
DROP TABLE temp_enrollments;

DELETE FROM student
WHERE Firstname IS NULL
  AND Lastname IS NULL
  AND Enroll IS NULL
  AND Stream IS NULL;

ALTER TABLE student ADD COLUMN student_id SERIAL PRIMARY KEY;
ALTER TABLE student ALTER COLUMN Enroll SET NOT NULL;
ALTER TABLE student ADD Department VARCHAR(255);
ALTER TABLE student
ADD temp_col INT;
ALTER TABLE student
DROP COLUMN temp_col;

CREATE TABLE department (
  dept_id SERIAL PRIMARY KEY,
  dept_name VARCHAR(255) UNIQUE NOT NULL
);
INSERT INTO department (dept_name)
VALUES
('Electronics'),
('Engineering');

ALTER TABLE student ADD COLUMN dept_id INT;

UPDATE student
SET dept_id = CASE
    WHEN Department = 'Electronics' THEN 1
    WHEN Department = 'Engineering' THEN 2
END;

ALTER TABLE student
ADD CONSTRAINT fk_dept
FOREIGN KEY (dept_id) REFERENCES department(dept_id);

INSERT INTO department (dept_name)
VALUES ('Architecture');

INSERT INTO student (Firstname, Lastname, Enroll, Stream, Department, dept_id)
VALUES ('Neha', 'Reddy', 13, 'None', NULL, NULL);

-- inner join
SELECT s.firstname, s.enroll, d.dept_name
FROM student s
INNER JOIN department d ON s.dept_id = d.dept_id;

-- left join
SELECT s.firstname, s.enroll, d.dept_name
FROM student s
LEFT JOIN department d ON s.dept_id = d.dept_id;

-- right join
SELECT s.firstname, s.enroll, d.dept_name
FROM student s
RIGHT JOIN department d ON s.dept_id = d.dept_id;

SELECT s.firstname, s.enroll, d.dept_name
FROM student s
FULL JOIN department d ON s.dept_id = d.dept_id;