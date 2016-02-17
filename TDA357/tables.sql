CREATE TABLE department(
	name varchar NOT NULL UNIQUE,
	abbreviation VARCHAR PRIMARY KEY);

CREATE TABLE studyProgramme(
	abbreviation VARCHAR NOT NULL,
	name VARCHAR PRIMARY KEY);

CREATE TABLE hostedBy(
  departmentName VARCHAR NOT NULL,
  studyProgramme VARCHAR NOT NULL,
  Foreign key (departmentName) references department(name),
  Foreign key (studyProgramme) references studyProgramme(name),
  primary key (departmentName,studyProgramme));

CREATE TABLE branch(
	name VARCHAR,
	studyProgramme VARCHAR,
	primary key (name, studyProgramme),
	Foreign key(studyProgramme) references studyProgramme(name));

CREATE TABLE student(
	personalCodeNumber CHAR(10) CONSTRAINT student_id_format CHECK(personalCodeNumber ~ '^(19|20)\d{2}(1[012]|0[1-9])[0123]\d\-\d{4}$'),
	primary key (personalCodeNumber),
	loginId VARCHAR NOT NULL UNIQUE,
	name VARCHAR NOT NULL,
	studyProgramme VARCHAR NOT NULL,
	branch VARCHAR default NULL,
	foreign key (studyProgramme) references studyProgramme(name));
	ALTER TABLE student ADD foreign key (branch, studyProgramme) references branch(name, studyProgramme);

CREATE TABLE course(
	courseCode VARCHAR primary key,
	name VARCHAR NOT NULL,
	credits INT CHECK (credits >= 0),
	department VARCHAR NOT NULL references department(name));

CREATE TABLE classification(
	name VARCHAR primary key);

CREATE TABLE courseClassification(
	course VARCHAR references course(courseCode),
	classificatiion VARCHAR references classification(name));

CREATE TABLE restrictedCourse(
	course VARCHAR primary key references course(courseCode),
	nbrOfStudents INT check (nbrOfStudents > 0));
	

CREATE TABLE Prerequisites(
	course VARCHAR NOT NULL references course(courseCode),
	requredCourse VARCHAR NOT NULL references course(courseCode),
	PRIMARY KEY (course, requredCourse));

CREATE TABLE AppliedFor(
	student VARCHAR NOT NULL references student(personalCodeNumber),
	restrictedCourse VARCHAR NOT NULL references restrictedCourse(course),
	timestamp timestamp default current_timestamp,
	UNIQUE(restrictedCourse,timestamp),
	PRIMARY KEY (student,restrictedCourse));


CREATE TYPE GRADE AS ENUM('U','3','4','5');
CREATE TABLE Graded(
	student  VARCHAR  NOT NULL references student(personalCodeNumber),
	course VARCHAR NOT NULL references course(courseCode),
	grade GRADE NOT NULL,
	PRIMARY KEY (student,course));

	
CREATE TABLE IsAttending(
	student VARCHAR NOT NULL references student(personalCodeNumber),
	course VARCHAR NOT NULL references course(courseCode),
	PRIMARY KEY (student,course));


CREATE TABLE ProgramMandatoryCourse(
	studyProgramme VARCHAR NOT NULL references StudyProgramme(name),
	course VARCHAR NOT NULL references Course(courseCode),
	PRIMARY KEY (studyProgramme, course));

CREATE TABLE BranchMandatoryCourse(
	branch VARCHAR NOT NULL,
	studyProgramme VARCHAR NOT NULL,
	course VARCHAR NOT NULL references Course(courseCode),
	(branch,studyProgramme) references branch(name, studyProgramme),
	PRIMARY KEY (branch, studyProgramme, course));

CREATE TABLE BranchRecommendedCourse(
	branch VARCHAR NOT NULL,
	studyProgramme VARCHAR NOT NULL,
	course VARCHAR NOT NULL references Course(courseCode),
	(branch,studyProgramme) references branch(name, studyProgramme),
	PRIMARY KEY (branch, studyProgramme, course));
