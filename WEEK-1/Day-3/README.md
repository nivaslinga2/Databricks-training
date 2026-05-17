# Day 3 – SQL Joins Practice

## Overview
Day 3 focuses on SQL joins using an academic database with four tables: `students`, `courses`, `enrollments`, and `instructors`.

## Tables Used
- `students` – student details
- `courses` – course details
- `enrollments` – links students and courses
- `instructors` – instructor details

## Schema Summary

### Students
| Column | Description |
|--------|-------------|
| `student_id` | Primary key |
| `student_name` | Student name |
| `email` | Student email |

### Instructors
| Column | Description |
|--------|-------------|
| `instructor_id` | Primary key |
| `instructor_name` | Instructor name |
| `department` | Instructor department |

### Courses
| Column | Description |
|--------|-------------|
| `course_id` | Primary key |
| `course_name` | Course name |
| `instructor_id` | References instructors |

### Enrollments
| Column | Description |
|--------|-------------|
| `enrollment_id` | Primary key |
| `student_id` | References students |
| `course_id` | References courses |
| `enrollment_date` | Enrollment date |

## Concepts Covered
- `LEFT JOIN`
- `RIGHT JOIN`
- `FULL OUTER JOIN`
- `CROSS JOIN`
- Unmatched rows
- `NULL` handling
- Many-to-many relationships

## Practice Goals
- Understand table relationships using keys
- Retrieve matched and unmatched records
- Practice join-based SQL queries
- Improve SQL problem-solving skills

## Files
- `README.md` – Summary of concepts
- `Schema` – Table creation and sample data
- `Query.sql` – Join practice queries
