
CREATE VIEW StudentsFollowing AS
	SELECT *
	FROM student;

CREATE VIEW FinishedCourses AS
	SELECT student, coursecode, name, grade ,credits
	FROM graded,course WHERE graded.course = course.courseCode;

CREATE VIEW Registrations AS
	SELECT restrictedCourse AS course, student, 'waiting' AS Status
	FROM appliedFor
	UNION
	SELECT course, student, 'registered' AS Status
	FROM isAttending
	ORDER BY course;

CREATE VIEW PassedCourses AS
	SELECT student, coursecode, name, grade ,credits
	FROM graded,course 
	WHERE graded.course = course.courseCode AND graded.grade != 'U';	


CREATE VIEW UnreadMandatory AS
	SELECT *
	FROM(
	SELECT personalCodeNumber as student, course
	FROM student, branchMandatoryCourse
	WHERE ((student.branch, student.studyProgramme) = (branchMandatoryCourse.branch,branchMandatoryCourse.studyProgramme))
	UNION
	SELECT personalCodeNumber as student, course
	FROM student, programmeMandatoryCourse
	WHERE (student.studyProgramme = programmeMandatoryCourse.studyProgramme)
	) AS Temp
	WHERE (student, course)  NOT IN (SELECT student, coursecode from PassedCourses);

CREATE VIEW PathToGraduation1 AS
 SELECT student.personalcodenumber, sum(passedcourses.credits) AS sum
   FROM student
   LEFT JOIN passedcourses ON student.personalcodenumber = passedcourses.student
  GROUP BY student.personalcodenumber
  ORDER BY student.personalcodenumber, sum;

  CREATE VIEW PathToGraduation2 AS
  SELECT student.personalcodenumber, Count(UnreadMandatory.course)
   FROM student
   LEFT JOIN UnreadMandatory ON student.personalcodenumber = UnreadMandatory.student
  GROUP BY student.personalcodenumber
  ORDER BY student.personalcodenumber;



