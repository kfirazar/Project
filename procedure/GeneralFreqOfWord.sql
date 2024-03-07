CREATE DEFINER=`root`@`localhost` PROCEDURE `GeneralFreqOfWord`()
BEGIN
	SELECT *
	FROM freq_of_words
	WHERE Word IN (SELECT UPPER(Word) FROM temp_words) OR Word IN (SELECT LOWER(Word) FROM temp_words);
	
    
    INSERT INTO temp_words (GeneralFreq)
	SELECT *
	FROM freq_of_words
	WHERE Word IN (SELECT UPPER(Word) FROM temp_words) OR Word IN (SELECT LOWER(Word) FROM temp_words)   ;
	
    
END
