CREATE DEFINER=`root`@`localhost` PROCEDURE `EventTitleAnalyze`(IN tweetId INT, IN titleId INT)
BEGIN
    -- Declare variables
    DECLARE word_text2 VARCHAR(255);
    DECLARE done INT DEFAULT FALSE;
    DECLARE res INT DEFAULT 0;
    DECLARE temp INT;
    -- Declare cursor
    DECLARE rowCur CURSOR FOR SELECT Word FROM temp_words;
    
    -- Declare handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Call SplitSentenceToWordsAndCreateView procedure to fill temp_words
    CALL SplitSentenceToWordsAndCreateView((SELECT Tweet FROM tweets WHERE Id = tweetId LIMIT 1));
    
    set temp = 0;
    -- Open cursor
    OPEN rowCur;
    
    -- Start loop
    read_loop: LOOP
        FETCH rowCur INTO word_text2;

        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Count occurrences of current word from temp_words in the specified title
        SELECT COUNT(*)
        INTO temp
        FROM events
        WHERE EventId = titleId AND Title LIKE CONCAT('%', word_text2, '%');
		
        SET res = res + temp;
        
    END LOOP;
	
    -- Close cursor
    CLOSE rowCur;

    if (select count(*) from temp_words) * 0.1 < res AND TIMESTAMPDIFF(DAY, (SELECT DateOfUpload FROM tweets WHERE Id = titleId LIMIT 1), (SELECT EventDate FROM events WHERE EventId = tweetId LIMIT 1)) < 14 THEN
		SELECT "1" as "tweet MAYBE related to the event";
	else 
		SELECT "0" as "tweet PROBABLY not related to event";
    -- Output the total occurrences
    END IF;
END
