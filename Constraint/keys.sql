CREATE INDEX idx_tweets_userId ON tweets(UserId);

CREATE INDEX idx_dataforregression_GeneralFreq ON dataforregression(GeneralFreq);



ALTER TABLE engage_data
ADD CONSTRAINT key1
FOREIGN KEY (User_num)
REFERENCES tweets(UserId);




-- Change the columns and add primary key
ALTER TABLE comments
MODIFY COLUMN tweetId INT NOT NULL,
MODIFY COLUMN commentId INT NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY (commentId, tweetId);

-- Add the new foreign key constraint
ALTER TABLE comments
ADD CONSTRAINT key7 FOREIGN KEY (tweetId) REFERENCES tweets(Id);


ALTER TABLE word_in_tweet
DROP FOREIGN KEY key5;

ALTER TABLE word_in_tweet
ADD CONSTRAINT key5 FOREIGN KEY (tweetId)
REFERENCES tweets(Id);

ALTER TABLE word_in_tweet
ADD CONSTRAINT key6 FOREIGN KEY (wordId)
REFERENCES freq_of_words(wordId);

