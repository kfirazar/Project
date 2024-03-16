-- Setting up the query for new coming sentence 


CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertTweet`(In UserId INT, IN BackgroundData FLOAT ,IN input_sentence VARCHAR(255))
BEGIN
	#Calculate the time between 1900 to today
	DECLARE excel_serial_date INT;
     SET excel_serial_date = DATEDIFF(CURRENT_DATE(), '1900-01-01') + 1;

	Insert into tweets (UserId,Tweet,DateOfUpload,BackgroundData)
    VALUES(UserId,input_sentence,excel_serial_date,BackgroundData);

	call SplitSentenceToWordsAndCreateView(input_sentence);
    
END
