# University Management System - SQL Database

This repository contains SQL scripts to create and manage a **University Management System** database. The system includes tables for students, faculty, departments, courses, enrollments, attendance, and grades. It also contains sample data and a set of queries to demonstrate common operations and analyses.

---

## Database Name
`rw`

---

## Tables

### 1. `departments`
Stores information about university departments.
- `department_id` INT PRIMARY KEY
- `department_name` VARCHAR(100)

### 2. `students`
Stores student details.
- `student_id` INT PRIMARY KEY
- `name` VARCHAR(100)
- `dob` DATE
- `gender` VARCHAR(10)
- `email` VARCHAR(100)
- `phone_number` VARCHAR(15)
- `address` VARCHAR(255)
- `admission_date` DATE
- `department_id` INT (Foreign key referencing `departments`)

### 3. `faculty`
Stores faculty information.
- `faculty_id` INT PRIMARY KEY
- `name` VARCHAR(100)
- `email` VARCHAR(100)
- `phone_number` INT
- `department_id` INT (Foreign key referencing `departments`)

### 4. `courses`
Stores course information.
- `course_id` INT PRIMARY KEY
- `course_name` VARCHAR(100)
- `faculty_id` INT (Foreign key referencing `faculty`)

### 5. `enrollments`
Stores student course enrollments.
- `enrollment_id` INT PRIMARY KEY
- `student_id` INT (Foreign key referencing `students`)
- `course_id` INT (Foreign key referencing `courses`)
- `enrollment_date` DATE

### 6. `attendance`
Tracks student attendance.
- `attendance_id` INT PRIMARY KEY
- `student_id` INT (Foreign key referencing `students`)
- `course_id` INT (Foreign key referencing `courses`)
- `attendance_date` DATE
- `status` VARCHAR(10) (Present, Absent, Late)

### 7. `grades`
Stores student grades.
- `grade_id` INT PRIMARY KEY
- `student_id` INT (Foreign key referencing `students`)
- `course_id` INT (Foreign key referencing `courses`)
- `marks_obtained` DECIMAL(5,2)
- `grade` VARCHAR(5)

---

## Sample Data
- 10 departments
- 10 faculty members
- 10 courses
- 10 students
- Attendance and grades for multiple students
- Includes insert, update, and delete examples

---

## SQL Queries Demonstrated

### Student Queries
- List all students in the Computer Science department
- List students alphabetically
- Count students per department
- Show student details with department names
- Students not enrolled in any course

### Grades and Performance
- Top 10 highest scoring students
- Students with marks above average
- Students failing and attendance below threshold
- Ranking students using window functions
- Performance classification using `CASE`

### Attendance
- Average attendance percentage
- Students with attendance below 75%
- Students missing more than 10 classes
- Month extraction from attendance date

### Faculty & Courses
- Faculty not assigned to any course
- Courses without faculty assigned

### Miscellaneous
- Format attendance dates
- Replace NULL emails
- Uppercase faculty names
- Trim student names
- Calculate years since admission

---

## How to Use
1. Create the database:
```sql
CREATE DATABASE rw;
USE rw;
