--department
INSERT INTO department values('Department1', 'dep1');
INSERT INTO department values('Department2', 'dep2');


--studyProgramme
INSERT INTO studyProgramme values('StudyProgramme1', 'study1');
INSERT INTO studyProgramme values('StudyProgramme2', 'study2');
INSERT INTO studyProgramme values('StudyProgramme3', 'study3');
INSERT INTO studyProgramme values('StudyProgramme4', 'study4');


--hostedBy
INSERT INTO hostedBy values('dep1', 'StudyProgramme1');
INSERT INTO hostedBy values('dep1', 'StudyProgramme2');
INSERT INTO hostedBy values('dep2', 'StudyProgramme3');
INSERT INTO hostedBy values('dep2', 'StudyProgramme4');


--branch
INSERT INTO branch values('Branch1', 'StudyProgramme1');
INSERT INTO branch values('Branch2', 'StudyProgramme1');
INSERT INTO branch values('Branch3', 'StudyProgramme2');
INSERT INTO branch values('Branch4', 'StudyProgramme3');
INSERT INTO branch values('Branch5', 'StudyProgramme3');
INSERT INTO branch values('Branch6', 'StudyProgramme4');


--student
INSERT INTO student values('941201-1337', 'loginId1','Student Studentsson1', 'StudyProgramme1',null);
INSERT INTO student values('941202-1337', 'loginId2','Student Studentsson2', 'StudyProgramme1','Branch1');
INSERT INTO student values('941203-1337', 'loginId3','Student Studentsson3', 'StudyProgramme1','Branch2');
INSERT INTO student values('941204-1337', 'loginId4','Student Studentsson4', 'StudyProgramme2','Branch3');
INSERT INTO student values('941205-1337', 'loginId5','Student Studentsson5', 'StudyProgramme3','Branch4');
INSERT INTO student values('941206-1337', 'loginId6','Student Studentsson6', 'StudyProgramme3','Branch5');
INSERT INTO student values('941207-1337', 'loginId7','Student Studentsson7', 'StudyProgramme4','Branch6');
INSERT INTO student values('941208-1337', 'loginId8','Student Studentsson8', 'StudyProgramme1','Branch1');
INSERT INTO student values('941209-1337', 'loginId9','Student Studentsson9', 'StudyProgramme1','Branch2');
INSERT INTO student values('941210-1337', 'loginId10','Student Studentsson10', 'StudyProgramme2','Branch3');
INSERT INTO student values('941211-1337', 'loginId11','Student Studentsson11', 'StudyProgramme3','Branch4');
INSERT INTO student values('941212-1337', 'loginId12','Student Studentsson12', 'StudyProgramme3','Branch5');
INSERT INTO student values('941213-1337', 'loginId13','Student Studentsson13', 'StudyProgramme4','Branch6');



-- classifications
INSERT INTO classification values('Math');
INSERT INTO classification values('Research');
INSERT INTO classification values('Seminar');



--dep1 courses
INSERT INTO course values ('tda357','Databases',15, 'dep1');
INSERT INTO course values ('tda416','DataStructures',15, 'dep1');
INSERT INTO course values ('tmv206','Linear Math',15, 'dep1');
INSERT INTO course values ('try123', 'theoretical data', 15, 'dep1');

INSERT INTO courseClassification values ('tmv206','Math');
INSERT INTO courseClassification values ('try123','Research');
INSERT INTO courseClassification values ('tda357','Seminar');


--dep2 courses
INSERT INTO course values ('mve045','Envar',15, 'dep2');
INSERT INTO course values ('mve055','Matstat',15, 'dep2');
INSERT INTO course values ('tmv200','Discrete Math',15, 'dep2');
INSERT INTO course values ('try234', 'theoretical math', 15, 'dep2');


