CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertTweet`(IN Username VARCHAR(255), IN Engagement FLOAT, IN input_sentence VARCHAR(255))
BEGIN
	
    DECLARE excel_serial_date INT;
    SET excel_serial_date = DATEDIFF(CURRENT_DATE(), '1900-01-01') + 1;
	
    if (select COUNT(*) from engage_data where User_name = Username) = 1 THEN
		INSERT INTO tweets (UserId, Tweet, DateOfUpload, Engagement)
		VALUES ((SELECT User_num FROM engage_data WHERE User_name = Username), input_sentence, excel_serial_date, Engagement);
	
    
		CALL SplitSentenceToWordsAndCreateView(input_sentence);
	END IF;
END
