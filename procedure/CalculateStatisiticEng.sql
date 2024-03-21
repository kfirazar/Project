CREATE DEFINER=`root`@`localhost` PROCEDURE `CalculateStatisticsEng`()
BEGIN
	#	What is 'PureEngage' ?
	#		For each word :
	#			SUM the engagement of the total apperance in each sentence that it is in / the count 	
	#

    -- Declare variables
    DECLARE done INT DEFAULT FALSE;
    DECLARE word_text VARCHAR(255);
    DECLARE realfreq FLOAT;
    Declare countWord int;
    -- Declare cursor
    DECLARE rowCur CURSOR FOR SELECT word FROM temp_words;
    
    -- Declare handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

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
			
		SELECT Word_Count INTO countWord FROM freq_of_words WHERE Word = word_text;

        -- Calculate SUM of engagement for each word
        SELECT SUM(Engagement) / countWord INTO realfreq FROM tweets
        WHERE Tweet LIKE CONCAT('%', word_text, '%');
        
        -- Display or do something with realfreq, like store it somewhere
        SELECT word_text, realfreq; -- For testing purposes, you can display the value
		
        #INSERT IT TO temp_words table 
        
    END LOOP;

    -- Close cursor
    CLOSE rowCur;

END
