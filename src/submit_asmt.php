<?php
//	Developer: Sindhu Balakrishnan
//	Description: PHP file to submit an assessment details.
	
// Updated <19 APR 2017><ashwini> Code block added
/***************************************************************************/

// Updated <19 APR 2017> Setting up session variables
    
    session_start(); // session start
                    
    $newUser= $_SESSION['s_userid'];
    $s_testid = $_SESSION['s_testid'];
    
    require_once('db_conn.php');
    
    function submit_asmt()
    {
            try {
                    $connection = connect_to_db();

                    $original_array = unserialize($_POST['ArrayData']);
                    
                    $newUser = $_SESSION['s_userid'];
                    $_SESSION['s_testid']=$testid;

                    if (is_array($original_array)) 
                    {
                        for ($row = 1; $row < $_POST['sizeOfQSet'] + 1; $row++) 
                        {
                            $testid = $original_array[$row][0];
                            $qusid = $original_array[$row][1];
                            $ans = $_POST['selection_'.$qusid];
                            $newUser = $_SESSION['s_userid'];
                            $s_testid=$testid;
                            $_SESSION['s_testid']=$testid;
                            
                            $insert = sprintf("INSERT INTO Test_User_Ans(testid, userid, qusid, ans, created_date)
                                                VALUES ('".htmlspecialchars($testid,ENT_QUOTES)."','".htmlspecialchars($newUser,ENT_QUOTES)."','".htmlspecialchars($qusid,ENT_QUOTES)."','".htmlspecialchars($ans,ENT_QUOTES)."', now());
                                                    ");
                                                    
                            $ins_sucess = $connection->query($insert) or die(mysqli_error($connection));  
                                
                            if ($ins_sucess === false)
                                die("Assessment details not inserted into database");
                              
                            mysqli_commit($connection);
                        }
                    }
		    
		// Updated <19 APR 2017><ashwini> Making entry in DB which will trigger the calculation in DB  :Start
			   if ($s_testid==1)
                          {
                          $insert_entry =  sprintf("INSERT INTO TestDetails (testid, userid, created_date) VALUES
                                                 ('".htmlspecialchars($testid,ENT_QUOTES)."','".htmlspecialchars($newUser,ENT_QUOTES)."', now());
                                                    ");
                          }
                          else
                          {
                           $insert_entry =  sprintf("INSERT INTO Custom_TestDetails (testid, userid, created_date) VALUES
                                                 ('".htmlspecialchars($testid,ENT_QUOTES)."','".htmlspecialchars($newUser,ENT_QUOTES)."', now());
                                                    ");   
                          }
                            $sucess = $connection->query($insert_entry) or die(mysqli_error($connection)); 
                          
                            if ($sucess === false)
				            die("Assessment details not inserted into database");
                              
                            mysqli_commit($connection);
                            
                            mysqli_close($connection);
	        // Updated <19 APR 2017><ashwini> Making entry in DB which will trigger the calculation   :End    
                
            }
                        
            catch(PDOException $e)
            {
                echo 'Cannot connect to database';
                exit;
            }
                
            if($ins_sucess === true)
            {
                //header("Location: confirmation.php");
                //exit;
                
		  // Updated <19 APR 2017>
	       	    header("Location: result.html"); 
            }
    }
    
?>
