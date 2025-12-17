create database rw;
use rw;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    dob DATE,
    gender VARCHAR(10),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address VARCHAR(255),
    admission_date DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE faculty (
    faculty_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone_number int,
	department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    faculty_id int,
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    attendance_date DATE,
    status VARCHAR(10),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

 CREATE TABLE grades (
    grade_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    marks_obtained DECIMAL(5,2),
    grade VARCHAR(5),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO departments VALUES
(1,'Computer Science'),
(2,'Information Technology'),
(3,'Mechanical'),
(4,'Electrical'),
(5,'Civil'),
(6,'AI & DS'),
(7,'Electronics'),
(8,'MBA'),
(9,'Physics'),
(10,'Mathematics');

INSERT INTO students VALUES
(1,'Alice','2002-01-15','Female','alice@mail.com','9876543210','Delhi','2021-08-01',1),
(2,'Bob','2001-05-10','Male','bob@mail.com','9876543211','Mumbai','2020-08-01',1),
(3,'Charlie','2002-03-20','Male',NULL,'9876543212','Pune','2021-08-01',2),
(4,'David','2000-11-25','Male','david@mail.com','9876543213','Ahmedabad','2019-08-01',3),
(5,'Eva','2001-07-19','Female','eva@mail.com','9876543214','Chennai','2020-08-01',4),
(6,'Frank','2002-09-12','Male','frank@mail.com','9876543215','Delhi','2021-08-01',1),
(7,'Grace','2001-02-14','Female','grace@mail.com','9876543216','Surat','2020-08-01',6),
(8,'Helen','2002-06-30','Female',NULL,'9876543217','Rajkot','2021-08-01',6),
(9,'Ian','2000-04-08','Male','ian@mail.com','9876543218','Vadodara','2019-08-01',7),
(10,'Jack','2001-12-22','Male','jack@mail.com','9876543219','Jaipur','2020-08-01',1);

INSERT INTO faculty VALUES
(1,'Dr. Sharma','sharma@mail.com',9991111,1),
(2,'Dr. Mehta','mehta@mail.com',9991112,2),
(3,'Dr. Rao','rao@mail.com',9991113,3),
(4,'Dr. Patel','patel@mail.com',9991114,4),
(5,'Dr. Singh','singh@mail.com',9991115,1),
(6,'Dr. Verma','verma@mail.com',9991116,6),
(7,'Dr. Iyer','iyer@mail.com',9991117,7),
(8,'Dr. Khan','khan@mail.com',9991118,8),
(9,'Dr. Das','das@mail.com',9991119,9),
(10,'Dr. Roy','roy@mail.com',9991120,10);

INSERT INTO courses (course_id, course_name, faculty_id) VALUES
(1,'Data Structures',1),
(2,'DBMS',1),
(3,'Operating Systems',2),
(4,'Computer Networks',2),
(5,'Machine Learning',6),
(6,'Thermodynamics',3),
(7,'Circuits',7),
(8,'Business Management',8),
(9,'Quantum Physics',9),
(10,'Linear Algebra',10);


INSERT INTO enrollments VALUES
(1,1,1,'2021-08-10'),
(2,1,2,'2021-08-10'),
(3,2,1,'2020-08-12'),
(4,3,2,'2021-08-15'),
(5,4,6,'2019-08-20'),
(6,5,7,'2020-08-18'),
(7,6,1,'2021-08-10'),
(8,7,5,'2020-08-12'),
(9,8,5,'2021-08-15'),
(10,9,9,'2019-08-20');

INSERT INTO attendance VALUES
(1,1,1,'2024-01-01','Present'),
(2,1,1,'2024-01-02','Absent'),
(3,2,1,'2024-01-01','Late'),
(4,3,2,'2024-01-01','Present'),
(5,4,6,'2024-01-01','Absent'),
(6,5,7,'2024-01-01','Present'),
(7,6,1,'2024-01-01','Present'),
(8,7,5,'2024-01-01','Absent'),
(9,8,5,'2024-01-01','Late'),
(10,9,9,'2024-01-01','Present');

INSERT INTO grades VALUES
(1,1,1,95,'A'),
(2,2,1,45,'F'),
(3,3,2,88,'A'),
(4,4,6,55,'C'),
(5,5,7,78,'B'),
(6,6,1,92,'A'),
(7,7,5,65,'C'),
(8,8,5,40,'F'),
(9,9,9,98,'A'),
(10,10,1,82,'B');

#Insert
INSERT INTO students VALUES (11,'Kevin','2002-02-02','Male','kevin@mail.com','9990000','Goa','2022-08-01',1);

#update
UPDATE students
SET phone_number = '9999999999'
WHERE student_id = 1;
#delete
DELETE FROM students WHERE student_id = 11;

#CS Department Students
SELECT *
FROM students s
JOIN departments d ON s.department_id = d.department_id
WHERE d.department_name = 'Computer Science';

#Top 10 Highest Scoring Students
SELECT * FROM grades
ORDER BY marks_obtained DESC
LIMIT 10;

#Attendance below 75%
SELECT student_id,
(COUNT(CASE WHEN status='Present' THEN 1 END)*100.0/COUNT(*)) AS attendance_pct
FROM attendance
GROUP BY student_id
HAVING attendance_pct < 75;

#Attendance < 50% AND Failing
SELECT g.student_id
FROM grades g
WHERE g.marks_obtained < 50
AND g.student_id IN (
  SELECT student_id
  FROM attendance
  GROUP BY student_id
  HAVING COUNT(CASE WHEN status='Present' THEN 1 END)*100.0/COUNT(*) < 50
);

#Above 90 OR Perfect Attendance
SELECT DISTINCT student_id
FROM grades
WHERE marks_obtained > 90
OR student_id IN (
  SELECT student_id
  FROM attendance
  GROUP BY student_id
  HAVING COUNT(CASE WHEN status='Absent' THEN 1 END)=0
);

#Faculty NOT assigned any course
SELECT * FROM faculty
WHERE faculty_id NOT IN (SELECT DISTINCT faculty_id FROM courses);

#List students alphabetically by name
SELECT * FROM students ORDER BY name;

#Count the number of students enrolled in each department
SELECT department_id, COUNT(*) FROM students GROUP BY department_id;

#Show the average marks per course
SELECT course_id, AVG(marks_obtained) FROM grades GROUP BY course_id;

#average attendance percentage of students
SELECT AVG(CASE WHEN status='Present' THEN 1 ELSE 0 END)*100 FROM attendance;

#highest and lowest marks obtained in each course
SELECT course_id, MAX(marks_obtained), MIN(marks_obtained)
FROM grades GROUP BY course_id;

#number of students per department.
SELECT 
    d.department_name,
    COUNT(s.student_id) AS total_students
FROM students s
JOIN departments d ON s.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_students DESC;


#student details along with their department using INNER JOIN
SELECT s.name, d.department_name
FROM students s
INNER JOIN departments d ON s.department_id = d.department_id;

#students who have not enrolled in any course using LEFT JOIN
SELECT *
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

#courses that have no faculty assigned using RIGHT JOIN
SELECT *
FROM courses c
RIGHT JOIN faculty f ON c.course_id = f.faculty_id;


SELECT student_id, name
FROM students
UNION
SELECT student_id, name
FROM students
WHERE student_id NOT IN (
    SELECT student_id FROM grades
)LIMIT 0;

#students with marks above the average
SELECT * FROM grades
WHERE marks_obtained > (SELECT AVG(marks_obtained) FROM grades);

#students who have missed more than 10 classes.
SELECT student_id FROM attendance
GROUP BY student_id
HAVING COUNT(CASE WHEN status='Absent' THEN 1 END) > 10;

#month from attendance_date
SELECT MONTH(attendance_date) FROM attendance;

#the number of years since a student's admission
SELECT name, TIMESTAMPDIFF(YEAR, admission_date, CURDATE()) FROM students;

#formatted date
SELECT DATE_FORMAT(attendance_date,'%d-%m-%Y') FROM attendance;

#all faculty names to uppercase
SELECT UPPER(name) FROM faculty;

#Trimed unnecessary spaces from student names
SELECT TRIM(name) FROM students;

#Replace NULL email fields with "Email Not Provided"
SELECT IFNULL(email,'Email Not Provided') FROM students;

# window functions
SELECT student_id, marks_obtained,
RANK() OVER (ORDER BY marks_obtained DESC) AS rank_no
FROM grades;

# case expressions
SELECT student_id,
CASE
 WHEN marks_obtained > 90 THEN 'Excellent'
 WHEN marks_obtained BETWEEN 75 AND 90 THEN 'Good'
 ELSE 'Needs Improvement'
END AS performance
FROM grades;
