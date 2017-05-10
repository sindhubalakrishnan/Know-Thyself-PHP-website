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


 SET @res := (SELECT CONCAT(IF(D.E_I=0.00 ,"",ROUND((D.E_I *100),2)), IF(D.E_I=0.00 ," Neither "," % More "), E.type_desc ,IF(D.E_I=0.00 ," nor "," than "),I.type_desc ,", ",IF(D.S_N=0.00 ,"",ROUND((D.S_N *100),2)),IF(D.S_N=0.00 ," Neither "," % More "), S.type_desc ,IF(D.S_N=0.00 ," nor "," than "),N.type_desc ,', ',  IF(D.T_F=0.00 ,"",ROUND((D.T_F *100),2)), IF(D.T_F=0.00 ," Neither "," % More "), T.type_desc ,IF(D.T_F=0.00 ," nor "," than "),F.type_desc ,', ',IF(D.J_P=0.00 ,"", ROUND((D.J_P *100),2)), IF(D.J_P=0.00 ," Neither "," % More "), J.type_desc ,IF(D.J_P=0.00 ," nor "," than "),P.type_desc) as  RES
 
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