
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


CREATE VIEW UnreadMandatory1 AS
SELECT personalCodeNumber, course
	FROM student, programMandatoryCourse WHERE student.studyProgramme = programMandatoryCourse.name
	UNION
SELECT personalCodeNumber, course 
	FROM student, branchMandatoryCourse WHERE student.branch = branchMandatoryCourse.branch



	


CREATE VIEW UnreadMandatory AS
	SELECT student, course
	FROM student, branchMandatoryCourse, branchRecommendedCourse, programmeMandatoryCourse
	WHERE (student.personalCodeNumber, course.coursecode)  NOT IN (SELECT student, coursecode from PassedCourses);

