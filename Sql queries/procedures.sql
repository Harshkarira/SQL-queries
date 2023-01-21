-- =============================================
-- Author:      Priya Karsi
-- Create date: 12/11/2022
-- Description: Adds/registers users
--
-- Parameters:
--   @firstName - first name
--   @lastName - last name
--   @userName - username 
--   @email - email 
--   @password - hashed password
--   @Mobile - phone number
--   @Bio - bio of user
     
-- Example: EXEC sp_registerUser 'Disha','Ramrakhyani','dish@ramr','disha@gmail.com','password','9999000090','demo bio test'
-- Change History:
--   5/15/17 Jack Brown: Changed calcualtion method( example change)

CREATE PROCEDURE sp_registerUser
@firstName varchar(500),
@lastName varchar(500),
@userName varchar(500),
@mobile varchar(50),
@email varchar(500),
@password nvarchar(max),
@bio nvarchar(max)
AS
BEGIN
    INSERT INTO [dbo].[users]
	([Firstname],[Lastname],[Username],[Mobile],[Email],[Password],[Bio]) 
	VALUES (@firstName,@lastName,@userName,@mobile,@email,@password,@bio)
END

EXEC sp_registerUser 'Disha','Ramrakhyani','dish@ramr','9999000090','disha@gmail.com','password','demo bio test'

-- =============================================
-- Author:      Priya Karsi
-- Create date: 12/11/2022
-- Description: Editing  users
--
-- Parameters:
--   @firstName - first name
--   @lastName - last name
--   @userName - username 
--   @email - email 
--   @password - hashed password
--   @Mobile - phone number
--   @Bio - bio of user
     
-- Example: EXEC sp_registerUser 'Disha','Ramrakhyani','dish@ramr','disha@gmail.com','password','9999000090','demo bio test'
-- Change History:
--   5/15/17 Jack Brown: Changed calcualtion method( example change)
 
CREATE PROCEDURE sp_EditUser
@userID int,
@firstName varchar(500),
@lastName varchar(500),
@userName varchar(500),
@email varchar(500),
@password nvarchar(max),
@mobile varchar(50),
@bio nvarchar(max)
AS
BEGIN
    UPDATE dbo.users SET  [Firstname] = @firstName
                         ,[Lastname] = @lastName
                         ,[username] = @userName
                         ,[Mobile] = @Mobile
                         ,[Email] = @email
                         ,[Password] = @password
                         ,[Bio] = @bio
                         ,[EditedAT] = GETDATE()
     WHERE userID = @UserID 
END
EXEC sp_EditUser 1,'Disha','Ramrakhyani','changeduser','disha@gmail.com','password','9999000090','demo bio test'