--courseClassificaiton
INSERT INTO courseClassification values ('mve045','Math');
INSERT INTO courseClassification values ('mve055','Math');
INSERT INTO courseClassification values ('tmv206','Math');
INSERT INTO courseClassification values ('tda357','Seminar');
INSERT INTO courseClassification values ('mve045','Seminar');
INSERT INTO courseClassification values ('mve055','Seminar');
INSERT INTO courseClassification values ('try234','Research');
INSERT INTO courseClassification values ('try123','Research');


--restrictedCourse
INSERT INTO restrictedCourse values ('try234',15);
INSERT INTO restrictedCourse values ('try123',10);


--Prerequisites
INSERT INTO prerequisites values ('try123','tda357');
INSERT INTO prerequisites values ('try234','mve045');


--Applied for

INSERT INTO appliedFor values ('941201-1337','try234', default);
INSERT INTO appliedFor values ('941204-1337','try123', default);



--graded

INSERT INTO graded values ('941201-1337','mve045', 'U');


--04 will pass
INSERT INTO graded values ('941204-1337','mve045', '5');
INSERT INTO graded values ('941204-1337','mve055', '3');
INSERT INTO graded values ('941204-1337','tmv206', '3');
INSERT INTO graded values ('941204-1337','tda357', '3');
INSERT INTO graded values ('941204-1337','try123', '4');
INSERT INTO graded values ('941204-1337','tda416', '4');


--02 will pass
INSERT INTO graded values ('941202-1337','mve045', '5');
INSERT INTO graded values ('941202-1337','tmv206', '5');
INSERT INTO graded values ('941202-1337','tda357', '5');
INSERT INTO graded values ('941202-1337','try234', '5');
INSERT INTO graded values ('941202-1337','mve055', '5');



--isAttending
INSERT INTO isAttending values ('941202-1337','mve055');
INSERT INTO isAttending values ('941203-1337','mve055');
INSERT INTO isAttending values ('941204-1337','mve055');

--programMandatoryCourse

INSERT INTO programmeMandatoryCourse values('StudyProgramme2','tda416');
INSERT INTO programmeMandatoryCourse values('StudyProgramme2','mve055');
INSERT INTO programmeMandatoryCourse values('StudyProgramme1','tda357');
INSERT INTO programmeMandatoryCourse values('StudyProgramme3','tda416');
INSERT INTO programmeMandatoryCourse values('StudyProgramme4','tmv200');

--branchMandatoryCourse
INSERT INTO branchMandatoryCourse values('Branch1', 'StudyProgramme1', 'mve045');
INSERT INTO branchMandatoryCourse values('Branch1', 'StudyProgramme1', 'mve055');
INSERT INTO branchMandatoryCourse values('Branch2', 'StudyProgramme1', 'mve045');
INSERT INTO branchMandatoryCourse values('Branch3', 'StudyProgramme2', 'mve045');
INSERT INTO branchMandatoryCourse values('Branch4', 'StudyProgramme3', 'mve045');
INSERT INTO branchMandatoryCourse values('Branch5', 'StudyProgramme3', 'mve045');
INSERT INTO branchMandatoryCourse values('Branch6', 'StudyProgramme4', 'mve045');

--branchRecommendedCourse


INSERT INTO branchRecommendedCourse values('Branch1', 'StudyProgramme1', 'tmv206');
INSERT INTO branchRecommendedCourse values('Branch1', 'StudyProgramme1', 'tmv200');
INSERT INTO branchRecommendedCourse values('Branch2', 'StudyProgramme1', 'tmv206');
INSERT INTO branchRecommendedCourse values('Branch3', 'StudyProgramme2', 'tmv206');
INSERT INTO branchRecommendedCourse values('Branch4', 'StudyProgramme3', 'tmv206');
INSERT INTO branchRecommendedCourse values('Branch5', 'StudyProgramme3', 'tmv206');
INSERT INTO branchRecommendedCourse values('Branch6', 'StudyProgramme4', 'tmv206');

