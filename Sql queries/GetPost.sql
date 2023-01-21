USE [blog_stack]
GO

/****** Object:  StoredProcedure [blog].[sp_getpost]    Script Date: 23-12-2022 13:05:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

AlTER PROCEDURE [blog].[sp_getpost]
--DECLARE
@slug varchar(100)
AS
BEGIN
   DROP table IF EXISTS #temptable
   SELECT p.postID,STRING_AGG(t.tagName,',') as tags
   INTO #temptable
   FROM blog.posts p
   INNER JOIN blog.post_tag pt
   ON p.PostID=pt.PostID
   INNER JOIN blog.tags t
   ON pt.TagID=t.TagID
   GROUP BY p.PostID

   --SELECT * FROM #temptable
   SELECT 
   p.[postID],
   p.[title],
   p.[authorID],
   p.[categoryID],
   c.[Categoryname],
   p.[ShortDescription],
   p.[description],
   p.[slug],
   p.[publishedAt],
   p.[numberLikes],
   p.[numberComments],
   t.tags
   FROM blog.posts p
   INNER JOIN #temptable t
   ON p.PostID=t.PostID
   INNER JOIN dbo.users users
   ON users.UserID = p.AuthorID
   INNER JOIN blog.categories c
   ON c.CategoryID = p.CategoryID
   WHERE p.ActiveYN=1
   AND p.PublishedAt<GETDATE()
   AND p.Slug=@slug
END
GO


