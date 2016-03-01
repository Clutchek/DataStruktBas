\! echo "---Test for unregCheck trigger---";
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


\! echo "Test1: DELETE student who is not registrated";
	DELETE FROM Registrations WHERE course = 'MMA321' AND student = '941208-1337';
	SELECT * FROM Registrations;
\! echo "";
\! echo "Test2: DELETE student who is registrated";

	DELETE FROM Registrations WHERE course = 'MMA321' AND student = '941201-1337';
	SELECT * FROM Registrations;
\! echo "";
\! echo "Test3: DELETE student who is wating";

	DELETE FROM Registrations WHERE course = 'MMA321' AND student = '941203-1337';
	SELECT * FROM Registrations;
\! echo "";
\! echo "Test4: DELETE from course who is overfull";
	INSERT INTO Registrations values ('MMA321','941201-1337',null);
	INSERT INTO isAttending values ('941203-1337','MMA321');

	SELECT * FROM Registrations;

	DELETE FROM Registrations WHERE course = 'MMA321' AND student = '941203-1337';


\! echo "Student '941204-1337' should still have status 'waiting' on course 'MMA321', because course has been over full";
	SELECT * FROM Registrations;
\! echo "";

