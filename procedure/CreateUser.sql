CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUser`(IN username VARCHAR(255),IN followers INT)
BEGIN
	
    if (select COUNT(*) from engage_data where User_name = username) = 0 THEN
		INSERT engage_data (Amount_of_followers,Avg_Engagement,User_name)
        VALUES(followers,0,username);
	end if;
END
