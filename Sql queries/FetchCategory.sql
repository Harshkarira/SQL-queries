CREATE PROCEDURE [blog].[sp_fetchcategory]
AS
BEGIN
	SELECT c.CategoryId,c.Categoryname
	FROM blog.categories c
	WHERE ActiveYN=1;
END
GO