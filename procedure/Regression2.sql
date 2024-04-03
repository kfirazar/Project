CREATE DEFINER=`root`@`localhost` PROCEDURE `Regression2`()
BEGIN
    #Calcualte the AVG y_hat for each word in the sentence
    
    DECLARE scope FLOAT;
    DECLARE b FLOAT;
    DECLARE y_hat FLOAT;
    DECLARE res FLOAT;
    DECLARE x FLOAT;
    DECLARE i INT DEFAULT 1;
    DECLARE done INT DEFAULT FALSE;
	
    -- Declare cursor
    DECLARE rowCur CURSOR FOR SELECT GeneralFreq FROM temp_words;
	
    -- Declare handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Set SQL_SAFE_UPDATES
    SET SQL_SAFE_UPDATES = 0;

    -- Calculate scope
    SELECT SUM(AvgGeneralFreqDiff * AvgRealFreqDiff) / SUM(AvgGeneralFreqDiff * AvgGeneralFreqDiff) INTO scope
    FROM dataforregression;

    -- Calculate b
    SELECT SUM(AvgGeneralFreqDiff) - SUM(AvgRealFreqDiff) * scope INTO b
    FROM dataforregression;
	select scope ,b;

    -- Open cursor
    OPEN rowCur;
	
    set res = 0;
    -- Start loop
    read_loop: LOOP
        FETCH rowCur INTO x;
		
        IF done THEN
            LEAVE read_loop;
        END IF;
	
        -- Calculate y_hat for each row and accumulate the result
        if x = NULL then 
			SET x = 0;
        END IF;
        
        SET res = scope * x + b + res;
        SET i = i + 1;
    END LOOP;
	
    -- Close cursor
    CLOSE rowCur;

    -- Calculate the average y_hat and output the result
    SELECT 100*res / i  AS "y hat --> The engagement of the word based on frequency to engagement";

END
