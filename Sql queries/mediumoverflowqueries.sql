-- CREATE DATABASE
-- click on new query
CREATE SCHEMA blog;

CREATE TABLE blog.categories(
    CategoryID int IDENTITY(1,1) primary key,
    Categoryname varchar(500),
    CreatedAT DATETIME DEFAULT GETDATE(),
    EditedAT DATETIME DEFAULT GETDATE(),
    ActiveYN int DEFAULT 1,
)

CREATE TABLE users(
    UserID int IDENTITY(1,1) primary key,
    Firstname varchar(500),
    Lastname varchar(500),
    Username varchar(500) unique,
    Mobile varchar(50),
    Email varchar(500),
    Password nvarchar(max),
    Bio nvarchar(max),
    CreatedAT DATETIME DEFAULT GETDATE(),
    EditedAT DATETIME DEFAULT GETDATE(),
    ActiveYN int DEFAULT 1,
)


CREATE TABLE blog.posts(
    PostID int IDENTITY(1,1) primary key,
    AuthorID int foreign key references dbo.users(UserID),
    Title varchar(300),
    CategoryId int foreign key references blog.categories(CategoryID),
    ShortDescription varchar(1000),
    Description nvarchar(max),
    Slug varchar(100) unique,
    ScheduledYN bit,
    Numberlikes int,
    Numbercomments int,
    PublishedAT DATETIME DEFAULT GETDATE(),
    EditedAT DATETIME DEFAULT GETDATE(),
    ActiveYN int DEFAULT 1,
)

CREATE TABLE blog.tags(
    TagID int IDENTITY(1,1) primary key,
    Tagname varchar(500),
    CreatedAT DATETIME DEFAULT GETDATE(),
    EditedAT DATETIME DEFAULT GETDATE(),
    ActiveYN int DEFAULT 1,
)

CREATE TABLE blog.post_tag(
    ID int IDENTITY(1,1) primary key,
    PostID int foreign key references blog.posts(PostID),
    TagID int foreign key references blog.tags(TagID),
)

CREATE TABLE blog.comments(
    CommentID int IDENTITY(1,1) primary key,
    Comment nvarchar(max),
    Numberlikes int,
    UserID int foreign key references dbo.users(UserID),
    PostID int foreign key references blog.posts(PostID),
    CreatedAT DATETIME DEFAULT GETDATE()
)

CREATE TABLE blog.post_likes(
    ID int IDENTITY(1,1) primary key,
    UserID int foreign key references dbo.users(UserID),
    PostID int foreign key references blog.posts(PostID),
)

CREATE TABLE blog.comment_likes(
    ID int IDENTITY(1,1) primary key,
    UserID int foreign key references dbo.users(UserID),
    CommentID int foreign key references blog.comments(CommentID),
)

CREATE TABLE blog.favourites(
    ID int IDENTITY(1,1) primary key,
    UserID int foreign key references dbo.users(UserID),
    PostID int foreign key references blog.posts(PostID),
)

-- in new query
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
    INSERT INTO [dbo].[users]([Firstname],[Lastname],[Username],[Mobile],[Email],[Password],[Bio],) VALUES (@firstName,@lastName,@userName,@mobile,@email,@password,@bio,)

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


