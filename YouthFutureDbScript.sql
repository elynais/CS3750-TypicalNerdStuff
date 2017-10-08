Use master;
-- drop YouthShelterCMS database if it exists
IF EXISTS (SELECT * FROM sys.sysdatabases WHERE NAME = 'YouthFutureDb')
	DROP DATABASE YouthFutureDb;

CREATE DATABASE [YouthFutureDb]
ON Primary
(NAME = N'YouthFutureDb', FILENAME = 
N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\YouthFutureDb.mdf',
SIZE = 5120KB, FILEGROWTH = 1024KB)
LOG ON
(NAME = N'YouthFutureCMSLog', FILENAME = 
N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\\YouthFutureDb.ldf',
SIZE = 2048KB, FILEGROWTH = 10%);
GO

--ATTACH TO A NEW DATABASE
Use YouthFutureDb;

-------------------- DROP ALL TABLE IF THEY EXIST -----------------------
IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'User')
	DROP TABLE [User];

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'ErrorLog')
	DROP TABLE ErrorLog;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'Donor')
	DROP TABLE Donor;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'Event')
	DROP TABLE Event;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'Content')
	DROP TABLE Content;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'Image')
	DROP TABLE Image;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'Staff')
	DROP TABLE Staff;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'File')
	DROP TABLE [File];

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'Column')
	DROP TABLE [Column];

GO

-------------------- CREATE TABLES -----------------------
CREATE TABLE [User]
(
	User_id INT IDENTITY(1,1) NOT NULL,
	Username NVARCHAR(20) NOT NULL,
	Password NVARCHAR(25) NOT NULL,
	Staff_id INT NOT NULL
);

CREATE TABLE Staff
(
	Staff_id INT IDENTITY(1,1) NOT NULL,
	StaffFirstName NVARCHAR(40) NOT NULL,
	StaffLastName NVARCHAR(40) NOT NULL,
	StaffEmail NVARCHAR(40) NOT NULL,
	StaffTitle NVARCHAR(40) NOT NULL,
	BoardTitle NVARCHAR(40) NULL,
	Image_id INT NOT NULL,
	StaffStatus VARCHAR(1) NOT NULL
);

CREATE TABLE Image
(
	Image_id INT IDENTITY(1,1) NOT NULL,
	ImagePath NVARCHAR(450) NOT NULL
);

CREATE TABLE Content
(
	Content_id INT IDENTITY(1,1) NOT NULL,
	Image_id INT NULL,
	ContentName NVARCHAR(30) NULL, 
	ContentInfo NVARCHAR(MAX) NULL,
	File_id INT NULL,  -- WHEN THIS IS NOT NULL, CONTENT IS STORED IN A FILE
	PageNum INT NOT NULL
);

CREATE TABLE [File]
(
	File_id INT NOT NULL,
	FilePath VARCHAR(450) NOT NULL
);

CREATE TABLE Donor
(
	Donor_id INT IDENTITY(1,1) NOT NULL,
	DonorName NVARCHAR(50) NOT NULL,
	DonorYear VARCHAR(40) NOT NULL,
	DonorLevel VARCHAR(1) NOT NULL,
	DonorStatus VARCHAR(1) NOT NULL,

);

CREATE TABLE Event
(
	Event_id INT IDENTITY(1,1) NOT NULL,
	EventName NVARCHAR(50) NOT NULL,
	EventDate DATE NOT NULL,
	EventDesc NVARCHAR(100) NOT NULL,
	EventLocation NVARCHAR(80) NOT NULL
);

CREATE TABLE ErrorLog
(
	ErrorLog_id INT IDENTITY(1,1) NOT NULL,
	ErrorDesc NVARCHAR(MAX) NOT NULL,
	ErrorDatetime DATETIME NOT NULL,
	User_id INT NOT NULL

);

CREATE TABLE [Column]
(
	Column_id INT IDENTITY(1,1) NOT NULL,
	ColumnHeader NVARCHAR(400) NOT NULL,
	ColumnLinkDesc NVARCHAR(MAX) NOT NULL,
	ColumnLink NVARCHAR(200) NOT NULL,
	Image_id INT NOT NULL,
	SectionNumber INT NOT NULL
);

