USE [blog_stack]
GO

/****** Object:  StoredProcedure [dbo].[sp_addPost]    Script Date: 13-12-2022 10:26:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[sp_addPost]
	@authorID int,
	@title varchar(300),
	@categoryID int,
	@shortDescription varchar(1000),
	@description nvarchar(max),
	@slug varchar(100),
	@scheduledYN bit,
	@tags nvarchar(max),
-- @publishedAT varchar(500),
	@numberLikes int,
	@numberComments int

AS
BEGIN
	-- STEP 1 INSERT INTO POST TABLE
    INSERT INTO [blog].[posts]
	([AuthorID],
	[Title],
	[CategoryId],
	[ShortDescription],
	[Description],
	[Slug],
	[ScheduledYN],
	[Numberlikes],
	[Numbercomments]) 
	VALUES (@authorID,
	@title,
	@categoryID,
	@shortDescription,
	@description,
	@slug,
	@scheduledYN,
	@numberLikes,
	@numberComments)

	-- STEP 2 INSERT INTO TAGS TABLE
	DECLARE @postID int

	SELECT @postID = SCOPE_IDENTITY() --it will give the id of inserted post
	-- print(@postID)
	INSERT INTO blog.tags(TagName)
	SELECT value FROM STRING_SPLIT(@tags,',')
	WHERE NOT EXISTS(SELECT * FROM blog.tags WHERE Tagname = value)

	--SELECT * FROM blog.tags
	--SELECT * FROM blog.posts
	

	-- STEP 3 RELATION OF POST AND TAG TABLE
	INSERT INTO blog.post_tag(PostID, TagID)
	SELECT @postID,TagID 
	FROM blog.tags 
	WHERE Tagname in 
	(SELECT value FROM STRING_SPLIT(@tags,','))

	

	
END
GO
SELECT * FROM blog.posts
SELECT * FROM blog.tags
SELECT * FROM blog.post_tag


