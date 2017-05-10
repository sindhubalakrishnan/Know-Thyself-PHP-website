-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2017 at 09:20 PM
-- Server version: 5.5.54-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `Know_Thyself`
--

-- --------------------------------------------------------

--
-- Table structure for table `Custom_TestDetails`
--

CREATE TABLE IF NOT EXISTS `Custom_TestDetails` (
  `testid` int(6) unsigned NOT NULL DEFAULT '0',
  `userid` int(6) unsigned NOT NULL DEFAULT '0',
  `test_result` varchar(255) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`testid`,`userid`),
  KEY `FK_userid_cust_test_details` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



--
-- Triggers `Custom_TestDetails`
--
DROP TRIGGER IF EXISTS `insert_cust_test_ans`;
DELIMITER //
CREATE TRIGGER `insert_cust_test_ans` AFTER INSERT ON `Custom_TestDetails`
 FOR EACH ROW BEGIN
DECLARE Correct_Ans INT;
DECLARE Total_Qus INT;
DECLARE result VARCHAR(255);


DROP TEMPORARY TABLE IF EXISTS data;

	CREATE TEMPORARY TABLE IF NOT EXISTS data AS (SELECT 
	T.testid,
	T.userid,
    T.qusid,
	case when T.ans='1' then M.op1
		 when T.ans='2' then M.op2
		 when T.ans='3' then M.op3
		 when T.ans='4' then M.op4
		 when T.ans='5' then M.op5 end as 'ans'             
	FROM Test_User_Ans T
	INNER JOIN Dim_Qus_Option M ON (T.testid=M.testid and T.qusid=M.qusid )

	where T.testid=NEW.testid
	and T.userid=NEW.userid
	);
	
	
SET @Correct_Ans = (SELECT IFNULL(count(1),0)cnt from Dim_Question T INNER JOIN data D ON ( T.testid=D.testid and T.qusid=D.qusid ) where T.testid=NEW.testid and T.ans=D.ans);


SET @Total_Qus = (SELECT IFNULL(count(1),0)cnt from Dim_Question where testid=NEW.testid);

SET @result = (SELECT CONCAT("Your Assesment Score is:- ",@Correct_Ans," Out of ",@Total_Qus));


INSERT INTO Custom_Test_Result (testid,userid,test_result,created_date) 
values (NEW.testid,NEW.userid,@result,NOW());

END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Custom_Test_Result`
--

CREATE TABLE IF NOT EXISTS `Custom_Test_Result` (
  `testid` int(6) unsigned NOT NULL DEFAULT '0',
  `userid` int(6) unsigned NOT NULL DEFAULT '0',
  `test_result` varchar(255) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`testid`,`userid`),
  KEY `FK_userid_cust_res_details` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



--
-- Table structure for table `Dim_Personality_Attribute_Type`
--

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

-- --------------------------------------------------------

--
-- Table structure for table `Dim_Question`
--

CREATE TABLE IF NOT EXISTS `Dim_Question` (
  `qusid` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `testid` int(6) unsigned NOT NULL DEFAULT '0',
  `qus_desc` varchar(255) DEFAULT NULL,
  `qus_type` varchar(10) DEFAULT NULL,
  `ans` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`qusid`,`testid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=124 ;

--
-- Dumping data for table `Dim_Question`
--