-------------------- SET PRIMARY KEYS -----------------------
ALTER TABLE [User]
ADD CONSTRAINT PK_User PRIMARY KEY CLUSTERED (User_id)

ALTER TABLE Staff
ADD CONSTRAINT PK_Staff PRIMARY KEY CLUSTERED (Staff_id)

ALTER TABLE Image
ADD CONSTRAINT PK_Image PRIMARY KEY CLUSTERED (Image_id)

ALTER TABLE Content
ADD CONSTRAINT PK_Content PRIMARY KEY CLUSTERED (Content_id)

ALTER TABLE [File]
ADD CONSTRAINT PK_File PRIMARY KEY CLUSTERED (File_id)

ALTER TABLE Donor
ADD CONSTRAINT PK_Donor PRIMARY KEY CLUSTERED (Donor_id)

ALTER TABLE Event
ADD CONSTRAINT PK_Event PRIMARY KEY CLUSTERED (Event_id)

ALTER TABLE ErrorLog
ADD CONSTRAINT PK_ErrorLog PRIMARY KEY CLUSTERED (ErrorLog_id)

ALTER TABLE [Column]
ADD CONSTRAINT PK_Column PRIMARY KEY CLUSTERED (Column_id)

-------------------- SET FOREIGN KEYS ---------------------------
ALTER TABLE ErrorLog
ADD CONSTRAINT FK_ErrorLog_User
FOREIGN KEY (User_id)
REFERENCES [User] (User_id)

ALTER TABLE [User]
ADD CONSTRAINT FK_User_Staff
FOREIGN KEY (Staff_id)
REFERENCES Staff (Staff_id)

ALTER TABLE Staff
ADD CONSTRAINT FK_Staff_Image
FOREIGN KEY (Image_id)
REFERENCES Image (Image_id)

ALTER TABLE Content
ADD CONSTRAINT FK_Content_Image
FOREIGN KEY (Image_id)
REFERENCES Image (Image_id)

ALTER TABLE Content
ADD CONSTRAINT FK_Content_File
FOREIGN KEY (File_id)
REFERENCES [File] (File_id)

ALTER TABLE [Column]
ADD CONSTRAINT FK_Column_Image
FOREIGN KEY (Image_id)
REFERENCES Image (Image_id)

------------------ SET ALTERNATIVE KEY TO UNIQUE ------------------
ALTER TABLE [User]
ADD CONSTRAINT AK_User
UNIQUE (Username)

ALTER TABLE Image
ADD CONSTRAINT AK_Image
UNIQUE (ImagePath)

ALTER TABLE [File]
ADD CONSTRAINT AK_File
UNIQUE (FilePath)

ALTER TABLE Staff
ADD CONSTRAINT AK_Staff
UNIQUE (StaffEmail)

--------------------- SET CHECK CONSTRAINTS -----------------------
ALTER TABLE Staff
ADD CONSTRAINT CK_Staff_StaffStatus
CHECK(StaffStatus = 'A' OR StaffStatus = 'N')

ALTER TABLE Donor
ADD CONSTRAINT CK_Donor_DonorStatus
CHECK(DonorStatus = 'A' OR DonorStatus = 'N')

ALTER TABLE Donor
ADD CONSTRAINT CK_Donor_DonorLevel
CHECK(DonorLevel = 'P' OR DonorLevel = 'G' OR DonorLevel = 'S' OR DonorLevel = 'B')

------------------------ INSERT DATA INTO TABLES ------------------------
GO

SET IDENTITY_INSERT Image ON

--INSERT INTO Content (Image_id, ContentName, ContentInfo, PageNum)
--VALUES (1,'Header picture', null, 1);

INSERT INTO Image (Image_id, ImagePath)
VALUES (1, '..\resources\home_header.png');

SET IDENTITY_INSERt Image OFF

