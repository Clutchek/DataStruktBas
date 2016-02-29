
CREATE FUNCTION regCheck() RETURNS trigger AS $$
    BEGIN

        --null, kurskod existerar
        IF NEW.student IS NULL OR NEW.course IS NULL THEN
            RAISE EXCEPTION 'Input was null'

        IF NOT EXISTS(SELECT course FROM course WHERE course.coursecode = NEW.course) THEN
            RAISE EXCEPTION 'Chosen course does not exist'

        IF NOT EXISTS(SELECT personalCodeNumber FROM student WHERE student.personalCodeNumber = NEW.student) THEN
            RAISE EXCEPTION 'Student does not exist'

        IF EXISTS(SELECT student FROM isAttending WHERE isAttending.student = New.student AND isAttending.course = NEW.course)
        OR EXISTS(SELECT student FROM PassedCourses WHERE PassedCourses.student = New.student AND PassedCourses.coursecode = NEW.course)
        THEN
            RAISE EXCEPTION '% is already attending or have passed this course', NEW.student;
        END IF;

        nbrOfRequiredCourses := (SELECT COUNT(course) FROM prerequisites WHERE course = NEW.course);

        nbrOfPassedCourses := (SELECT COUNT(student) FROM prerequisites JOIN PassedCourses on requiredCourse = coursecode WHERE 
            AND  student = NEW.student 
            AND course = NEW.course);

        IF (nbrOfRequiredCourses > nbrOfPassedCourses)
        THEN
            RAISE EXCEPTION '% have not passed all required courses', NEW.student;
        END IF;

        nbrOfRegisterend := (SELECT Count(student)
                            FROM Registrations
                            WHERE course = NEW.course);

        maxNbrOfStudents := (SELECT nbrOfStudents 
                            FROM restrictedCourse
                            WHERE course = NEW.course);

        IF nbrOfRegisterend >= maxNbrOfStudents THEN
            INSERT values(NEW.student, NEW.course, default) INTO appliedFor;
        ELSE
            INSERT values(NEW.student, NEW.course) INTO isAttending;
        END IF;


        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER regCheck BEFORE INSERT Registrations
    FOR EACH ROW EXECUTE PROCEDURE regCheck();




CREATE FUNCTION unregCheck() RETURNS trigger AS $$
    BEGIN

    --Kanske kolla efter nullvärden?

    IF EXISTS(SELECT student FROM appliedFor WHERE student = OLD.student AND course = OLD.course)
    THEN DELETE FROM appliedFor WHERE student = OLD.student AND course = OLD.course
    END IF;

    IF EXISTS(SELECT student FROM isAttending WHERE student = OLD.student AND course = OLD.course)
    THEN DELETE FROM isAttending WHERE student = OLD.student AND course = OLD.course
        nbrOfRegisterend := (SELECT Count(student)
                            FROM Registrations
                            WHERE course = OLD.course);

        maxNbrOfStudents := (SELECT nbrOfStudents 
                            FROM restrictedCourse
                            WHERE course = OLD.course);

        IF (nbrOfRegisterend < maxNbrOfStudents)
            firstStudent := SELECT student FROM coursequeuepositions WHERE course = OLD.course AND row_number = min(row_number)

            IF firstStudent IS NOT NULL
            INSERT values(firstStudent, OLD.course) INTO isAttending;
            END IF
        END IF

    ELSE
        RAISE EXCEPTION '% is not attending %', OLD.student, OLD.course
    END IF;

    RETURN OLD;

    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER unregCheck BEFORE DELETE ON Registrations
    FOR EACH ROW EXECUTE PROCEDURE unreg();
