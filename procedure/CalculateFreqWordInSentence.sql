CREATE DEFINER=`root`@`localhost` PROCEDURE `CalCulateFreqWordInSentence`()
BEGIN
	Select * from temp_words;
	INSERT INTO temp_words (Word, Count, Freq)
	SELECT Word, COUNT(*) AS WordCount, COUNT(*) / (SELECT COUNT(*) FROM temp_words) AS Frequency
	FROM temp_words
	GROUP BY Word;
	
	DELETE 
    	from temp_words
    	where Count IS NULL;

END
CalCulateFreqWordInSentence
