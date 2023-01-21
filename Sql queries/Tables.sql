use blog_stack;
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