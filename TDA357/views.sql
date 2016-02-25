
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

CREATE VIEW PathToGraduation AS
	WITH RecommendedPassedCourses AS(
	SELECT student, credits AS RecCredits
  	FROM( SELECT distinct on (student,coursecode)*
  	FROM 
  	(PassedCourses JOIN branchRecommendedCourse
    ON PassedCourses.courseCode = branchRecommendedCourse.course )AS REC)AS SEL),

  PassedClass AS(
  	SELECT * from (passedcourses JOIN courseClassification on passedcourses.coursecode = courseclassification.course)),  

  StudentTotalCredits AS(
 	 SELECT student.personalcodenumber as student, coalesce(sum(passedcourses.credits),0) AS Totalcredits
	 FROM student
	 LEFT JOIN passedcourses ON student.personalcodenumber = passedcourses.student
	 GROUP BY student.personalcodenumber
	 ORDER BY student.personalcodenumber, Totalcredits),

  SudentUnreadCourses AS(
    SELECT student.personalcodenumber as student, Count(UnreadMandatory.course) as nbrOfUnreadCourses
    FROM student
    LEFT JOIN UnreadMandatory ON student.personalcodenumber = UnreadMandatory.student
    GROUP BY student.personalcodenumber
    ORDER BY student.personalcodenumber),

  StudentClassificationCredits AS (
	SELECT student.personalcodenumber as student,
 	sum( CASE WHEN classification = 'Math' THEN PassedClass.credits ELSE 0 END) as mathCredits,
 	sum( CASE WHEN classification = 'Research' THEN PassedClass.credits ELSE 0 END) as researchCredits,
 	sum( CASE WHEN classification = 'Seminar' THEN 1 ELSE 0 END) as nbrOfSeminarCourses
   	FROM student LEFT JOIN PassedClass ON student.personalcodenumber = PassedClass.student
  	GROUP BY student.personalcodenumber
  	ORDER BY student.personalcodenumber)



	SELECT TempTable.student, totalcredits, nbrOfUnreadCourses, mathCredits, researchCredits, nbrofseminarcourses, CASE WHEN nbrOfUnreadCourses < 1 AND mathCredits >= 20 AND researchCredits >= 10 AND nbrOfSeminarCourses >= 1 THEN 'YES' ELSE 'NO' END AS qualifiedForGraduation
    FROM 
    ((StudentTotalCredits natural Join  
    SudentUnreadCourses) natural Join 
    StudentClassificationCredits) AS TempTable
    LEFT JOIN RecommendedPassedCourses on RecommendedPassedCourses.student = TempTable.student;













