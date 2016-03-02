
\! echo "---Tests for first trigger---"
\! echo ""

\! echo "This is what registrations looks like from the start"
Select * from Registrations;
\! echo ""

\! echo "Test: Inserting course as null"
INSERT INTO Registrations values(null, '941201-1337', null);
\! echo ""


\! echo "Test: Inserting student as null"
INSERT INTO Registrations values('mve045', null, null);
\! echo ""

\! echo "Test: Inserting with student that isn't in database"
INSERT INTO Registrations values('mve045', '941101-1337', null);
\! echo ""

\! echo "Test: Inserting with course that isn't in database"
INSERT INTO Registrations values('mve0455', '941201-1337', null);
\! echo ""

\! echo "Test where student is already attending class"
INSERT INTO Registrations values('insert1', '941205-1337', null);
\! echo ""

\! echo "Test where student(941207-1337) has already applied for course"
INSERT INTO Registrations values('try123', '941207-1337', null);
\! echo ""

\! echo "Test where student(941206-1337) has already passed course"
INSERT INTO Registrations values('insert1', '941206-1337', null);
\! echo ""

\! echo "Test where student(941208-1337) has not passed all prerequisites"
INSERT INTO Registrations values('insert1', '941208-1337', null);
\! echo ""

\! echo "Test succesfully adding student '941209-1337' to course"
INSERT INTO Registrations values('insert1', '941209-1337', null);

Select * from Registrations;
\! echo ""

\! echo "Test succesfully adding student(941209-1337) to restrictedCourse(insert2)"
INSERT INTO Registrations values('insert2', '941209-1337', null);
Select * from Registrations;
\! echo ""

\! echo "Test to add student(941208-1337) where restricted course(insert2) is full"
INSERT INTO Registrations values('insert2', '941208-1337', null);
Select * from Registrations;
\! echo ""

\! echo "---Test for secound trigger---";
\! echo "";

	INSERT INTO Registrations values ('MMA321','941201-1337',null);
	INSERT INTO Registrations values ('MMA321','941202-1337',null);
	INSERT INTO Registrations values ('MMA321','941203-1337',null);
	INSERT INTO Registrations values ('MMA321','941204-1337',null);
	INSERT INTO Registrations values ('MMA321','941205-1337',null);
	INSERT INTO Registrations values ('MMA321','941206-1337',null);
	INSERT INTO Registrations values ('MMA321','941207-1337',null);

\! echo "This is how the table looks from the start";
	SELECT * FROM Registrations;
\! echo "";


\! echo "Test1: DELETE student '941208-1337' who is not regisered to 'MMA321'";
	DELETE FROM Registrations WHERE course = 'MMA321' AND student = '941208-1337';
	SELECT * FROM Registrations;
\! echo "";
\! echo "Test2: DELETE student '941201-1337' who is regisered to 'MMA321'";

	DELETE FROM Registrations WHERE course = 'MMA321' AND student = '941201-1337';
	SELECT * FROM Registrations;
\! echo "";
\! echo "Test3: DELETE student '941203-1337' who is waiting for 'MMA321' ";

	DELETE FROM Registrations WHERE course = 'MMA321' AND student = '941203-1337';
	SELECT * FROM Registrations;
\! echo "";
\! echo "Test4: DELETE from course 'MMA321' who is overfull ";
	INSERT INTO Registrations values ('MMA321','941201-1337',null);
	INSERT INTO isAttending values ('941203-1337','MMA321');

	SELECT * FROM Registrations;

	\! echo "Student '941204-1337' should still have status 'waiting' on course 'MMA321', because course has been overfull";

	DELETE FROM Registrations WHERE course = 'MMA321' AND student = '941203-1337';

	SELECT * FROM Registrations;
\! echo "";
