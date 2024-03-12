CREATE DEFINER=`root`@`localhost` PROCEDURE `GeneralFreqOfWord`()
BEGIN
	
	#Run throgh the generalFreq of each word and retrive its freq
        
	UPDATE temp_words
	SET GeneralFreq = (SELECT fow.AvgEng
                  FROM freq_of_words AS fow
                  WHERE temp_words.Word = fow.Word);

    
END
