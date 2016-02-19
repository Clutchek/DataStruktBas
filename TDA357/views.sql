
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

CREATE VIEW RecomendedPasssedCourses AS
	SELECT student, credits AS RecCredits
  	FROM( SELECT distinct on (student,coursecode)*
  	FROM 
  	(PassedCourses JOIN branchRecommendedCourse
    ON PassedCourses.courseCode = branchRecommendedCourse.course )AS REC)AS SEL;


CREATE VIEW nbrOfUnreadMandatory
	SELECT student, count(student) as nbrOfUnreadCourses
	FROM UnreadMandatory
	GROUP BY student;


CREATE VIEW PassedClass AS
  	SELECT * from (passedcourses JOIN courseClassification on passedcourses.coursecode = courseclassification.course);




CREATE VIEW PathToGraduation1 AS
 	SELECT student.personalcodenumber as student, sum(passedcourses.credits) AS Totalcredits
	FROM student
	LEFT JOIN passedcourses ON student.personalcodenumber = passedcourses.student
	GROUP BY student.personalcodenumber
	ORDER BY student.personalcodenumber, sum;

CREATE VIEW PathToGraduation2 AS
  SELECT student.personalcodenumber as student, Count(UnreadMandatory.course)
   FROM student
   LEFT JOIN UnreadMandatory ON student.personalcodenumber = UnreadMandatory.student
  GROUP BY student.personalcodenumber
  ORDER BY student.personalcodenumber;

  CREATE VIEW PathToGraduation3 AS
	SELECT student.personalcodenumber as student,
 	sum( CASE WHEN classification = 'Math' THEN PassedClass.credits ELSE 0 END) as mathCredits,
 	sum( CASE WHEN classification = 'Research' THEN PassedClass.credits ELSE 0 END) as researchCredits,
 	sum( CASE WHEN classification = 'Seminar' THEN 1 ELSE 0 END) as nbrOfSeminarCourses
   	FROM student LEFT JOIN PassedClass ON student.personalcodenumber = PassedClass.student
  	GROUP BY student.personalcodenumber
  	ORDER BY student.personalcodenumber;



CREATE VIEW PathToGraduation AS
	SELECT *
	FROM 
	(PathToGraduation1 Join  
	PathToGraduation2 on student) Join 
	PathToGraduation3 on student;

























--backup

  CREATE VIEW PathToGraduation2 AS
	SELECT student.personalcodenumber as student, sum(passedcourses.credits) AS credits,
 	sum( CASE WHEN classification = 'Math' THEN passedcourses.credits ELSE 0 END) as mathCredits
   	FROM (student LEFT JOIN (SELECT * from (passedcourses JOIN courseClassification on passedcourses.coursecode = courseclassification.course) as passedClass ON student.personalcodenumber = passedClass.student)) as fromTable
  	GROUP BY student.personalcodenumber
  	ORDER BY student.personalcodenumber, sum;