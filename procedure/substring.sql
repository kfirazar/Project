CREATE DEFINER=`root`@`localhost` PROCEDURE `SplitSentenceToWordsAndCreateView`(IN input_sentence VARCHAR(255), IN view_name VARCHAR(255))
BEGIN
    DECLARE word_separator VARCHAR(1);
    DECLARE start_pos INT;
    DECLARE end_pos INT;
    DECLARE current_word VARCHAR(255);

    SET word_separator = ' ';
    SET start_pos = 1;
	

    DROP table temp_words;
    

    -- Create a table to store the words
    CREATE TABLE temp_words (Word VARCHAR(255),Count INT,Freq Float);

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

   

    -- Drop the temporary table (optional, depends on your requirements)
   
END
