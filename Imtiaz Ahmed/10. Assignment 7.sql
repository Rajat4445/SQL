-- Assignment 7:
SELECT * FROM students;
SELECT * FROM student_enrollment;
SELECT * FROM professors;
SELECT * FROM courses;
SELECT * FROM teach;
-- The above two tables are not related to each other in any way as they do not have a column common with each other

-- write students' names, the courses amd the professor teaching it
SELECT student_name, c.course_no, course_title, t.last_name  -- course_title
FROM students s
LEFT JOIN student_enrollment se
ON s.student_no = se.student_no
LEFT JOIN courses c
ON se.course_no = c.course_no
LEFT JOIN teach t
ON c.course_no = t.course_no

















