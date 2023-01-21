USE [blog_stack]
GO

/****** Object:  StoredProcedure [dbo].[sp_fetchProfile]    Script Date: 20-01-2023 18:37:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[sp_fetchProfile]
@userid int
AS
BEGIN
	SELECT * FROM [dbo].[users]
	WHERE UserID = @userid
END
GO
-- SELECT * FROM [dbo].[users]



