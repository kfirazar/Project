CREATE INDEX idx_tweets_userId ON tweets(UserId);

CREATE INDEX idx_dataforregression_GeneralFreq ON dataforregression(GeneralFreq);



ALTER TABLE engage_data
ADD CONSTRAINT key1
FOREIGN KEY (User_num)
REFERENCES tweets(UserId);



alter table comments
ADD CONSTRAINT key7 FOREIGN KEY (tweetId)
REFERENCES tweets(Id);

ALTER TABLE word_in_tweet
ADD CONSTRAINT key5 FOREIGN KEY (tweetId)
REFERENCES tweets(Id);

ALTER TABLE word_in_tweet
ADD CONSTRAINT key6 FOREIGN KEY (wordId)
REFERENCES freq_of_words(wordId);
