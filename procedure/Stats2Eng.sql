CREATE DEFINER=`root`@`localhost` PROCEDURE `Stats2Eng`(IN commments INT,IN repost INT,IN likes INT,IN views int ,OUT eng FLOAT)
BEGIN
	SET eng = (commments * 0.4 + repost * 0.5 + likes * 0.1) / views;
END
