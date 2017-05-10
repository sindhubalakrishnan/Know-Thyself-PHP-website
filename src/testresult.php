<?php
//	Developer: Ashwini Kulkarni
//	Description: Fetch result from DB and Display it in proper format  PHP & JS
    session_start(); // session start
    $s_testid = $_SESSION['s_testid']; // session get
    $s_userid = $_SESSION['s_userid'];
    $s_emailid = $_SESSION['s_emailid'];
    
    require_once('db_conn.php');
 
    $connection = connect_to_db();
    
    if ($s_testid ==1)  // For MBTI
    {
                // prepare SQL
                $sql = sprintf("SELECT testid, userid, E_I, S_N, T_F, J_P, E_I_type, S_N_type, T_F_type, J_P_type, res, E, I, S, N, T, F, J, P FROM User_MBTI_Result WHERE 
                                testid=".htmlspecialchars($s_testid,ENT_QUOTES)." and userid=".htmlspecialchars($s_userid,ENT_QUOTES)."
                                LIMIT 1 ;
                                ");
    }
    else // For Other Tests
    {
                $sql = sprintf("SELECT test_result FROM Custom_Test_Result where userid='".htmlspecialchars($s_userid,ENT_QUOTES)."' and testid= '".htmlspecialchars($s_testid,ENT_QUOTES)."' LIMIT 1;");// Need to update this code
  
    }
                                    
                                    
    // execute query
    $result = $connection->query($sql) or die(mysqli_error());   
    
    echo "<div id='resultMBTI' align='center'>" ;
    if ($s_testid ==1) // For MBTI Graph representation
    {
        $stack = array();
        //echo "Inside MBTI Result";
        echo "<div><h2>MBTI Assessment Result<h2></div>";
        echo "<div style ='background-color:white'><canvas width='800px' height='265px' id='graphs' ></canvas><div><br><br>";
        while($row = $result->fetch_assoc()) {
        array_push($stack, $row["E"],$row["I"],$row["S"],$row["N"],$row["T"],$row["F"],$row["J"],$row["P"]); 
        echo "<div><textarea name='resultMBTI' id='resultMBTI' rows='5' cols='60'  readonly style='border:none; background-color: white; '> Result : ".$row["res"]." </textarea><br /></div>";
        $datapoints =json_encode($stack,JSON_NUMERIC_CHECK);
        }
       
    }
    else  // For Other Tests
    {
        echo "<div><h2>Custom Assessment Result<h2></div>";
        while($row = $result->fetch_assoc()) 
        {
      
			echo "<h3>".$row["test_result"]."</h3>";
        }
    }
    echo "</div>";

?>
<script type="text/javascript" src="jQuery/RGraph.common.core.js"></script>
<script type="text/javascript" src="jQuery/RGraph.bar.js"></script>

<script type="text/javascript">
            
            var dt = JSON.parse('<?= $datapoints; ?>');
            var chart=new RGraph.Bar('graphs',[dt[0],dt[1],dt[2],dt[3],dt[4],dt[5],dt[6],dt[7]]); //these are the values of bar chart that be drawn
            chart.Set('chart.colors',['lightblue']); // color of graph
            chart.Set('chart.title',"Personality"); //title for bar chart
            chart.Set('chart.labels', ["Extrovert", "Introvert", "Sensing", "Intuition","Thinking","Feeling","Judging","Perceiving"]); //these are the labels shown
            chart.Draw();
</script>