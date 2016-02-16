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
	personalCodeNumber CHAR(10),
	primary key (personalCodeNumber), 
	loginId VARCHAR NOT NULL UNIQUE,
	name VARCHAR NOT NULL,
	studyProgrammes VARCHAR NOT NULL, 
	branch VARCHAR default NULL,
	Foreign key (studyProgrammes) references studyProgramme(name),
	Foreign key (branch, studyProgrammes​) references branch(name,studyProgramme));

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




