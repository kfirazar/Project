CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertComment`(IN commentText varchar(255),IN tweetId INT,IN commentBy VARCHAR(255))
BEGIN
	INSERT comments(tweetId,commentBy,commentText)
    VALUES(tweetId,commentBy,commentText);
    
    
END
