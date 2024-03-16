
use Discography
go

if not exists(select * from sys.tables where name='RecordLabel')
begin
	create table RecordLabel(
		IDRecordLabel int CONSTRAINT PK_IDRecordLabel PRIMARY KEY IDENTITY, 
		name nvarchar(50),
		founded int,
		owner nvarchar(50),
	)
end
go

if not exists(select * from sys.tables where name='Artist')
begin
	create table Artist(
	
		IDArtist int CONSTRAINT PK_Artist PRIMARY KEY IDENTITY, 
		name nvarchar(50),
		realName nvarchar(50),
		firstSongReleased int
	)
end
go

if not exists(select * from sys.tables where name='Album')
begin
	create table Album(
		IDAlbum int CONSTRAINT PK_Album PRIMARY KEY IDENTITY, 
		name nvarchar(50),
		genre nvarchar(50),
		NumberOfSongs int,
		RecordLabelID int CONSTRAINT FK_RecordLabel_Album FOREIGN KEY REFERENCES RecordLabel(IDRecordLabel) NOT NULL,
		ArtistID int CONSTRAINT FK_Artist_Album FOREIGN KEY REFERENCES Artist(IDArtist) NOT NULL,
	)
end
go
if not exists(select * from sys.tables where name='User')
begin
	create table Users(
		IDUser int CONSTRAINT PK_USer PRIMARY KEY IDENTITY, 
		username nvarchar(50),
		password nvarchar(50)
	)
end
go

create or alter procedure createArtist
	@name nvarchar(20),
	@realName nvarchar(20),
	@firstSongReleasedIn int,
	@IDArtist int output
as
begin
	insert into Artist(name, realName, firstSongReleased)
	values(@name, @realName, @firstSongReleasedIn)
	
	set @IDArtist = scope_identity()
end
go

create or alter  procedure selectArtist
	@IDArtist int
as
begin
	select * from Artist where IDArtist = @IDArtist
end
go

create  or alter procedure createAlbum
		@name nvarchar(50),
		@genre nvarchar(50),
		@NumberOfSongs int,
		@IDAlbum int output
as
begin
	insert into Album(name, genre, NumberOfSongs)
	values(@name, @genre, @NumberOfSongs)
	
	set @IDAlbum = scope_identity()
end
go

create or alter  procedure selectAlbum
	@IDAlbum int
as
begin
	select * from Album where IDAlbum = @IDAlbum
end


create or alter  procedure createRecordLabel
		@name nvarchar(50),
		@founded int,
		@owner nvarchar(50),
		@IDRecordLabel int output
as
begin
	insert into RecordLabel(name, founded, owner)
	values(@name, @founded, @owner)
	
	set @IDRecordLabel = scope_identity()
end
go

create  or alter procedure selectRecordLabel
	@IDRecordLabel int
as
begin
	select * from RecordLabel where IDRecordLabel = @IDRecordLabel
end


create procedure login
	@username nvarchar(20),
	@password nvarchar(20)
as
begin
	select * from Users
	where	username = @username and 
		password = @password
end

CREATE TABLE Article
(
	IDArticle INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(300),
	Link NVARCHAR(300),
	Description NVARCHAR(900),
	PicturePath NVARCHAR(90),
	PublishedDate NVARCHAR(90)
)
GO


CREATE PROCEDURE createArticle
	@Title NVARCHAR(300),
	@Link NVARCHAR(300),
	@Description NVARCHAR(900),
	@PicturePath NVARCHAR(90),
	@PublishedDate NVARCHAR(90),
	@IDArticle INT OUTPUT
AS 
BEGIN 
	INSERT INTO Article VALUES(@Title, @Link, @Description, @PicturePath, @PublishedDate)
	SET @IDArticle = SCOPE_IDENTITY()
END
GO


CREATE PROCEDURE updateArticle
	@Title NVARCHAR(300),
	@Link NVARCHAR(300),
	@Description NVARCHAR(900),
	@PicturePath NVARCHAR(90),
	@PublishedDate NVARCHAR(90),
	@IDArticle INT
	 
AS 
BEGIN 
	UPDATE Article SET 
		Title = @Title,
		Link = @Link,
		Description = @Description,
		PicturePath = @PicturePath,
		PublishedDate = @PublishedDate		
	WHERE 
		IDArticle = @IDArticle
END
GO


CREATE PROCEDURE deleteArticle
	@IDArticle INT	 
AS 
BEGIN 
	DELETE  
	FROM 
			Article
	WHERE 
		IDArticle = @IDArticle
END
GO

CREATE PROCEDURE selectArticle
	@IDArticle INT
AS 
BEGIN 
	SELECT 
		* 
	FROM 
		Article
	WHERE 
		IDArticle = @IDArticle
END
GO

CREATE PROCEDURE selectArticles
AS 
BEGIN 
	SELECT * FROM Article
END
GO
