CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_word_in_tweet`()
BEGIN
	
    -- Declare variables
    DECLARE done INT DEFAULT FALSE;
    DECLARE word_text VARCHAR(255);
	Declare id_ INT;
    DECLARE indexPos INT;
    -- Declare cursor
    DECLARE rowCur CURSOR FOR SELECT word FROM temp_words;
    
    -- Declare handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	SET SQL_SAFE_UPDATES = 0;
    SET indexPos = 0;
	select Id into id_ from tweets order by Id desc limit 1;
		
    -- Open cursor
    OPEN rowCur;
	
    -- Start loop
    read_loop: LOOP
        FETCH rowCur INTO word_text;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
		
         -- Insert into word_in_tweet table
        INSERT INTO word_in_tweet (tweetId, wordId, pos)
        SELECT id_, IFNULL((SELECT wordId FROM freq_of_words WHERE Word = word_text), -1), indexPos;
		
        SET indexPos = indexPos + 1; -- Increment position index
		
    END LOOP;

    -- Close cursor
    CLOSE rowCur;

END
