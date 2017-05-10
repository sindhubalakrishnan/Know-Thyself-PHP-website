/*Created By Ashwini Kulkarni

Project Title: Know Thyself

Insert data script
This is test script for 12 qus only

*/

INSERT INTO UserDetails (email_addr,created_date) values ('ash.kulkarni1990@gmail.com',NOW());
INSERT INTO UserLogin (userid,username,pass_wd,created_date,modified_date) values (1,'admin', password('admin'),NOW(),NOW());
INSERT INTO Dim_Test (userid ,testname ,created_date) values (1,'MBTI', NOW());

/*Temperory 12 qus only*/

INSERT INTO Dim_Question ( testid, qus_desc, qus_type) values (1,'At a party do you:','2opt');
INSERT INTO Dim_Question ( testid, qus_desc, qus_type) values (1,'Are you more:','2opt');
INSERT INTO Dim_Question ( testid, qus_desc, qus_type) values (1,'Is it worse to:','2opt');
INSERT INTO Dim_Question ( testid, qus_desc, qus_type) values (1,'Are you more impressed by:','2opt');
INSERT INTO Dim_Question ( testid, qus_desc, qus_type) values (1,'Are more drawn toward the:','2opt');
INSERT INTO Dim_Question ( testid, qus_desc, qus_type) values (1,'Do you prefer to work:','2opt');
INSERT INTO Dim_Question ( testid, qus_desc, qus_type) values (1,'Do you tend to choose:','2opt');
INSERT INTO Dim_Question ( testid, qus_desc, qus_type) values (1,'At parties do you:','2opt');
INSERT INTO Dim_Question ( testid, qus_desc, qus_type) values (1,'Are you more attracted to:','2opt');
INSERT INTO Dim_Question ( testid, qus_desc, qus_type) values (1,'Are you more interested in:','2opt');
INSERT INTO Dim_Question ( testid, qus_desc, qus_type) values (1,'In judging others are you more swayed by:','2opt');
INSERT INTO Dim_Question ( testid, qus_desc, qus_type) values (1,'In approaching others is your inclination to be somewhat:','2opt');

INSERT INTO Dim_Qus_Option ( qusid, testid, tot_col, op1 , op2 ) values (1,1,2,'Interact with many, including strangers','Interact with a few, known to you');
INSERT INTO Dim_Qus_Option ( qusid, testid, tot_col, op1 , op2 ) values (2,1,2,'Realistic than speculative','Speculative than realistic');
INSERT INTO Dim_Qus_Option ( qusid, testid, tot_col, op1 , op2 ) values (3,1,2,'Have your "head in the clouds"','Be "in a rut"');
INSERT INTO Dim_Qus_Option ( qusid, testid, tot_col, op1 , op2 ) values (4,1,2,'Principles','Emotions');
INSERT INTO Dim_Qus_Option ( qusid, testid, tot_col, op1 , op2 ) values (5,1,2,'Convincing','Touching');
INSERT INTO Dim_Qus_Option ( qusid, testid, tot_col, op1 , op2 ) values (6,1,2,'To deadlines','Just "whenever"');
INSERT INTO Dim_Qus_Option ( qusid, testid, tot_col, op1 , op2 ) values (7,1,2,'Rather carefully','Somewhat impulsively');
INSERT INTO Dim_Qus_Option ( qusid, testid, tot_col, op1 , op2 ) values (8,1,2,'Stay late, with increasing energy','Leave early with decreased energy');
INSERT INTO Dim_Qus_Option ( qusid, testid, tot_col, op1 , op2 ) values (9,1,2,'Sensible people','Imaginative people');
INSERT INTO Dim_Qus_Option ( qusid, testid, tot_col, op1 , op2 ) values (10,1,2,'What is actual','What is possible');
INSERT INTO Dim_Qus_Option ( qusid, testid, tot_col, op1 , op2 ) values (11,1,2,'Laws than circumstances','Circumstances than laws');
INSERT INTO Dim_Qus_Option ( qusid, testid, tot_col, op1 , op2 ) values (12,1,2,'Objective','Personal');


