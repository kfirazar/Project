CREATE DEFINER=`root`@`localhost` PROCEDURE `Regression2`(IN username VARCHAR(2505))
BEGIN
    DECLARE scope FLOAT;
    DECLARE b FLOAT;
    DECLARE res FLOAT;
    DECLARE x FLOAT;
    DECLARE i INT DEFAULT 1;
    DECLARE done INT DEFAULT FALSE;
    DECLARE tweetText VARCHAR(2505);
    DECLARE sum float;

    -- Declare cursor
    DECLARE rowCur CURSOR FOR SELECT GeneralFreq FROM temp_words;
	
    -- Declare handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Set SQL_SAFE_UPDATES
    SET SQL_SAFE_UPDATES = 0;

    -- Get the latest tweet text
    SET tweetText = (SELECT Tweet FROM tweets ORDER BY ID DESC LIMIT 1);
    
    -- Calculate scope
    SELECT SUM(AvgGeneralFreqDiff * AvgRealFreqDiff) / SUM(AvgGeneralFreqDiff * AvgGeneralFreqDiff) INTO scope
    FROM dataforregression;

    -- Calculate b
    SELECT SUM(AvgGeneralFreqDiff) - SUM(AvgRealFreqDiff) * scope INTO b
    FROM dataforregression;
	
    -- Open cursor
    OPEN rowCur;
	
    SET res = 0;
    -- Start loop
    read_loop: LOOP
        FETCH rowCur INTO x;
        IF done THEN
            LEAVE read_loop;
        END IF;
	
        -- Calculate y_hat for each row and accumulate the result
        IF x IS NULL THEN 
			SET x = 0;
        END IF;
        
        SET res = scope * x + b + res;
        SET i = i + 1;
    END LOOP;
	
    -- Close cursor
    CLOSE rowCur;

    -- Calculate the average y_hat
    SELECT 100 * res / i  INTO sum
    -- In MySQL, the DUAL table is a special one-row, one-column table that is used in certain contexts where a table reference is required, but the actual table being referenced doesn't matter.
    FROM DUAL;
   
    -- Update the prediction of the tweet
    UPDATE tweets 
    SET PureEngage = sum
    WHERE Tweet = tweetText AND PureEngage IS NULL;

    -- Update the history of AVG prediction engagement of the user
    UPDATE engage_data
    SET Avg_Engagement = (
        SELECT COALESCE(AVG(PureEngage), 0)
        FROM tweets 
        WHERE UserId = 14
    )
    WHERE User_name = username;
END
