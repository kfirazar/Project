CREATE DEFINER=`root`@`localhost` PROCEDURE `SplitSentenceToWordsAndCreateView`(IN input_sentence VARCHAR(255))
BEGIN
    
    DECLARE word_separator VARCHAR(1);
    DECLARE start_pos INT;
    DECLARE end_pos INT;
    DECLARE current_word VARCHAR(255);
    DECLARE tableExists INT;

    SET word_separator = ' ';
    SET start_pos = 1;

	SET SQL_SAFE_UPDATES = 0;


   
   #SELECT 1 INTO tableExists 
	#FROM INFORMATION_SCHEMA.TABLES 
	#WHERE TABLE_SCHEMA = 'project' 
	#AND TABLE_NAME = 'temp_words';


	
	-- Check if the table exists
	SELECT 1 INTO tableExists 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_SCHEMA = 'project' 
	AND TABLE_NAME = 'temp_words';

	IF tableExists = 1 THEN
		-- Table exists, so delete its contents
		DELETE FROM temp_words;
	ELSE
		-- Table doesn't exist, so create it
		CREATE TABLE temp_words (
			Word VARCHAR(255),
			Word_Count INT,
			Freq FLOAT,
			GeneralFreq FLOAT,
            
            RealFreq FLOAT
		);
	END IF;

	

    -- Loop through the input sentence
    WHILE start_pos <= LENGTH(input_sentence) DO
        SET end_pos = LOCATE(word_separator, input_sentence, start_pos);

        IF end_pos = 0 THEN
            SET end_pos = LENGTH(input_sentence) + 1;
        END IF;

        SET current_word = SUBSTRING(input_sentence, start_pos, end_pos - start_pos);

        -- Insert the current word into the temporary table
        INSERT INTO temp_words (Word) VALUES (current_word);

        SET start_pos = end_pos + 1;
    END WHILE;
    
    
END
