<?php
//	Developer: Sindhu Balakrishnan
//	Description: PHP index file for MBTI application 
    
    session_start();
    
    $s_testid = $_SESSION['s_testid'];
    
    require_once('db_conn.php');
    require_once('show_ques.php');
    require_once('submit_asmt.php');

    $s_userid = $_SESSION['s_userid'];
    
    $connection = connect_to_db();

    $sql = sprintf("SELECT max(userid) FROM UserDetails;");// Need to update this code

    $result = $connection->query($sql) or die(mysqli_error()); 
    $currentUser = mysqli_fetch_row($result);
    $newUser = $currentUser[0]+1;
    
    if(!isset($_SESSION['s_testid']))
    {
        $_SESSION['s_testid']=1 ;
    }
    
    //Checking for existence of user id in session value.
    if(!isset($_SESSION['s_userid']))
    {
        $_SESSION['s_userid']=$newUser ;
        $insert_usr = sprintf("INSERT INTO UserDetails (userid,created_date) VALUES ('".htmlspecialchars($newUser,ENT_QUOTES)."',NOW());
                                            ");
        $sucess = $connection->query($insert_usr) or die(mysqli_error($connection)); 
    
    }
   
   
    mysqli_autocommit($connection,FALSE);
		    
	    // Updated <19 APR 2017> Setting up session variables 
    if (empty($s_testid)) {
            $s_testid=1;
            $_SESSION['s_testid']=$s_testid;
        }
    
     try {
        $connection = connect_to_db();

	     //updated <19 APR 2017 >    added condition DT.testname='MBTI'   
        $sql = sprintf("SELECT DQ.qusid, DT.Testid, DQ.qus_desc, OPT.op1, OPT.op2, OPT.op3, OPT.op4, OPT.op5
                            From Dim_Question DQ
                            INNER JOIN  Dim_Test DT ON DQ.testid= DT.testid
                            INNER JOIN Dim_Qus_Option OPT ON (DQ.testid=OPT.testid and DQ.qusid=OPT.qusid)
			    WHERE DT.testid= '".$s_testid."'
                            ORDER BY DQ.qusid;
                            ");
        
        show_ques($sql, $connection);
        
        mysqli_close($connection);
    
        }
        
    catch(PDOException $e)
        {
            echo 'Cannot connect to database';
            exit;
        }
?>


     
