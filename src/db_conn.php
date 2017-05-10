<?php
//	Developer: Sindhu Balakrishnan
//	Description: PHP page for DB connection. 

    function connect_to_db()
    {
        define("USER", "sinanal");
        define("PASS", "");
        define("DB", "Know_Thyself");
    
        // connect to database
        $connection = new mysqli('localhost', USER, PASS, DB);
    
        if ($connection->connect_error) {
            die('Connect Error (' . $connection->connect_errno . ') '
                . $connection->connect_error);
        }
        
        return $connection;   
    }
?>
    