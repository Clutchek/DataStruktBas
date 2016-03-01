
CREATE FUNCTION regCheck() RETURNS trigger AS $$
    DECLARE nbrOfRegisterend INT;
    DECLARE nbrOfRequiredCourses INT;
    DECLARE nbrOfPassedCourses INT;
    DECLARE maxNbrOfStudents INT;

    BEGIN

        --null, kurskod existerar
        IF NEW.student IS NULL THEN
            RAISE EXCEPTION 'Student in input was null';
        END IF;

        IF NEW.course IS NULL THEN
            RAISE EXCEPTION 'Course in input was null';
        END IF;

        IF NOT EXISTS(SELECT course FROM course WHERE course.coursecode = NEW.course) THEN
            RAISE EXCEPTION 'Chosen course does not exist';
        END IF;

        IF NOT EXISTS(SELECT personalCodeNumber FROM student WHERE student.personalCodeNumber = NEW.student) THEN
            RAISE EXCEPTION 'Student does not exist';
        END IF;

        IF EXISTS(SELECT student FROM isAttending WHERE isAttending.student = New.student AND isAttending.course = NEW.course)
        OR EXISTS(SELECT student FROM PassedCourses WHERE PassedCourses.student = New.student AND PassedCourses.coursecode = NEW.course)
        OR EXISTS(SELECT student FROM PassedCourses WHERE appliedFor.student = New.student AND appliedFor.restrictedCourse = NEW.course)
        THEN
            RAISE EXCEPTION '% have already applied for this course, is attending the course or have passed this course', NEW.student;
        END IF;

        nbrOfRequiredCourses := (SELECT COUNT(course) FROM prerequisites WHERE course = NEW.course);

        nbrOfPassedCourses := (SELECT COUNT(student) FROM prerequisites JOIN PassedCourses on requiredCourse = coursecode WHERE 
            student = NEW.student 
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
            INSERT INTO appliedFor values(NEW.student, NEW.course, default);
        ELSE
            INSERT INTO isAttending values(NEW.student, NEW.course) ;
        END IF;


        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER regCheck INSTEAD OF INSERT ON Registrations
    FOR EACH ROW EXECUTE PROCEDURE regCheck();




CREATE FUNCTION unregCheck() RETURNS trigger AS $$
    DECLARE nbrOfRegisterend INT;
    DECLARE maxNbrOfStudents INT;
    DECLARE firstStudent VARCHAR;
    BEGIN

    --Kanske kolla efter nullvärden?

    IF EXISTS(SELECT student FROM appliedFor WHERE student = OLD.student AND restrictedCourse = OLD.course)
    THEN DELETE FROM appliedFor WHERE student = OLD.student AND course = OLD.course;
    END IF;

    IF EXISTS(SELECT student FROM isAttending WHERE student = OLD.student AND course = OLD.course)
    THEN DELETE FROM isAttending WHERE student = OLD.student AND course = OLD.course;
        --limited course
        IF EXISTS(SELECT course FROM restrictedCourse WHERE course = OLD.course) THEN
            nbrOfRegisterend := (SELECT Count(student)
                                FROM Registrations
                                WHERE course = OLD.course);

            maxNbrOfStudents := (SELECT nbrOfStudents 
                                FROM restrictedCourse
                                WHERE course = OLD.course);

            IF (nbrOfRegisterend < maxNbrOfStudents) THEN
                firstStudent := (SELECT student FROM coursequeuepositions WHERE course = OLD.course AND row_number = min(row_number));

                IF firstStudent IS NOT NULL THEN
                INSERT INTO isAttending values(firstStudent, OLD.course);
                END IF;
            END IF;
        END IF;

    END IF;

    RETURN OLD;

    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER unregCheck INSTEAD OF DELETE ON Registrations
    FOR EACH ROW EXECUTE PROCEDURE unregCheck();
