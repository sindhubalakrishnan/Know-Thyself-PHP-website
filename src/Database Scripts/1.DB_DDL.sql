/*Created By Ashwini Kulkarni

Project Title: Know Thyself

DDL script

*/

#any user who take or create test will have entry in  UserDetails


create table UserDetails
(
userid INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
email_addr VARCHAR(255) ,
created_date TIMESTAMP
);

/*
any user who create test will have entry in  UserLogin
*/
create table UserLogin
(
userid INT(6) UNSIGNED PRIMARY KEY,
username VARCHAR(30) NOT NULL,
pass_wd VARCHAR(50) NOT NULL,
created_date TIMESTAMP,
modified_date TIMESTAMP,
CONSTRAINT FK_userid FOREIGN KEY (userid) REFERENCES UserDetails(userid)
);


/*
Test Available on portal 
*/
create table Dim_Test
(
testid INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
userid INT(6) UNSIGNED,
testname VARCHAR(255),
created_date TIMESTAMP,
CONSTRAINT FK_userid_dim_test FOREIGN KEY (userid) REFERENCES UserDetails(userid)
);




/*Test details of user who took test*/
create table TestDetails
(
testid INT(6) UNSIGNED,
userid INT(6) UNSIGNED,
test_result VARCHAR(255),
created_date TIMESTAMP,
PRIMARY KEY (testid, userid),
CONSTRAINT FK_testid_test_details FOREIGN KEY (testid) REFERENCES Dim_Test(testid),
CONSTRAINT FK_userid_test_details FOREIGN KEY (userid) REFERENCES UserDetails(userid)
);


/*
Dimension table about questionaries
*/
create table Dim_Question
(
qusid INT(6) UNSIGNED AUTO_INCREMENT,
testid INT(6) UNSIGNED,
qus_desc VARCHAR(255),
qus_type VARCHAR(10),
ans VARCHAR(255),
PRIMARY KEY (qusid,testid),
CONSTRAINT FK_testid_dim_question FOREIGN KEY (testid) REFERENCES Dim_Test(testid)
);

/*
table stores available options of questionaries
*/

create table Dim_Qus_Option
(
qusid INT(6) UNSIGNED,
testid INT(6) UNSIGNED,
tot_col INT(6),
op1 VARCHAR(255),
op2 VARCHAR(255),
op3 VARCHAR(255),
op4 VARCHAR(255),
op5 VARCHAR(255),
PRIMARY KEY (qusid,testid),
CONSTRAINT FK_qusid_dim_answer FOREIGN KEY (qusid) REFERENCES Dim_Question(qusid),
CONSTRAINT FK_testid_dim_answer FOREIGN KEY (testid) REFERENCES Dim_Test(testid)
);


/*
This table specificaly made for mbti test
*/

create table Dim_Personality_Attribute_Type
(
personality_type char(1) PRIMARY KEY,
type_desc VARCHAR(255),
testid INT(6) UNSIGNED,
CONSTRAINT FK_testid_dim_type FOREIGN KEY (testid) REFERENCES Dim_Test(testid)

);

/*
This table specificaly made for mbti test
*/
create table Test_MBTI_Ans
(
testid INT(6) UNSIGNED,
qusid INT(6) UNSIGNED,
type1  CHAR(1),
type2  CHAR(1),
PRIMARY KEY (testid,qusid),
CONSTRAINT FK_testid_test_mbti FOREIGN KEY (testid) REFERENCES Dim_Test(testid),
CONSTRAINT FK_qusid_test_mbti FOREIGN KEY (qusid) REFERENCES Dim_Question(qusid)
);





/*
table stores users ans on qus.
*/
create table Test_User_Ans
(
testid INT(6) UNSIGNED,
userid INT(6) UNSIGNED,
qusid INT(6) UNSIGNED,
ans VARCHAR(255),
created_date TIMESTAMP,
PRIMARY KEY (testid, userid,qusid),
CONSTRAINT FK_userid_test_user_ans FOREIGN KEY (userid) REFERENCES UserDetails(userid),
CONSTRAINT FK_testid_test_user_ans FOREIGN KEY (testid) REFERENCES Dim_Test(testid),
CONSTRAINT FK_qusid_test_user_ans FOREIGN KEY (qusid) REFERENCES Dim_Question(qusid)
);
