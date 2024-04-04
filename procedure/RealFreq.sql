CREATE DEFINER=`root`@`localhost` PROCEDURE `RealFreq`()
BEGIN
    -- Declare variables
    DECLARE done INT DEFAULT FALSE;
    DECLARE word_text VARCHAR(255);
    DECLARE AvgEng2 FLOAT;
    DECLARE realfreq FLOAT;
    DECLARE countWord INT;
    
    -- Declare cursor
    DECLARE rowCur CURSOR FOR SELECT Word FROM freq_of_words;
    
    -- Declare handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Disable safe updates
    SET SQL_SAFE_UPDATES = 0;
	DELETE FROM dataforregression;

    
    -- Open cursor
    OPEN rowCur;

    -- Start loop
    read_loop: LOOP
        FETCH rowCur INTO word_text;
        
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Reset realfreq for each word
        SET realfreq = 0;
        
        -- Retrieve count of word appearances
        SELECT Word_Count , AvgEng INTO countWord , AvgEng2 FROM freq_of_words WHERE Word = word_text;
		
        -- Calculate AVG of engagement for each word
        SELECT SUM(Engagement) / countWord INTO realfreq FROM tweets
        WHERE Tweet LIKE CONCAT('%', word_text, '%');
	
        -- Insert calculated values into DataForRegression table
        INSERT INTO dataforregression (Word, GeneralFreq, RealFreq)
        VALUES (word_text, AvgEng2, realfreq);
        #SELECT AvgEng2 , countWord , word_text, realfreq;
			
    END LOOP;

	
    -- Close cursor
    CLOSE rowCur;
    
END
