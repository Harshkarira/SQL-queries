USE [blog_stack]
GO

/****** Object:  StoredProcedure [dbo].[sp_EditPost]    Script Date: 14-12-2022 10:16:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- EXEC blog.sp_EditPost 6,1,'DEMO TITLE',1,'shorts','longs','slugh',1,'tag1,tag2,tag33'

ALTER PROCEDURE [blog].[sp_EditPost]
	@postID int,
	@authorID int,
	@title varchar(300),
	@categoryID int,
	@shortDescription varchar(1000),
	@description nvarchar(max),
	@slug varchar(100),
	@scheduledYN bit,
	@tags nvarchar(max),
-- @publishedAT varchar(500),
	@numberLikes int = 0,
	@numberComments int = 0

AS
BEGIN
	-- STEP 1 INSERT INTO POST TABLE
    UPDATE [blog].[posts]
	set [AuthorID] = @authorID, 
	[Title] = @title,
	[CategoryId] = @categoryID,
	[ShortDescription] = @shortDescription,
	[Description] = @description,
	[Slug] = @slug,
	[ScheduledYN] = @scheduledYN,
	[Numberlikes] = @numberLikes,
	[Numbercomments] = @numberComments
	WHERE [PostID] = @postID
	
	INSERT INTO blog.tags(TagName)
	SELECT value FROM STRING_SPLIT(@tags,',')
	WHERE NOT EXISTS(
	SELECT * FROM blog.tags WHERE Tagname = value)

	DELETE FROM blog.post_tag
	WHERE PostID = @postID

	INSERT INTO blog.post_tag(PostID, TagID)
	SELECT @postID,TagID 
	FROM blog.tags 
	WHERE Tagname in 
	(SELECT value FROM STRING_SPLIT(@tags,','))

	
	EXEC blog.[sp_fetchPosts]
	
END
GO


