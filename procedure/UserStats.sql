CREATE DEFINER=`root`@`localhost` PROCEDURE `UserStats`(In userId_ INT)
BEGIN
	#Display all sentence by UserId
    Select Tweet from tweets where UserId = userId_;
	
	
	select concat( "The most engagement user is " ,( SELECT User_name FROM engage_data order by Avg_Engagement desc limit 1));
    
	SELECT CONCAT("[WORD]: ",Word," [WordId]: ",wordId," [AvgEng]: ",AvgEng) AS "Top 50 most engaged words"
	FROM freq_of_words
	ORDER BY AvgEng DESC
	LIMIT 50;

    select Tweet as " User Tweets " from tweets where UserId = userId_;
   
    
    
    
END
