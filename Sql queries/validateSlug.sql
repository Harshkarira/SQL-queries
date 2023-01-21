CREATE PROCEDURE [blog].[sp_validateSlug]
@Slug varchar(50)
AS
BEGIN
	SELECT CASE WHEN
	(NOT EXISTS (SELECT Slug FROM blog.posts
	WHERE Slug=@Slug))
	THEN 1
	ELSE 0
	END AS validSlug
END
GO
EXEC blog.sp_validateSlug 'slughhhh'
--SELECT * FROM blog.posts
--isme ye hora hai ki jo slug user pass kr rha h toh ye check kr rha h ki if the given slug is present then it will return 0 because it will be an invalid slug bcuz ye slug already used h firse use nahi kr skte hai
SELECT * FROM blog.posts

EXEC blog.sp_validateSlug 'slugh'


