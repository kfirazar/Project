CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertTweet`(IN Username VARCHAR(255), IN Engagement FLOAT, IN input_sentence VARCHAR(255))
BEGIN
	
    DECLARE current_date_formatted DATE;
    SET current_date_formatted = CURRENT_DATE();
	
    if (select COUNT(*) from engage_data where User_name = Username) = 1 THEN
		INSERT INTO tweets (UserId, Tweet, DateOfUpload, Engagement)
		VALUES ((SELECT User_num FROM engage_data WHERE User_name = Username), input_sentence, current_date_formatted, Engagement);
	
    
		CALL SplitSentenceToWordsAndCreateView(input_sentence);
	END IF;
END
