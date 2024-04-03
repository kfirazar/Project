CREATE INDEX idx_tweets_userId ON tweets(UserId);

CREATE INDEX idx_dataforregression_GeneralFreq ON dataforregression(GeneralFreq);


ALTER TABLE freq_of_words
ADD CONSTRAINT key3
FOREIGN KEY (AvgEng)
REFERENCES dataforregression(GeneralFreq);


ALTER TABLE engage_data
ADD CONSTRAINT key1
FOREIGN KEY (User_num)
REFERENCES tweets(UserId);
