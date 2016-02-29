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
            INSERT values(NEW.student, NEW.course);
        END IF;


        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER regCheck BEFORE INSERT OR UPDATE ON Registrations
    FOR EACH ROW EXECUTE PROCEDURE regCheck();
