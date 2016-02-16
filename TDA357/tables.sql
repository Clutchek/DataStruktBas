CREATE TABLE department(
	name varchar NOT NULL UNIQUE,
	abbreviation VARCHAR PRIMARY KEY);

CREATE TABLE studyProgramme(
	abbreviation VARCHAR NOT NULL,
	name VARCHAR PRIMARY KEY);

CREATE TABLE "hostedBy"(​
	departmentName VARCHAR NOT NULL,
	studyProgramme VARCHAR NOT NULL,
	Foreign key (department) references department(name),
	Foreign key (studyProgramme​) references studyProgramme(name),
	primary key (department,studyProgramme));

CREATE TABLE branch(
	name​ VARCHAR NOT NULL,
	studyProgramme VARCHAR NOT NULL,
	studyProgramme​ references studyProgramme(name),
	primary key (name, studyProgramme));

CREATE TABLE student(
	personalCodeNumber CHAR(10) PRIMARY KEY check regexp_matches(personalCodeNumber, 
    E'[0-9]')), 
	loginId VARCHAR NOT NULL UNIQUE,
	name VARCHAR NOT NULL, 
	studyProgramme VARCHAR NOT NULL, 
	branch VARCHAR default NULL,
	Foreign key (studyProgramme, branch​) references studyProgramme(name));

CREATE TABLE course(
	courseCode VARCHAR primary key,
	name VARCHAR NOT NULL,
	credits INT CHECK (credits >= 0),
	department VARCHAR NOT NULL references department(name));

CREATE TABLE classification(
	name VARCHAR primary key);

CREATE TABLE courseClassification(
	course VARCHAR references course(courseCode),
	classificatiion VARCHAR references classification(name)

CREATE TABLE restrictedCourse(
	course VARCHAR primary key references course(courseCode),
	nbrOfStudents INT check (nbrOfStudents > 0));


