CREATE TABLE department(
	name varchar NOT NULL UNIQUE,
	abbreviation VARCHAR PRIMARY KEY);

CREATE TABLE studyProgramme(
	name VARCHAR PRIMARY KEY,
	abbreviation VARCHAR NOT NULL);

CREATE TABLE hostedBy(
  departmentName VARCHAR NOT NULL,
  studyProgramme VARCHAR NOT NULL,
  Foreign key (departmentName) references department(abbreviation),
  Foreign key (studyProgramme) references studyProgramme(name),
  primary key (departmentName,studyProgramme));

CREATE TABLE branch(
	name VARCHAR,
	studyProgramme VARCHAR,
	primary key (name, studyProgramme),
	Foreign key(studyProgramme) references studyProgramme(name));

CREATE TABLE student(
	personalCodeNumber CHAR(11) CONSTRAINT student_id_format CHECK(personalCodeNumber ~ '\d{2}(1[012]|0[1-9])[0123]\d\-\d{4}$'),
	primary key (personalCodeNumber),
	loginId VARCHAR NOT NULL UNIQUE,
	name VARCHAR NOT NULL,
	studyProgramme VARCHAR NOT NULL,
	branch VARCHAR default NULL,
	foreign key (studyProgramme) references studyProgramme(name),
	foreign key (branch, studyProgramme) references branch(name, studyProgramme));
	

CREATE TABLE course(
	courseCode VARCHAR primary key,
	name VARCHAR NOT NULL,
	credits INT CHECK (credits >= 0),
	department VARCHAR NOT NULL references department(abbreviation));

CREATE TABLE classification(
	name VARCHAR primary key);

CREATE TABLE courseClassification(
	course VARCHAR references course(courseCode),
	classification VARCHAR references classification(name),
	PRIMARY KEY (course, classification));

CREATE TABLE restrictedCourse(
	course VARCHAR primary key references course(courseCode),
	nbrOfStudents INT check (nbrOfStudents > 0));
	

CREATE TABLE prerequisites(
	course VARCHAR NOT NULL references course(courseCode),
	requiredCourse VARCHAR NOT NULL references course(courseCode),
	PRIMARY KEY (course, requiredCourse));

CREATE TABLE appliedFor(
	student VARCHAR NOT NULL references student(personalCodeNumber),
	restrictedCourse VARCHAR NOT NULL references restrictedCourse(course),
	timestamp timestamp default current_timestamp,
	UNIQUE(restrictedCourse,timestamp),
	PRIMARY KEY (student,restrictedCourse));


CREATE TYPE GRADE AS ENUM('U','3','4','5');
CREATE TABLE graded(
	student  VARCHAR  NOT NULL references student(personalCodeNumber),
	course VARCHAR NOT NULL references course(courseCode),
	grade GRADE NOT NULL,
	PRIMARY KEY (student,course));

	
CREATE TABLE isAttending(
	student VARCHAR NOT NULL references student(personalCodeNumber),
	course VARCHAR NOT NULL references course(courseCode),
	PRIMARY KEY (student,course));


CREATE TABLE programmeMandatoryCourse(
	studyProgramme VARCHAR NOT NULL references StudyProgramme(name),
	course VARCHAR NOT NULL references Course(courseCode),
	PRIMARY KEY (studyProgramme, course));

CREATE TABLE branchMandatoryCourse(
	branch VARCHAR NOT NULL,
	studyProgramme VARCHAR NOT NULL,
	course VARCHAR NOT NULL references Course(courseCode),
	Foreign key(branch,studyProgramme) references branch(name, studyProgramme),
	PRIMARY KEY (branch, studyProgramme, course));

CREATE TABLE branchRecommendedCourse(
	branch VARCHAR NOT NULL,
	studyProgramme VARCHAR NOT NULL,
	course VARCHAR NOT NULL references Course(courseCode),
	Foreign key(branch,studyProgramme) references branch(name, studyProgramme),
	PRIMARY KEY (branch, studyProgramme, course));


