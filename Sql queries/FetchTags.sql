CREATE PROCEDURE [blog].[sp_matchtags] @searchstring varchar (500)
AS
BEGIN
	SELECT TagID, Tagname
	FROM blog.tags
	WHERE tagName = @searchstring
	or tagName LIKE CONCAT('%',@searchstring,'%')
	AND ActiveYN=1;
END
GO

