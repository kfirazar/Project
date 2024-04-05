CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_word_in_tweet`()
BEGIN
    -- Declare variables
    DECLARE done INT DEFAULT FALSE;
    DECLARE word_text VARCHAR(255);
    DECLARE id_ INT;
    DECLARE indexPos INT;
    DECLARE wordId_ INT;

    -- Declare cursor
    DECLARE rowCur CURSOR FOR SELECT word FROM temp_words;

    -- Declare handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SET SQL_SAFE_UPDATES = 0;

    -- Get the last tweetId from the tweets table
    SELECT Id INTO id_ FROM tweets ORDER BY Id DESC LIMIT 1;

    -- Initialize position index
    SET indexPos = 0;

    -- Open cursor
    OPEN rowCur;

    -- Start loop
    read_loop: LOOP
        FETCH rowCur INTO word_text;

        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Get the wordId from freq_of_words
        SELECT wordId INTO wordId_ FROM freq_of_words WHERE Word = word_text;

        -- Check if wordId exists
        IF wordId_ IS NOT NULL THEN
            -- Insert into word_in_tweet table
            INSERT INTO word_in_tweet (tweetId, wordId, pos)
            VALUES (id_, wordId_, indexPos);
        END IF;

        -- Increment position index
        SET indexPos = indexPos + 1;
    END LOOP;

    -- Close cursor
    CLOSE rowCur;
END
