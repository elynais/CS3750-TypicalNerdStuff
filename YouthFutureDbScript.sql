Use master;
-- drop YouthShelterCMS database if it exists
IF EXISTS (SELECT * FROM sys.sysdatabases WHERE NAME = 'YouthFutureCMS')
	DROP DATABASE YouthFutureCMS;

CREATE DATABASE YouthFutureCMS
ON Primary
(NAME = N'YouthFutureCMS' , FILENAME = 
N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\YouthFutureCMS.mdf',
SIZE = 5120KB, FILEGROWTH = 1024KB)
LOG ON
(NAME = N'YouthFutureCMSLog', FILENAME = 
N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\YouthFutureCMS.ldf',
SIZE = 2048KB, FILEGROWTH = 10%);
GO

--ATTACH TO A NEW DATABASE
Use YouthFutureCMS;

-------------------- DROP ALL TABLE IF THEY EXIST -----------------------
IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'yfUser')
	DROP TABLE yfUser;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'yfErrorLog')
	DROP TABLE yfErrorLog;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'yfDonor')
	DROP TABLE yfDonor;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'yfEvent')
	DROP TABLE yfEvent;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'yfContent')
	DROP TABLE yfContent;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'yfImage')
	DROP TABLE yfImage;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'yfStaff')
	DROP TABLE yfStaff;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'yfFile')
	DROP TABLE yfFile;

-------------------- CREATE TABLES -----------------------
CREATE TABLE yfUser
(
	yfUser_id INT IDENTITY(1,1) NOT NULL,
	yfUsername NVARCHAR(20) NOT NULL,
	yfPassword NVARCHAR(25) NOT NULL,
	yfStaff_id INT NOT NULL
);

CREATE TABLE yfStaff
(
	yfStaff_id INT IDENTITY(1,1) NOT NULL,
	yfStaffFirstName NVARCHAR(40) NOT NULL,
	yfStaffLastName NVARCHAR(40) NOT NULL,
	yfStaffEmail NVARCHAR(40) NOT NULL,
	yfStaffTitle NVARCHAR(40) NOT NULL,
	yfBoardTitle NVARCHAR(40) NULL,
	yfImage_id INT NOT NULL,
	yfStaffStatus VARCHAR(1) NOT NULL
);

CREATE TABLE yfImage
(
	yfImage_id INT IDENTITY(1,1) NOT NULL,
	yfImagePath NVARCHAR(450) NOT NULL
);

CREATE TABLE yfContent
(
	yfContent_id INT IDENTITY(1,1) NOT NULL,
	yfImage_id INT NULL,
	yfContentName NVARCHAR(30) NULL, 
	yfContentInfo NVARCHAR(MAX) NULL,
	yfFile_id INT NULL,  -- WHEN THIS IS NOT NULL, CONTENT IS STORED IN A FILE
	yfPageNum INT NOT NULL
);

CREATE TABLE yfFile
(
	yfFile_id INT NOT NULL,
	yfFilePath VARCHAR(450) NOT NULL
);

CREATE TABLE yfDonor
(
	yfDonor_id INT IDENTITY(1,1) NOT NULL,
	yfDonorName NVARCHAR(50) NOT NULL,
	yfDonorYear VARCHAR(40) NOT NULL,
	yfDonorLevel VARCHAR(1) NOT NULL,
	yfDonorStatus VARCHAR(1) NOT NULL,

);

CREATE TABLE yfEvent
(
	yfEvent_id INT IDENTITY(1,1) NOT NULL,
	yfEventName NVARCHAR(50) NOT NULL,
	yfEventDate DATE NOT NULL,
	yfEventDesc NVARCHAR(100) NOT NULL,
	yfEventLocation NVARCHAR(80) NOT NULL
);

CREATE TABLE yfErrorLog
(
	yfErrorLog_id INT IDENTITY(1,1) NOT NULL,
	yfErrorDesc NVARCHAR(MAX) NOT NULL,
	yfErrorDatetime DATETIME NOT NULL,
	yfUser_id INT NOT NULL

);

CREATE TABLE yfColumn
(
	yfColumn_id INT IDENTITY(1,1) NOT NULL,
	yfColumnHeader NVARCHAR(400) NOT NULL,
	yfColumnLinkDesc NVARCHAR(100) NOT NULL,
	yfColumnLink NVARCHAR(200) NOT NULL,
	yfImage_id INT NOT NULL,
	yfSectionNumber INT NOT NULL
);

