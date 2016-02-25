CREATE FUNCTION regCheck() RETURNS trigger AS $$
    BEGIN

        nbrOfRegisterend := (SELECT Count(student)
                            FROM Registrations
                            WHERE course = NEW.course);

        maxNbrOfStudents := (SELECT nbrOfStudents 
                            FROM restrictedCourse
                            WHERE course = NEW.course);

        IF nbrOfRegisterend >= maxNbrOfStudents THEN
            --RAISE EXCEPTION '% is full', NEW.course;
            --adda till waitinglist istället hiihihihihihihiihhiihihhhhhhhhhhhhhhhihihiihihihihihiihhihihi
            INSERT values() INTO appliedFor values(NEW.student, NEW.course, default);
        END IF;

        IF EXISTS(SELECT student FROM isAttending WHERE isAttending.student = New.student AND isAttending.course = NEW.course);
        OR EXISTS(SELECT student FROM PassedCourses WHERE PassedCourses.student = New.student AND PassedCourses.coursecode = NEW.course);
        THEN
            RAISE EXCEPTION '% is already attending or have passed this course', NEW.student;
        END IF;

        IF 

        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER regCheck BEFORE INSERT OR UPDATE ON Registrations
    FOR EACH ROW EXECUTE PROCEDURE regCheck();
