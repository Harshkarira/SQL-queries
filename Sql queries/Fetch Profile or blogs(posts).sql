USE [blog_stack]
GO

/****** Object:  StoredProcedure [dbo].[sp_fetchProfile]    Script Date: 13-12-2022 12:17:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_fetchProfile]
AS
BEGIN
	SELECT * 
	FROM dbo.users
	WHERE [UserID] = @userID
	AND [ActiveYN] = 1
END
GO


