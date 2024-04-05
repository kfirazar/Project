CREATE DEFINER=`root`@`localhost` PROCEDURE `CalCulateFreqWordInSentence`()
BEGIN
	SET SQL_SAFE_UPDATES = 0;

	Select * from temp_words;
	INSERT INTO temp_words (Word, Word_Count, Freq)
	SELECT Word, COUNT(*) AS WordCount, COUNT(*) / (SELECT COUNT(*) FROM temp_words) AS Frequency
	FROM temp_words
	GROUP BY Word;
	
	DELETE 
    from temp_words
    where Word_Count IS NULL;


  
END