GO

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Header Text', 'Hi', 1);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Header Fact', '14 WARM BEDS. YOUTH 12-17. YOUR TEMPORARY HOME:)', 1);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Header Contacting', 'Have questions? Send us a text!', 1);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Header Contact Number', '(801) 528-1214', 1);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Service Title', 'Services', 1);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Service desc', 'Our programming is divided into three main areas. Each program area has specific components to meet the needs of the youth in need', 1);

GO

SET IDENTITY_INSERT Image ON

INSERT INTO Image (Image_id, ImagePath)
VALUES (2, '..\resources\house_icon.png');

INSERT INTO [Column] (ColumnHeader, ColumnLinkDesc, ColumnLink, Image_id, SectionNumber)
VALUES (
	'Overnight Shelter', 
	'Located in the heart of downtown Ogden, Utah. Youth Futures provides emergency shelter, temporary residence and supportive services for runaway, homeless, unaccompanied and at-risk youth 12-17. The shelter is open 24 hours per day.',
	'secondary.html#historyBanner',
	2,
	1
	);

INSERT INTO Image (Image_id, ImagePath)
VALUES (3, '..\resources\door_icon.png');

INSERT INTO [Column] (ColumnHeader, ColumnLinkDesc, ColumnLink, Image_id, SectionNumber)
VALUES(
	'Drop-in Services',
	'Available to any youth ages 12-18. Drop-in services allow for the youth to access food, clothing, hygiene items, laundry facilities, computer stations, and case management. Drop-in hours are 6:30 am to 8:00 pm every day of the week.',
	'secondary.html#outreachBanner',
	3,
	1
	);

INSERT INTO Image (Image_id, ImagePath)
VALUES (4, '..\resources\van_icon.png');

INSERT INTO [Column] (ColumnHeader, ColumnLinkDesc, ColumnLink, Image_id, SectionNumber)
VALUES (
	'Street Outreach',
	'Youth Futures’ Street Outreach is conducted once per week and provides outreach and crisis services to youth in Ogden City, Utah.',
	'secondary.html#outreachBanner',
	4,
	1
	);

SET IDENTITY_INSERT Image OFF

GO

SET IDENTITY_INSERT Image ON

INSERT INTO Image (Image_id, ImagePath)
VALUES (5, '..\resources\purpose.png');

SET IDENTITY_INSERT Image OFF

GO

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Our Purpose', 'OUR PURPOSE', 1);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Our purpose desc', 'To provide unaccompanied, runaway and homeless youth with a safe and nurturing environment where they can develop the needed skills to become active, healthy, successful members of our future world.', 1);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Our purpose fact', ' 7,085 MEALS SERVED. 511 DROP-IN SERVICES. 245 STREET OUTREACH HOURS. 64 SHELTERED YOUTH.', 1);

GO

SET IDENTITY_INSERT Image ON

INSERT INTO Image (Image_id, ImagePath)
VALUES (6, '..\resources\hand_icon.png');

INSERT INTO [Column] (ColumnHeader, ColumnLinkDesc, ColumnLink, Image_id, SectionNumber)
VALUES ('Apply to Volunteer', 'Make your mark where it matters.', 'secondary.html#donateMain', 6, 2);

INSERT INTO Image (Image_id, ImagePath)
VALUES (7, '..\resources\girl_icon.png');

INSERT INTO [Column] (ColumnHeader, ColumnLinkDesc, ColumnLink, Image_id, SectionNumber)
VALUES ('Youth Stories', 'Read how these young men and women overcome their success stories', 'secondary.html#historyBanner', 7, 2);

INSERT INTO Image (Image_id, ImagePath)
VALUES (8, '..\resources\calendar_icon.png');

INSERT INTO [Column] (ColumnHeader, ColumnLinkDesc, ColumnLink, Image_id, SectionNumber)
VALUES ('Events', 'Check out our monthly events', 'secondary.html#calendarMain', 8, 2);

SET IDENTITY_INSERT Image OFF

GO


-----------------------------------------------secondary pages data-------------------------------------------------------------------