--Rimliga tester
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