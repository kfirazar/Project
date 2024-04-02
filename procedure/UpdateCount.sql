CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateCount`()
BEGIN
	#Update the Word_Count in the freq_of_words table 
    #Take the the words from the temp_words table
    #If the word exsist in freq_of_words -->Update the 'Word_Count' + Word_Count of temp_words
    #If NOT exsist INSERT the row 
    
    
     -- Declare variables
    DECLARE done INT DEFAULT FALSE;
    DECLARE word_text VARCHAR(255);
    DECLARE realfreq FLOAT;
    Declare countWord INT;
    Declare newCount INT;
    -- Declare cursor
    DECLARE rowCur CURSOR FOR SELECT word FROM temp_words;
    
    -- Declare handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	SET SQL_SAFE_UPDATES = 0;

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
		
        
        #Get The value the count value of the current word from temp_words 
        Select Word_Count  Into newCount  from temp_words where Word = word_text;

        
		SELECT Word_Count INTO countWord FROM freq_of_words WHERE Word = word_text;
		
        if countWord is Null then 
			#Insert
             INSERT INTO freq_of_words (Word,Word_Count,AvgEng) VALUES (word_text,newCount,0); 
		else
			UPDATE freq_of_words 
            SET Word_Count  = Word_Count +  newCount
            where Word = word_text;
        end if;
        
    END LOOP;

    -- Close cursor
    CLOSE rowCur;
END
