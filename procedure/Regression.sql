CREATE DEFINER=`root`@`localhost` PROCEDURE `Regression`()
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE tempGeneralFreq FLOAT;
    DECLARE tempRealFreq FLOAT;
    DECLARE text_word VARCHAR(255);
    DECLARE AvgGeneralFreq FLOAT;
    DECLARE AvgRealFreq FLOAT;




    -- Declare cursor
    DECLARE rowCur CURSOR FOR SELECT Word FROM dataforregression;

    -- Declare handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Set SQL_SAFE_UPDATES
    SET SQL_SAFE_UPDATES = 0;

    -- Calculate average general and real frequencies
    SELECT AVG(GeneralFreq) INTO AvgGeneralFreq FROM dataforregression;
    SELECT AVG(RealFreq) INTO AvgRealFreq FROM dataforregression;

    -- Open cursor
    OPEN rowCur;

    -- Start loop
    read_loop: LOOP
        FETCH rowCur INTO text_word;

        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Retrieve general and real frequencies for the current word
        SELECT GeneralFreq, RealFreq INTO tempGeneralFreq, tempRealFreq FROM dataforregression WHERE Word = text_word;

        -- Update DataForRegression table with calculated differences
        UPDATE DataForRegression
        SET AvgGeneralFreqDiff = AvgGeneralFreq - tempGeneralFreq, AvgRealFreqDiff = AvgRealFreq - tempRealFreq
        WHERE Word = text_word;

    END LOOP;
	################
    -- Regression step 2
	################
    
	
	#################
    -- Close cursor
    CLOSE rowCur;
END