--department
INSERT INTO department values('Department1', 'dep1');
INSERT INTO department values('Department2', 'dep2');


--studyProgramme
INSERT INTO studyProgramme values('StudyProgramme1', 'study1');
INSERT INTO studyProgramme values('StudyProgramme2', 'study2');
INSERT INTO studyProgramme values('StudyProgramme3', 'study3');
INSERT INTO studyProgramme values('StudyProgramme4', 'study4');


--hostedBy
INSERT INTO hostedBy values('dep1', 'StudyProgramme1');
INSERT INTO hostedBy values('dep1', 'StudyProgramme2');
INSERT INTO hostedBy values('dep2', 'StudyProgramme3');
INSERT INTO hostedBy values('dep2', 'StudyProgramme4');


--branch
INSERT INTO branch values('Branch1', 'StudyProgramme1');
INSERT INTO branch values('Branch2', 'StudyProgramme1');
INSERT INTO branch values('Branch3', 'StudyProgramme2');
INSERT INTO branch values('Branch4', 'StudyProgramme3');
INSERT INTO branch values('Branch5', 'StudyProgramme3');
INSERT INTO branch values('Branch6', 'StudyProgramme4');


--student
INSERT INTO student values('941201-1337', 'loginId1','Student Studentsson1', 'StudyProgramme1',null);
INSERT INTO student values('941202-1337', 'loginId2','Student Studentsson2', 'StudyProgramme1','Branch1');
INSERT INTO student values('941203-1337', 'loginId3','Student Studentsson3', 'StudyProgramme1','Branch2');
INSERT INTO student values('941204-1337', 'loginId4','Student Studentsson4', 'StudyProgramme2','Branch3');
INSERT INTO student values('941205-1337', 'loginId5','Student Studentsson5', 'StudyProgramme3','Branch4');
INSERT INTO student values('941206-1337', 'loginId6','Student Studentsson6', 'StudyProgramme3','Branch5');
INSERT INTO student values('941207-1337', 'loginId7','Student Studentsson7', 'StudyProgramme4','Branch6');
INSERT INTO student values('941208-1337', 'loginId8','Student Studentsson8', 'StudyProgramme1','Branch1');
INSERT INTO student values('941209-1337', 'loginId9','Student Studentsson9', 'StudyProgramme1','Branch2');
INSERT INTO student values('941210-1337', 'loginId10','Student Studentsson10', 'StudyProgramme2','Branch3');
INSERT INTO student values('941211-1337', 'loginId11','Student Studentsson11', 'StudyProgramme3','Branch4');
INSERT INTO student values('941212-1337', 'loginId12','Student Studentsson12', 'StudyProgramme3','Branch5');
INSERT INTO student values('941213-1337', 'loginId13','Student Studentsson13', 'StudyProgramme4','Branch6');



-- classifications
INSERT INTO classification values('Math');
INSERT INTO classification values('Research');
INSERT INTO classification values('Seminar');



--dep1 courses
INSERT INTO course values ('tda357','Databases',15, 'dep1');
INSERT INTO course values ('tda416','DataStructures',15, 'dep1');
INSERT INTO course values ('tmv206','Linear Math',15, 'dep1');
INSERT INTO course values ('try123', 'theoretical data', 15, 'dep1');


--dep2 courses
INSERT INTO course values ('mve045','Envar',15, 'dep2');
INSERT INTO course values ('mve055','Matstat',15, 'dep2');
INSERT INTO course values ('tmv200','Discrete Math',15, 'dep2');
INSERT INTO course values ('try234', 'theoretical math', 15, 'dep2');
INSERT INTO course values ('MMA321', 'mixed martial arts', 15, 'dep2');


--courseClassificaiton
INSERT INTO courseClassification values ('mve045','Math');
INSERT INTO courseClassification values ('mve055','Math');
INSERT INTO courseClassification values ('tmv206','Math');
INSERT INTO courseClassification values ('tda357','Seminar');
INSERT INTO courseClassification values ('mve045','Seminar');
INSERT INTO courseClassification values ('mve055','Seminar');
INSERT INTO courseClassification values ('try234','Research');
INSERT INTO courseClassification values ('try123','Research');