INSERT INTO `Dim_Question` (`qusid`, `testid`, `qus_desc`, `qus_type`, `ans`) VALUES
(1, 1, 'At a party do you:', '2opt', NULL),
(2, 1, 'Are you more:', '2opt', NULL),
(3, 1, 'Is it worse to:', '2opt', NULL),
(4, 1, 'Are you more impressed by:', '2opt', NULL),
(5, 1, 'Are more drawn toward the:', '2opt', NULL),
(6, 1, 'Do you prefer to work:', '2opt', NULL),
(7, 1, 'Do you tend to choose:', '2opt', NULL),
(8, 1, 'At parties do you:', '2opt', NULL),
(9, 1, 'Are you more attracted to:', '2opt', NULL),
(10, 1, 'Are you more interested in:', '2opt', NULL),
(11, 1, 'In judging others are you more swayed by:', '2opt', NULL),
(12, 1, 'In approaching others is your inclination to be somewhat:', '2opt', NULL),
(13, 1, 'Are you more:', '2opt', NULL),
(14, 1, 'Does it bother you more having things:', '2opt', NULL),
(15, 1, 'In your social groups do you:', '2opt', NULL),
(16, 1, 'In doing ordinary things are you more likely to:', '2opt', NULL),
(17, 1, 'Writers should:', '2opt', NULL),
(18, 1, 'Which appeals to you more:', '2opt', NULL),
(19, 1, 'Are you more comfortable in making:', '2opt', NULL),
(20, 1, 'Do you want things:', '2opt', NULL),
(21, 1, 'Would you say you are more:', '2opt', NULL),
(22, 1, 'In phoning do you:', '2opt', NULL),
(23, 1, 'Facts:', '2opt', NULL),
(24, 1, 'Are visionaries:', '2opt', NULL),
(25, 1, 'Are you more often:', '2opt', NULL),
(26, 1, 'Is it worse to be:', '2opt', NULL),
(27, 1, 'Should one usually let events occur:', '2opt', NULL),
(28, 1, 'Do you feel better about:', '2opt', NULL),
(29, 1, 'In company do you:', '2opt', NULL),
(30, 1, 'Common sense is:', '2opt', NULL),
(31, 1, 'Children often do not:', '2opt', NULL),
(32, 1, 'In making decisions do you feel more comfortable with:', '2opt', NULL),
(33, 1, 'Are you more:', '2opt', NULL),
(34, 1, 'Which is more admirable:', '2opt', NULL),
(35, 1, 'Do you put more value on:', '2opt', NULL),
(36, 1, 'Does new and non-routine interaction with others:', '2opt', NULL),
(37, 1, 'Are you more frequently:', '2opt', NULL),
(38, 1, 'Are you more likely to:', '2opt', NULL),
(39, 1, 'Which is more satisfying:', '2opt', NULL),
(40, 1, 'Which rules you more:', '2opt', NULL),
(41, 1, 'Are you more comfortable with work that is:', '2opt', NULL),
(42, 1, 'Do you tend to look for:', '2opt', NULL);


-- --------------------------------------------------------

--
-- Table structure for table `Dim_Qus_Option`
--

