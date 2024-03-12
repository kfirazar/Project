CREATE DEFINER=`root`@`localhost` PROCEDURE `GeneralFreqOfWord`()
BEGIN
	
	#Run throgh the generalFreq of each word and retrive its freq
        
	UPDATE temp_words
	SET GeneralFreq = (SELECT fow.AvgEng
                  FROM freq_of_words AS fow
                  WHERE temp_words.Word = fow.Word);



	#Should be touched:
		-What will happen to first occur word --> no background avgEng history
		-What Will be the formula for dealing with freq in sentence WITH freq/avgEng ( table : freq_of_words);
END
