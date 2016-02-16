CREATE TABLE department(
	name VARCHAR NOT NULL UNIQUE,
	abbreviation VARCHAR PRIMARY KEY);

CREATE TABLE studyProgramme(
	abbreviation VARCHAR NOT NULL,
	name VARCHAR PRIMARY KEY);

CREATE TABLE hostedBy(​
	department VARCHAR NOT NULL​ references department(name),
	studyProgramme​ VARCHAR NOT NULL references studyProgramme(name),
	primary key (department,studyProgramme));

CREATE TABLE student(
	personalCodeNumber VARCHAR PRIMARY KEY, 
	name VARCHAR NOT NULL, 
	studyProgramme VARCHAR NOT NULL, 
	branch VARCHAR default NULL);
