CREATE FUNCTION regCheck() RETURNS trigger AS $$
    BEGIN

        nbrOfRegisterend := (SELECT Count(student)
                            FROM Registrations
                            WHERE course = NEW.course);

        maxNbrOfStudents := (SELECT nbrOfStudents 
                            FROM restrictedCourse
                            WHERE course = NEW.course);

        IF nbrOfRegisterend >= maxNbrOfStudents THEN
            INSERT values() INTO appliedFor values(NEW.student, NEW.course, default);
        END IF;

        IF EXISTS(SELECT student FROM isAttending WHERE isAttending.student = New.student AND isAttending.course = NEW.course);
        OR EXISTS(SELECT student FROM PassedCourses WHERE PassedCourses.student = New.student AND PassedCourses.coursecode = NEW.course);
        THEN
            RAISE EXCEPTION '% is already attending or have passed this course', NEW.student;
        END IF;

        IF (NOT EXISTS(SELECT student FROM prerequisites JOIN PassedCourses on requiredCourse = coursecode WHERE 
            AND  student = NEW.student 
            AND course = NEW.course))
        THEN
            RAISE EXCEPTION '% have not passed all required courses', NEW.student;
        END IF;

        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER regCheck BEFORE INSERT OR UPDATE ON Registrations
    FOR EACH ROW EXECUTE PROCEDURE regCheck();