--restrictedCourse
INSERT INTO restrictedCourse values ('try234',15);
INSERT INTO restrictedCourse values ('try123',10);
INSERT INTO restrictedCourse values ('MMA321', 1);


--Prerequisites
INSERT INTO prerequisites values ('try123','tda357');
INSERT INTO prerequisites values ('try234','mve045');

--graded

INSERT INTO graded values ('941201-1337','mve045', 'U');


--04 will pass
INSERT INTO graded values ('941204-1337','mve045', '5');
INSERT INTO graded values ('941204-1337','mve055', '3');
INSERT INTO graded values ('941204-1337','tmv206', '3');
INSERT INTO graded values ('941204-1337','tda357', '3');
INSERT INTO graded values ('941204-1337','try123', '4');
INSERT INTO graded values ('941204-1337','tda416', '4');


--02 will pass
INSERT INTO graded values ('941202-1337','mve045', '5');
INSERT INTO graded values ('941202-1337','tmv206', '5');
INSERT INTO graded values ('941202-1337','tda357', '5');
INSERT INTO graded values ('941202-1337','try234', '5');
INSERT INTO graded values ('941202-1337','mve055', '5');



--isAttending
INSERT INTO isAttending values ('941202-1337','mve055');
INSERT INTO isAttending values ('941203-1337','mve055');
INSERT INTO isAttending values ('941204-1337','mve055');

--programMandatoryCourse

INSERT INTO programmeMandatoryCourse values('StudyProgramme2','tda416');
INSERT INTO programmeMandatoryCourse values('StudyProgramme2','mve055');
INSERT INTO programmeMandatoryCourse values('StudyProgramme1','tda357');
INSERT INTO programmeMandatoryCourse values('StudyProgramme3','tda416');
INSERT INTO programmeMandatoryCourse values('StudyProgramme4','tmv200');

--branchMandatoryCourse
INSERT INTO branchMandatoryCourse values('Branch1', 'StudyProgramme1', 'mve045');
INSERT INTO branchMandatoryCourse values('Branch1', 'StudyProgramme1', 'mve055');
INSERT INTO branchMandatoryCourse values('Branch2', 'StudyProgramme1', 'mve045');
INSERT INTO branchMandatoryCourse values('Branch3', 'StudyProgramme2', 'mve045');
INSERT INTO branchMandatoryCourse values('Branch4', 'StudyProgramme3', 'mve045');
INSERT INTO branchMandatoryCourse values('Branch5', 'StudyProgramme3', 'mve045');
INSERT INTO branchMandatoryCourse values('Branch6', 'StudyProgramme4', 'mve045');

--branchRecommendedCourse


INSERT INTO branchRecommendedCourse values('Branch1', 'StudyProgramme1', 'tmv206');
INSERT INTO branchRecommendedCourse values('Branch1', 'StudyProgramme1', 'tmv200');
INSERT INTO branchRecommendedCourse values('Branch2', 'StudyProgramme1', 'tmv206');
INSERT INTO branchRecommendedCourse values('Branch3', 'StudyProgramme2', 'tmv206');
INSERT INTO branchRecommendedCourse values('Branch4', 'StudyProgramme3', 'tmv206');
INSERT INTO branchRecommendedCourse values('Branch5', 'StudyProgramme3', 'tmv206');
INSERT INTO branchRecommendedCourse values('Branch6', 'StudyProgramme4', 'tmv206');




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


CREATE VIEW CourseQueuePositions AS
    
        SELECT AF.student, AF.restrictedCourse, AF.timestamp, ROW_NUMBER() OVER(PARTITION BY AF.restrictedCourse ORDER BY AF.timestamp)
    FROM appliedFor AS AF GROUP BY AF.restrictedCourse, AF.student;