CREATE TABLE IF NOT EXISTS `Dim_Qus_Option` (
  `qusid` int(6) unsigned NOT NULL,
  `testid` int(6) unsigned NOT NULL DEFAULT '0',
  `tot_col` int(6) DEFAULT NULL,
  `op1` varchar(255) DEFAULT NULL,
  `op2` varchar(255) DEFAULT NULL,
  `op3` varchar(255) DEFAULT NULL,
  `op4` varchar(255) DEFAULT NULL,
  `op5` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`qusid`,`testid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Dim_Qus_Option`
--

INSERT INTO `Dim_Qus_Option` (`qusid`, `testid`, `tot_col`, `op1`, `op2`, `op3`, `op4`, `op5`) VALUES
(1, 1, 2, 'Interact with many, including strangers', 'Interact with a few, known to you', NULL, NULL, NULL),
(1, 3, 2, 'njfjhkjd', 'dfbhgh', NULL, NULL, NULL),
(2, 1, 2, 'Realistic than speculative', 'Speculative than realistic', NULL, NULL, NULL),
(3, 1, 2, 'Have your "head in the clouds"', 'Be "in a rut"', NULL, NULL, NULL),
(4, 1, 2, 'Principles', 'Emotions', NULL, NULL, NULL),
(5, 1, 2, 'Convincing', 'Touching', NULL, NULL, NULL),
(6, 1, 2, 'To deadlines', 'Just "whenever"', NULL, NULL, NULL),
(7, 1, 2, 'Rather carefully', 'Somewhat impulsively', NULL, NULL, NULL),
(8, 1, 2, 'Stay late, with increasing energy', 'Leave early with decreased energy', NULL, NULL, NULL),
(9, 1, 2, 'Sensible people', 'Imaginative people', NULL, NULL, NULL),
(10, 1, 2, 'What is actual', 'What is possible', NULL, NULL, NULL),
(11, 1, 2, 'Laws than circumstances', 'Circumstances than laws', NULL, NULL, NULL),
(12, 1, 2, 'Objective', 'Personal', NULL, NULL, NULL),
(13, 1, 2, 'Punctual', 'Leisurely', NULL, NULL, NULL),
(14, 1, 2, 'Incomplete', 'Completed', NULL, NULL, NULL),
(15, 1, 2, 'Keep abreast of others happenings', 'Get behind on the news', NULL, NULL, NULL),
(16, 1, 2, 'Do it the usual way', 'Do it your own way', NULL, NULL, NULL),
(17, 1, 2, '"Say what they mean and mean what they say"', 'Express things more by use of analogy ', NULL, NULL, NULL),
(18, 1, 2, 'Consistency of thought', 'Harmonious human relationships', NULL, NULL, NULL),
(19, 1, 2, 'Logical judgments', 'Value judgments', NULL, NULL, NULL),
(20, 1, 2, 'Settled and decided', 'Unsettled and undecided', NULL, NULL, NULL),
(21, 1, 2, 'Serious and determined', 'Easy-going', NULL, NULL, NULL),
(22, 1, 2, 'Rarely question that it will all be said', 'Rehearse what you will say', NULL, NULL, NULL),
(23, 1, 2, '"Speak for themselves"', 'Illustrate principles', NULL, NULL, NULL),
(24, 1, 2, 'Somewhat annoying', 'Rather fascinating', NULL, NULL, NULL),
(25, 1, 2, 'A cool-headed person', 'A warm-hearted person', NULL, NULL, NULL),
(26, 1, 2, 'Unjust', 'Merciless', NULL, NULL, NULL),
(27, 1, 2, 'By careful selection and choice', 'Randomly and by chance', NULL, NULL, NULL),
(28, 1, 2, 'Having purchased', 'Having the option to buy', NULL, NULL, NULL),
(29, 1, 2, 'Initiate conversation', 'Wait to be approached', NULL, NULL, NULL),
(30, 1, 2, 'Rarely questionable', 'Frequently questionable', NULL, NULL, NULL),
(31, 1, 2, 'Make themselves useful enough', 'Exercise their fantasy enough', NULL, NULL, NULL),
(32, 1, 2, 'Standards', 'Feelings', NULL, NULL, NULL),
(33, 1, 2, 'Firm than gentle', 'Gentle than firm', NULL, NULL, NULL),
(34, 1, 2, 'The ability to organize and be methodical', 'The ability to adapt and make do', NULL, NULL, NULL),
(35, 1, 2, 'Infinite', 'Open-minded', NULL, NULL, NULL),
(36, 1, 2, 'Stimulate and energize you', 'Tax your reserves', NULL, NULL, NULL),
(37, 1, 2, 'A practical sort of person', 'A fanciful sort of person', NULL, NULL, NULL),
(38, 1, 2, 'See how others are useful', 'See how others see', NULL, NULL, NULL),
(39, 1, 2, 'To discuss an issue thoroughly', 'To arrive at agreement on an issue', NULL, NULL, NULL),
(40, 1, 2, 'Your head', 'Your heart', NULL, NULL, NULL),
(41, 1, 2, 'Contracted', 'Done on a casual basis', NULL, NULL, NULL),
(42, 1, 2, 'The orderly', 'Whatever turns up', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Dim_Test`
--

CREATE TABLE IF NOT EXISTS `Dim_Test` (
  `testid` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(6) unsigned DEFAULT NULL,
  `testname` varchar(255) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`testid`),
  KEY `FK_userid_dim_test` (`userid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=74 ;

--
-- Dumping data for table `Dim_Test`
--

INSERT INTO `Dim_Test` (`testid`, `userid`, `testname`, `created_date`) VALUES
(1, 1, 'MBTI', '2017-04-12 20:05:45');

-- --------------------------------------------------------

--
-- Table structure for table `test2`
--

CREATE TABLE IF NOT EXISTS `test2` (
  `E_I` decimal(4,3) DEFAULT NULL,
  `S_N` decimal(4,3) DEFAULT NULL,
  `T_F` decimal(4,3) DEFAULT NULL,
  `J_P` decimal(4,3) DEFAULT NULL,
  `E_I_type` char(2) DEFAULT NULL,
  `S_N_type` char(2) DEFAULT NULL,
  `T_F_type` char(2) DEFAULT NULL,
  `J_P_type` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `TestDetails`
--

CREATE TABLE IF NOT EXISTS `TestDetails` (
  `testid` int(6) unsigned NOT NULL DEFAULT '0',
  `userid` int(6) unsigned NOT NULL DEFAULT '0',
  `test_result` varchar(255) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`testid`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `TestDetails`
--
DROP TRIGGER IF EXISTS `Insert_testDetails`;
DELIMITER //
CREATE TRIGGER `Insert_testDetails` AFTER INSERT ON `TestDetails`
 FOR EACH ROW BEGIN

	
	DECLARE res VARCHAR(100);
	DECLARE userid INT;
	DECLARE testid INT;
	DECLARE E INT;
	DECLARE I INT;
	
	DECLARE S INT DEFAULT 0;
	DECLARE N INT;
	
	DECLARE T INT;
	DECLARE F INT;
	
	DECLARE J INT  DEFAULT 0;
	DECLARE P INT  DEFAULT 0;
    
	SET res= '';


DROP TEMPORARY TABLE IF EXISTS data;
DROP TEMPORARY TABLE IF EXISTS data2;
	CREATE TEMPORARY TABLE IF NOT EXISTS data AS (SELECT 
	T.testid,
	T.userid,
	case when T.ans=1 then M.type1
		 when T.ans=2 then M.type2 end as 'ans',
	count(*) as 'attribute_count'               
	FROM Test_User_Ans T
	INNER JOIN Test_MBTI_Ans M ON (T.testid=M.testid and T.qusid=M.qusid )

	where T.testid=NEW.testid
	and T.userid=NEW.userid
	group by 1,2,3 );
   

    SET @E = (select IFNULL(attribute_count,0) from data where ans='E');
	SET @I= (select IFNULL(attribute_count,0) from data where ans='I');
	
	SET @S= (select COALESCE(attribute_count,0) from data where ans='S');
	SET @N= (select IFNULL(attribute_count,0) from data where ans='N');
	SET @T= (select IFNULL(attribute_count,0) from data where ans='T');
	SET @F= (select IFNULL(attribute_count,0) from data where ans='F');
	SET @J= (select IFNULL(attribute_count,0) from data where ans='J');
	SET @P= (select IFNULL(attribute_count,0) from data where ans='P');
	

    CREATE TEMPORARY TABLE IF NOT EXISTS data2 AS(
    select  
    case when @E> @I then (SELECT CAST((@E-@I) AS DECIMAL(4,3) )/6) 
         when @E< @I then (SELECT CAST((@I-@E) AS DECIMAL(4,3) )/6)
         when @E = 6 then 1.00
         when @I = 6 then 1.00
         else 0.00  end E_I,
    case when @S> @N then (SELECT CAST((@S-@N) AS DECIMAL(4,3) )/12) 
         when @S< @N then (SELECT CAST((@N-@S) AS DECIMAL(4,3) )/12)
         when @S = 12 then 1.00
         when @N = 12 then 1.00
         else 0.00  end S_N,
    case when @T> @F then (SELECT CAST((@T-@F) AS DECIMAL(4,3) )/12) 
         when @T< @F then (SELECT CAST((@F-@T) AS DECIMAL(4,3) )/12)
         when @T = 12 then 1.00
         when @F = 12 then 1.00
         else 0.00  end T_F,
    case when @J> @P then (SELECT CAST((@J-@P) AS DECIMAL(4,3) )/12) 
         when @J< @P then (SELECT CAST((@P-@J) AS DECIMAL(4,3) )/12)
         when @J = 12 then 1.00
         when @p = 12 then 1.00
         else 0.00  end J_P,
        
    case when @E> @I then 'E'
         when @E< @I then 'I'
         when @E = 6 then 'E'
         when @I = 6 then 'I'
         else 'E'  end E_I_type,
    case when @S> @N then 'S' 
         when @S< @N then 'N'
         when @S = 12 then 'S'
         when @N = 12 then 'N'
         else 'S'  end S_N_type,
    case when @T> @F then 'T'
         when @T< @F then 'F'
         when @T = 12 then 'T'
         when @F = 12 then 'F'
         else 'T'  end T_F_type,
    case when @J> @P then 'J'
         when @J< @P then 'P'
         when @J = 12 then 'J'
         when @p = 12 then 'P'
         else 'J'  end J_P_type    
        
     );
	SET @userid=NEW.userid;
	SET @testid=NEW.testid;


 SET @res := (SELECT CONCAT("[",D.E_I_type,D.S_N_type,D.T_F_type,D.J_P_type,"]   ",IF(D.E_I=0.00 ,"",ROUND((D.E_I *100),2)), IF(D.E_I=0.00 ," Neither "," % More "), E.type_desc ,IF(D.E_I=0.00 ," nor "," than "),I.type_desc ,", ",IF(D.S_N=0.00 ,"",ROUND((D.S_N *100),2)),IF(D.S_N=0.00 ," Neither "," % More "), S.type_desc ,IF(D.S_N=0.00 ," nor "," than "),N.type_desc ,', ',  IF(D.T_F=0.00 ,"",ROUND((D.T_F *100),2)), IF(D.T_F=0.00 ," Neither "," % More "), T.type_desc ,IF(D.T_F=0.00 ," nor "," than "),F.type_desc ,', ',IF(D.J_P=0.00 ,"", ROUND((D.J_P *100),2)), IF(D.J_P=0.00 ," Neither "," % More "), J.type_desc ,IF(D.J_P=0.00 ," nor "," than "),P.type_desc) as  RES
 
           FROM data2 D
			INNER JOIN Dim_Personality_Attribute_Type E ON D.E_I_type=E.personality_type  
			INNER JOIN Dim_Personality_Attribute_Type I ON E.Opposite = I.personality_type
            INNER JOIN Dim_Personality_Attribute_Type S On D.S_N_type=S.personality_type
			INNER JOIN Dim_Personality_Attribute_Type N ON S.Opposite = N.personality_type
			INNER JOIN Dim_Personality_Attribute_Type T On D.T_F_type=T.personality_type 
			INNER JOIN Dim_Personality_Attribute_Type F ON T.Opposite = F.personality_type
			LEFT JOIN Dim_Personality_Attribute_Type J On D.J_P_type=J.personality_type  
			LEFT JOIN Dim_Personality_Attribute_Type P ON J.Opposite = P.personality_type);
  

	INSERT INTO User_MBTI_Result (testid,userid,E_I,S_N,T_F,J_P,E_I_type,S_N_type,T_F_type,J_P_type,res, E,I,S,N,T,F,J,P)
	(
    SELECT    
    
       @testid,@userid,E_I,S_N,T_F,J_P,E_I_type,S_N_type,T_F_type,J_P_type,@res,@E,@I,@S,@N,@T,@F,@J,@P
        
     FROM data2   
    
    );


 	
	
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Test_MBTI_Ans`
--

CREATE TABLE IF NOT EXISTS `Test_MBTI_Ans` (
  `testid` int(6) unsigned NOT NULL DEFAULT '0',
  `qusid` int(6) unsigned NOT NULL DEFAULT '0',
  `type1` char(1) DEFAULT NULL,
  `type2` char(1) DEFAULT NULL,
  PRIMARY KEY (`testid`,`qusid`),
  KEY `FK_qusid_test_mbti` (`qusid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Test_MBTI_Ans`
--

INSERT INTO `Test_MBTI_Ans` (`testid`, `qusid`, `type1`, `type2`) VALUES
(1, 1, 'E', 'I'),
(1, 2, 'S', 'N'),
(1, 3, 'S', 'N'),
(1, 4, 'T', 'F'),
(1, 5, 'T', 'F'),
(1, 6, 'J', 'P'),
(1, 7, 'J', 'P'),
(1, 8, 'E', 'I'),
(1, 9, 'S', 'N'),
(1, 10, 'S', 'N'),
(1, 11, 'T', 'F'),
(1, 12, 'T', 'F'),
(1, 13, 'J', 'P'),
(1, 14, 'J', 'P'),
(1, 15, 'E', 'I'),
(1, 16, 'S', 'N'),
(1, 17, 'S', 'N'),
(1, 18, 'T', 'F'),
(1, 19, 'T', 'F'),
(1, 20, 'J', 'P'),
(1, 21, 'J', 'P'),
(1, 22, 'E', 'I'),
(1, 23, 'S', 'N'),
(1, 24, 'S', 'N'),
(1, 25, 'T', 'F'),
(1, 26, 'T', 'F'),
(1, 27, 'J', 'P'),
(1, 28, 'J', 'P'),
(1, 29, 'E', 'I'),
(1, 30, 'S', 'N'),
(1, 31, 'S', 'N'),
(1, 32, 'T', 'F'),
(1, 33, 'T', 'F'),
(1, 34, 'J', 'P'),
(1, 35, 'J', 'P'),
(1, 36, 'E', 'I'),
(1, 37, 'S', 'N'),
(1, 38, 'S', 'N'),
(1, 39, 'T', 'F'),
(1, 40, 'T', 'F'),
(1, 41, 'J', 'P'),
(1, 42, 'J', 'P');

-- --------------------------------------------------------

--
-- Table structure for table `Test_User_Ans`
--

CREATE TABLE IF NOT EXISTS `Test_User_Ans` (
  `testid` int(6) unsigned NOT NULL DEFAULT '0',
  `userid` int(6) unsigned NOT NULL DEFAULT '0',
  `qusid` int(6) unsigned NOT NULL DEFAULT '0',
  `ans` varchar(255) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`testid`,`userid`,`qusid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `UserDetails`
--

CREATE TABLE IF NOT EXISTS `UserDetails` (
  `userid` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `email_addr` varchar(255) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=288 ;

--
-- Dumping data for table `UserDetails`
--

INSERT INTO `UserDetails` (`userid`, `email_addr`, `created_date`) VALUES
(1, 'ash1123@gmail.com', '2017-04-26 01:13:56');

--
-- Table structure for table `UserLogin`
--

CREATE TABLE IF NOT EXISTS `UserLogin` (
  `userid` int(6) unsigned NOT NULL,
  `username` varchar(30) NOT NULL,
  `pass_wd` varchar(50) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `UserLogin`
--

INSERT INTO `UserLogin` (`userid`, `username`, `pass_wd`, `created_date`, `modified_date`) VALUES
(1, 'admin', '*4ACFE3202A5FF5CF467898FC58AAB1D615029441', '2017-04-12 20:05:45', '2017-04-12 20:05:45');

-- --------------------------------------------------------

--
-- Table structure for table `User_MBTI_Result`
--

CREATE TABLE IF NOT EXISTS `User_MBTI_Result` (
  `testid` int(11) NOT NULL DEFAULT '0',
  `userid` int(11) NOT NULL DEFAULT '0',
  `E_I` decimal(4,3) DEFAULT NULL,
  `S_N` decimal(4,3) DEFAULT NULL,
  `T_F` decimal(4,3) DEFAULT NULL,
  `J_P` decimal(4,3) DEFAULT NULL,
  `E_I_type` char(2) DEFAULT NULL,
  `S_N_type` char(2) DEFAULT NULL,
  `T_F_type` char(2) DEFAULT NULL,
  `J_P_type` char(2) DEFAULT NULL,
  `res` varchar(300) NOT NULL,
  `E` int(11) NOT NULL,
  `I` int(11) NOT NULL,
  `S` int(11) NOT NULL,
  `N` int(11) NOT NULL,
  `T` int(11) NOT NULL,
  `F` int(11) NOT NULL,
  `J` int(11) NOT NULL,
  `P` int(11) NOT NULL,
  PRIMARY KEY (`testid`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Constraints for table `Custom_TestDetails`
--
ALTER TABLE `Custom_TestDetails`
  ADD CONSTRAINT `FK_testid_cust_test_details` FOREIGN KEY (`testid`) REFERENCES `Dim_Test` (`testid`),
  ADD CONSTRAINT `FK_userid_cust_test_details` FOREIGN KEY (`userid`) REFERENCES `UserDetails` (`userid`);

--
-- Constraints for table `Custom_Test_Result`
--
ALTER TABLE `Custom_Test_Result`
  ADD CONSTRAINT `FK_testid_cust_res_details` FOREIGN KEY (`testid`) REFERENCES `Dim_Test` (`testid`),
  ADD CONSTRAINT `FK_userid_cust_res_details` FOREIGN KEY (`userid`) REFERENCES `UserDetails` (`userid`);

--
-- Constraints for table `Dim_Personality_Attribute_Type`
--
ALTER TABLE `Dim_Personality_Attribute_Type`
  ADD CONSTRAINT `FK_testid_dim_type` FOREIGN KEY (`testid`) REFERENCES `Dim_Test` (`testid`);

--
-- Constraints for table `Dim_Test`
--
ALTER TABLE `Dim_Test`
  ADD CONSTRAINT `FK_userid_dim_test` FOREIGN KEY (`userid`) REFERENCES `UserDetails` (`userid`);

--
-- Constraints for table `Test_MBTI_Ans`
--
ALTER TABLE `Test_MBTI_Ans`
  ADD CONSTRAINT `FK_qusid_test_mbti` FOREIGN KEY (`qusid`) REFERENCES `Dim_Question` (`qusid`),
  ADD CONSTRAINT `FK_testid_test_mbti` FOREIGN KEY (`testid`) REFERENCES `Dim_Test` (`testid`);

--
-- Constraints for table `UserLogin`
--
ALTER TABLE `UserLogin`
  ADD CONSTRAINT `FK_userid` FOREIGN KEY (`userid`) REFERENCES `UserDetails` (`userid`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
