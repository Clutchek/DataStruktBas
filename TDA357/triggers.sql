CREATE FUNCTION unregCheck() RETURNS trigger AS $unregCheck$
    BEGIN
       
    END;
$unregCheck$ LANGUAGE plpgsql;

CREATE TRIGGER unregCheck BEFORE DELETE ON Registrations
    FOR EACH ROW EXECUTE PROCEDURE unreg();