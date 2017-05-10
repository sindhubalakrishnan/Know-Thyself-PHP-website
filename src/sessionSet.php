<?php
//	Developer: Ashwini Kulkarni
//	Description: Selected Test_id from Custon Test need to set in session 

    echo "<h2> Thankyou for taking up the Personality Test! </h2>";//debug Purpose
 
    $testid=$_GET['c_testid']; // geting id from selected click

    if(session_id() == "") 
	{ 
				session_start(); 
				echo "Inside session";
	} 
				else 
	{ 
				//nothing
	}
    $newUser = $_SESSION['s_userid']; // get current user id from session
    
    echo "newUser ".$newUser." testid".$testid;  //debug Purpose
    
	// Block : Start : If user alredy taken test
			require_once('db_conn.php');
			$connection = connect_to_db();
			
			$cnt = sprintf("select IFNULL(count(1),0) cnt from Test_User_Ans WHERE userid='".htmlspecialchars($newUser,ENT_QUOTES)."' and testid='".htmlspecialchars($testid,ENT_QUOTES)."' ;");
															
			$check_sucess = $connection->query($cnt) or die(mysqli_error($connection));
			while ($row =  $check_sucess->fetch_assoc()) 
			{
						// Updated <19 Jul 2017>
						$s_check= $row['cnt'] ;
			}
    // Block : end : If user alredy taken test

	// on basis of value of s_check	
    if ($s_check> 0)
    {
				echo "newUser ".$newUser." testid".$testid;
				echo '<script language="javascript">';
				echo 'alery("You Have Already Taken this test")';  //not showing an alert box.
				echo '</script>';
				header("Location: CustomTest.html");
	}
    else
    {
				echo "newUser ".$newUser." testid".$testid;
				$_SESSION['s_testid']=$testid;
				echo "<br>Test ID=:".$testid;
				header("Location: assessment.html");
    }
?>