-------------------- SET PRIMARY KEYS -----------------------
ALTER TABLE yfUser
ADD CONSTRAINT PK_yfUser PRIMARY KEY CLUSTERED (yfUser_id)

ALTER TABLE yfStaff
ADD CONSTRAINT PK_yfStaff PRIMARY KEY CLUSTERED (yfStaff_id)

ALTER TABLE yfImage
ADD CONSTRAINT PK_yfImage PRIMARY KEY CLUSTERED (yfImage_id)

ALTER TABLE yfContent
ADD CONSTRAINT PK_yfContent PRIMARY KEY CLUSTERED (yfContent_id)

ALTER TABLE yfFile
ADD CONSTRAINT PK_yfFile PRIMARY KEY CLUSTERED (yfFile_id)

ALTER TABLE yfDonor
ADD CONSTRAINT PK_yfDonor PRIMARY KEY CLUSTERED (yfDonor_id)

ALTER TABLE yfEvent
ADD CONSTRAINT PK_yfEvent PRIMARY KEY CLUSTERED (yfEvent_id)

ALTER TABLE yfErrorLog
ADD CONSTRAINT PK_yfErrorLog PRIMARY KEY CLUSTERED (yfErrorLog_id)

ALTER TABLE yfColumn
ADD CONSTRAINT PK_yfColumn PRIMARY KEY CLUSTERED (yfColumn_id)

-------------------- SET FOREIGN KEYS ---------------------------
ALTER TABLE yfErrorLog
ADD CONSTRAINT FK_yfErrorLog_yfUser
FOREIGN KEY (yfUser_id)
REFERENCES yfUser (yfUser_id)

ALTER TABLE yfUser
ADD CONSTRAINT FK_yfUser_yfStaff
FOREIGN KEY (yfStaff_id)
REFERENCES yfStaff (yfStaff_id)

ALTER TABLE yfStaff
ADD CONSTRAINT FK_yfStaff_yfImage
FOREIGN KEY (yfImage_id)
REFERENCES yfImage (yfImage_id)

ALTER TABLE yfContent
ADD CONSTRAINT FK_yfContent_yfImage
FOREIGN KEY (yfImage_id)
REFERENCES yfImage (yfImage_id)

ALTER TABLE yfContent
ADD CONSTRAINT FK_yfContent_yfFile
FOREIGN KEY (yfFile_id)
REFERENCES yfFile (yfFile_id)

ALTER TABLE yfColumn
ADD CONSTRAINT FK_yfColumn_yfImage
FOREIGN KEY (yfImage_id)
REFERENCES yfImage (yfImage_id)

------------------ SET ALTERNATIVE KEY TO UNIQUE ------------------
ALTER TABLE yfUser
ADD CONSTRAINT AK_yfUser
UNIQUE (yfUsername)

ALTER TABLE yfImage
ADD CONSTRAINT AK_yfImage
UNIQUE (yfImagePath)

ALTER TABLE yfFile
ADD CONSTRAINT AK_yfFile
UNIQUE (yfFilePath)

ALTER TABLE yfStaff
ADD CONSTRAINT AK_yfStaff
UNIQUE (yfStaffEmail)

--------------------- SET CHECK CONSTRAINTS -----------------------
ALTER TABLE yfStaff
ADD CONSTRAINT CK_yfStaff_yfStaffStatus
CHECK(yfStaffStatus = 'A' OR yfStaffStatus = 'N')

ALTER TABLE yfDonor
ADD CONSTRAINT CK_yfDonor_yfDonorStatus
CHECK(yfDonorStatus = 'A' OR yfDonorStatus = 'N')

ALTER TABLE yfDonor
ADD CONSTRAINT CK_yfDonor_yfDonorLevel
CHECK(yfDonorLevel = 'P' OR yfDonorLevel = 'G' OR yfDonorLevel = 'S' OR yfDonorLevel = 'B')

------------------------ INSERT DATA INTO TABLES ------------------------

---------- yfContent
INSERT INTO yfContent (yfContentDesc, yfPageNum)
VALUES ('Hi', 1);

INSERT INTO yfContent (yfContentDesc, yfPageNum)
VALUES ('14 WARM BEDS. YOUTH 12-17. YOUR TEMPORARY HOME :)', 1)

INSERT INTO yfContent (yfContentDesc, yfPageNum)
VALUES ('Have questions? Send us a text!', 1)

