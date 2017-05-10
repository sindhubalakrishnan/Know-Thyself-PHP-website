
CREATE TABLE User_MBTI_Result
(
testid int,
userid int,
E_I DECIMAL(4,3),
S_N DECIMAL(4,3),
T_F DECIMAL(4,3),
J_P DECIMAL(4,3),
E_I_type CHAR(2),
S_N_type CHAR(2),
T_F_type CHAR(2),
J_P_type CHAR(2),
res VARCHAR(300),
E INT,
I INT,
S INT,
N INT,
T INT,
F INT,
J INT,
P INT,

PRIMARY KEY (testid,userid)
);


create table Custom_TestDetails
(
testid INT(6) UNSIGNED,
userid INT(6) UNSIGNED,
test_result VARCHAR(255),
created_date TIMESTAMP,
PRIMARY KEY (testid, userid),
CONSTRAINT FK_testid_cust_test_details FOREIGN KEY (testid) REFERENCES Dim_Test(testid),
CONSTRAINT FK_userid_cust_test_details FOREIGN KEY (userid) REFERENCES UserDetails(userid)
);

DROP TABLE IF EXISTS Dim_Personality_Attribute_Type;

CREATE TABLE IF NOT EXISTS `Dim_Personality_Attribute_Type` (
  `personality_type` char(1) NOT NULL,
  `Opposite` char(1) NOT NULL,
  `type_desc` varchar(255) DEFAULT NULL,
  `testid` int(6) unsigned DEFAULT NULL,
  PRIMARY KEY (`personality_type`),
  KEY `FK_testid_dim_type` (`testid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Dim_Personality_Attribute_Type`
--

INSERT INTO `Dim_Personality_Attribute_Type` (`personality_type`, `Opposite`, `type_desc`, `testid`) VALUES
('E', 'I', 'Extraversion', 1),
('F', 'T', 'Feeling', 1),
('I', 'E', 'Introversion', 1),
('J', 'P', 'Judging', 1),
('N', 'S', 'Intuition', 1),
('P', 'J', 'Perceiving', 1),
('S', 'N', 'Sensing', 1),
('T', 'F', 'Thinking', 1);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Dim_Personality_Attribute_Type`
--
ALTER TABLE `Dim_Personality_Attribute_Type`
  ADD CONSTRAINT `FK_testid_dim_type` FOREIGN KEY (`testid`) REFERENCES `Dim_Test` (`testid`);