CREATE DEFINER=`root`@`localhost` PROCEDURE `GeneralFreqOfWord`()
BEGIN
	
	    DECLARE general_amount INT;
	    SELECT SUM(Word_Count) INTO general_amount  FROM  freq_of_words;

	    --Update the the freq of each word from "freq_of_words" table
	    UPDATE freq_of_words fow SET AvgEng = fow.Word_Count / general_amount;


            --Update the value for the freq inside "temp_words" table
	    UPDATE temp_words fow
	    SET GeneralFreq = (SELECT AvgEng  from freq_of_words a1 where  a1.Word = fow.Word);
						
END
