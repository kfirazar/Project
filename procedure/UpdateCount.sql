#Convert to view the raw data from  freq_of_words
#Recalculate the freq of word 

---------------------------------------------------------
#DROP VIEW updated_avg_view;

CREATE VIEW updated_avg_view AS
SELECT
    word,
    count,
    count /(SELECT SUM(Count) FROM freq_of_words) AS recalculated_avg
FROM
    freq_of_words;

---------------------------------------------------------

#Now the total sum of Count is ~1 (std of -+0.01)

Next step is :
        1. Add the new words from table : (temp_words)
        2. Call the update_avg_view (the function above)
        3.
