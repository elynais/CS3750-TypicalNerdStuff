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
(NAME = N'YouthFutureDbLog', FILENAME = 
N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\\YouthFutureDb.ldf',
SIZE = 2048KB, FILEGROWTH = 10%);

--(NAME = N'YouthFutureDb', FILENAME =
--	N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\YouthFutureDb.mdf',
--	SIZE = 5120KB, FILEGROWTH = 1024KB)

--	LOG ON
--	(NAME = N'YouthFutureDbLOG', FILENAME =
--	N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\YouthFutureDbLog.ldf',
--	SIZE = 2048KB, FILEGROWTH = 10%);
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

--IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'Event')
--	DROP TABLE Event;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'Content')
	DROP TABLE Content;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'Image')
	DROP TABLE Image;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'Board')
	DROP TABLE Board;

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'Staff')
	DROP TABLE Staff;

--IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'File')
--	DROP TABLE [File];

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

CREATE TABLE Board
(	
	Board_id INT IDENTITY(1,1) NOT NULL,
	BoardMemberName NVARCHAR(255) NOT NULL,
	BoardMemberTitle NVARCHAR(255) NOT NULL,
	Staff_id INT NULL,
	Image_id INT NULL,
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
	--File_id INT NULL,  -- WHEN THIS IS NOT NULL, CONTENT IS STORED IN A FILE
	PageNum INT NOT NULL
);

--CREATE TABLE [File]
--(
--	File_id INT NOT NULL,
--	FilePath VARCHAR(450) NOT NULL
--);

CREATE TABLE Donor
(
	Donor_id INT IDENTITY(1,1) NOT NULL,
	DonorName NVARCHAR(50) NOT NULL,
	DonorYear VARCHAR(40) NOT NULL,
	DonorLevel VARCHAR(1) NOT NULL,
	DonorStatus VARCHAR(1) NOT NULL,

);

--CREATE TABLE Event
--(
--	Event_id INT IDENTITY(1,1) NOT NULL,
--	EventName NVARCHAR(50) NOT NULL,
--	EventDate DATE NOT NULL,
--	EventDesc NVARCHAR(100) NOT NULL,
--	EventLocation NVARCHAR(80) NOT NULL
--);

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
	ColumnHeader NVARCHAR(400) NULL,
	ColumnInfo NVARCHAR(MAX) NOT NULL,
	ColumnLink NVARCHAR(200) NULL,
	ColumnLinkDesc NVARCHAR(200) NULL,
	Image_id INT NOT NULL,
	SectionNumber INT NOT NULL
);

-------------------- SET PRIMARY KEYS -----------------------
ALTER TABLE [User]
ADD CONSTRAINT PK_User PRIMARY KEY CLUSTERED (User_id)

ALTER TABLE Staff
ADD CONSTRAINT PK_Staff PRIMARY KEY CLUSTERED (Staff_id)

ALTER TABLE Board
ADD CONSTRAINT PK_Board PRIMARY KEY CLUSTERED (Board_id)

ALTER TABLE Image
ADD CONSTRAINT PK_Image PRIMARY KEY CLUSTERED (Image_id)

ALTER TABLE Content
ADD CONSTRAINT PK_Content PRIMARY KEY CLUSTERED (Content_id)

--ALTER TABLE [File]
--ADD CONSTRAINT PK_File PRIMARY KEY CLUSTERED (File_id)

ALTER TABLE Donor
ADD CONSTRAINT PK_Donor PRIMARY KEY CLUSTERED (Donor_id)

--ALTER TABLE Event
--ADD CONSTRAINT PK_Event PRIMARY KEY CLUSTERED (Event_id)

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

ALTER TABLE Board
ADD CONSTRAINT FK_Board_Staff
FOREIGN KEY (Staff_id)
REFERENCES Staff (Staff_id)

ALTER TABLE Board
ADD CONSTRAINT FK_Board_Image
FOREIGN KEY (Image_id)
REFERENCES Image (Image_id)

ALTER TABLE Content
ADD CONSTRAINT FK_Content_Image
FOREIGN KEY (Image_id)
REFERENCES Image (Image_id)

--ALTER TABLE Content
--ADD CONSTRAINT FK_Content_File
--FOREIGN KEY (File_id)
--REFERENCES [File] (File_id)

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

--ALTER TABLE [File]
--ADD CONSTRAINT AK_File
--UNIQUE (FilePath)

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
VALUES ('Header Fact', '14 WARM BEDS. YOUTH 12-17. YOUR TEMPORARY HOME <span class="quicksand-dark-38-lightgreen">:)</span>', 1);

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

INSERT INTO [Column] (ColumnHeader, ColumnInfo, ColumnLink, Image_id, SectionNumber, ColumnLinkDesc)
VALUES (
	'Overnight Shelter', 
	'Located in the heart of downtown Ogden, Utah. Youth Futures provides emergency shelter, temporary residence and supportive services for runaway, homeless, unaccompanied and at-risk youth 12-17. The shelter is open 24 hours per day.',
	'/Secondary/Index#historyBanner',
	2,
	1,
	'Learn more >'
	);

INSERT INTO Image (Image_id, ImagePath)
VALUES (3, '..\resources\door_icon.png');

INSERT INTO [Column] (ColumnHeader, ColumnInfo, ColumnLink, Image_id, SectionNumber, ColumnLinkDesc)
VALUES(
	'Drop-in Services',
	'Available to any youth ages 12-18. Drop-in services allow for the youth to access food, clothing, hygiene items, laundry facilities, computer stations, and case management. Drop-in hours are 6:30 am to 8:00 pm every day of the week.',
	'/Secondary/Index#outreachBanner',
	3,
	1,
	'Learn more >'
	);

INSERT INTO Image (Image_id, ImagePath)
VALUES (4, '..\resources\van_icon.png');

INSERT INTO [Column] (ColumnHeader, ColumnInfo, ColumnLink, Image_id, SectionNumber, ColumnLinkDesc)
VALUES (
	'Street Outreach',
	'Youth FuturesÕ Street Outreach is conducted once per week and provides outreach and crisis services to youth in Ogden City, Utah.',
	'/Secondary/Index#outreachBanner',
	4,
	1,
	'Learn more >'
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
VALUES ('Our purpose fact', '<span class="alt-color">7,085</span> MEALS SERVED. <span class="alt-color">511</span> DROP-IN SERVICES. <span class="alt-color">245</span> STREET OUTREACH HOURS. <span class="alt-color">64</span> SHELTERED YOUTH.', 1);
 
GO

SET IDENTITY_INSERT Image ON

INSERT INTO Image (Image_id, ImagePath)
VALUES (6, '..\resources\hand_icon.png');

INSERT INTO [Column] (ColumnHeader, ColumnInfo, ColumnLink, Image_id, SectionNumber, ColumnLinkDesc)
VALUES ('Apply to Volunteer', 'Make your mark where it matters.', '/Secondary/Index#donateMain', 6, 2, 'Volunteer Now >');

INSERT INTO Image (Image_id, ImagePath)
VALUES (7, '..\resources\girl_icon.png');

INSERT INTO [Column] (ColumnHeader, ColumnInfo, ColumnLink, Image_id, SectionNumber, ColumnLinkDesc)
VALUES ('Youth Stories', 'Read how these young men and women overcome their success stories', '/Secondary/Index#historyBanner', 7, 2, 'Read the Stories >');

INSERT INTO Image (Image_id, ImagePath)
VALUES (8, '..\resources\calendar_icon.png');

INSERT INTO [Column] (ColumnHeader, ColumnInfo, ColumnLink, Image_id, SectionNumber, ColumnLinkDesc)
VALUES ('Events', 'Check out our monthly events', '/Secondary/Index#calendarMain', 8, 2, 'View All Events >');

SET IDENTITY_INSERT Image OFF

GO

-----------------------------------------------secondary pages data-------------------------------------------------------------------

INSERT INTO Content (ContentName, ContentInfo, PageNum) 
VALUES ('2nd header question','Have questions? Send us a text!', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('2nd header phone', '(801) 528-1214', 2);
 
GO

SET IDENTITY_INSERT Image ON

INSERT INTO Image (Image_id, ImagePath)
VALUES (9, '..\resources\history_header.jpg');

SET IDENTITY_INSERT Image OFF

GO

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('YF History', 'YOUTH FUTURES HISTORY', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('YF His descib', 'Located in the heart of downtown Ogden, Youth Futures opened Utah''s first homeless Residential Support Temporary Youth Shelter on February 20, 2015. Youth Futures provides shelter and drop-in services to all youth ages 12-17, and will not exclude any youth who falls within these age ranges, regardless of circumstance. We provide 14 temporary overnight shelter beds and day-time drop-in services to youth, as well as intensive case management to help youth become re-united with family or self-sufficiently contributing to our community. Weekly outreach efforts assist in building rapport with street youth, ensuring they receive food and other basic necessities and educating them about options to living in unsafe conditions. Youth are guided in a loving, supportive and productive way, encouraging their own personal path for a healthy future.', 2);

GO

SET IDENTITY_INSERT Image ON

INSERT INTO Image (Image_id, ImagePath)
VALUES (10, '..\resources\history_kristen_scott.jpg');

INSERT INTO [Column] (ColumnHeader, ColumnInfo, Image_id, SectionNumber)
VALUES('YF founders', 'Kristen and Scott', 10, 3);

INSERT INTO Image(Image_id, ImagePath)
VALUES (11, '..\resources\history_shelter.jpg');

INSERT INTO [Column] (ColumnHeader, ColumnInfo, Image_id, SectionNumber)
VALUES ('YF house', 'The shelter home', 11, 3);

INSERT INTO Image(Image_id, ImagePath)
VALUES (12, '..\resources\history_kristen.jpg');

INSERT INTO [Column] (ColumnHeader, ColumnInfo, Image_id, SectionNumber)
VALUES ('YF kristen','Kristen', 12, 3);

SET IDENTITY_INSERT Image OFF

GO

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('YF founder descr','Youth Futures was founded by Kristen Mitchell and Scott Catuccio, who had been conceptually planning to provide shelter and case management services to youth for over six years. It was identified that there was a lack of shelter services for the estimated 5,000 youth who experience homelessness for at least one night a year in Utah, so Scott and Kristen began researching other states that provide shelter services to youth. It was quickly identified that the largest barrier to providing services to homeless youth in Utah was a law prohibiting the opening of shelter facilities for youth.', 2);

GO

SET IDENTITY_INSERT Image ON

INSERT INTO Image(Image_id, ImagePath)
VALUES (13, '..\resources\history_5000.jpg');

SET IDENTITY_INSERT Image OFF

GO

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('YF history Fact','5,000 youth experiences homelessness for at leat one night a year in Utah', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('YF history fact desc', 'During the 2014 Legislative Session, HB132 was passed, which allowed for rewriting the prohibitive law and drafting licensing procedures for residential support programs for temporary homeless youth shelter in Utah. Youth Futures and other homeless youth service providers participated in the rules writing process. The licensing rules enrolled on October 22, 2014, and the founders began to set-up the facility for licensing. Youth Futures received the first license for homeless youth shelter granted in the State of Utah under the new law.', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('YF history Fact2','During the first full year of operations (February 20, 2015 - March 31, 2016), our Residential Support Temporary Youth Shelter has:', 2);

GO

SET IDENTITY_INSERT Image ON

INSERT INTO Image(Image_id, ImagePath)
VALUES (14, '..\resources\history_meal.svg');

INSERT INTO Image(Image_id, ImagePath)
VALUES (15, '..\resources\donate_hand.svg');

INSERT INTO Image(Image_id, ImagePath)
VALUES (16, '..\resources\house_icon2.png');

SET IDENTITY_INSERT Image OFF

GO

INSERT INTO [Column] (ColumnInfo, Image_id, SectionNumber)
VALUES ('Served <span class = "green">7,085</span> meals; 3 meals a day and 2 snacks for shelter and drop-in youth. Opened the resource room <span class = "green">354</span> times with access to basic nec-essities including clothing, hygiene items, back packs, blankets, sleeping bags, basic medical supplies, etc.', 14, 4);

INSERT INTO [Column] (ColumnInfo, Image_id, SectionNumber)
VALUES ('Conducted more than <span class = "green">245</span> street outreach hours and provided items from the resource room to street youth.', 15, 4);

INSERT INTO [Column] (ColumnInfo, Image_id, SectionNumber)
VALUES ('Provided <span class = "green">1,535</span> shelter night stays and <span class = "green">511</span> drop in services including case management, connections to health care, mental health care and group therapy, facilitation with other youth service providers, computer access, showers, laundry facilities, etc.', 16, 4);

GO 

SET IDENTITY_INSERT Image ON

INSERT INTO Image(Image_id, ImagePath)
VALUES (17, '..\resources\outreach_header.jpg');

INSERT INTO Image(Image_id, ImagePath)
VALUES (99,'');

SET IDENTITY_INSERT Image OFF

GO

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('YF outreach', 'STREET OUTREACH', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('YF outreach desc','Street Outreach is designed to meet the clients where they are on the street to build rapport and encourage youth to access drop-in and shelter services. This program offers, case management, hygiene items, food, sleeping bags, and other essential items as needed. Street Outreach currently take place once per week on Wednesdays. The team visits the same Ogden, Utah locations every week:', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('YF outreach list1', '<li>Jefferson Park</li> <li>Marchall White Center Park</li> <li>Lorin Farr Skate Park</li>', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('YF outreach list2', '<li>Basketball Court at Bonneville Park</li> <li>Under the Ogden River Bridge (sporadic)</li> <li>Lantern House Homeless Shelter</li>', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Board of Dir', 'BOARD OF DIRECTORS', 2);

INSERT INTO Board (BoardMemberName, BoardMemberTitle, Staff_id)
VALUES ('SCOTT CATUCCO', 'Board President, A3 Utah', null);

INSERT INTO Board (BoardMemberName, BoardMemberTitle, Staff_id)
VALUES ('KRISTEN MITCHELL', 'Board Vice President  Executive Director, Youth Futures', null);

--INSERT INTO [Column] (ColumnHeader, ColumnInfo, ColumnLink, ColumnLinkDesc, Image_id, SectionNumber)
--VALUES ('SCOTT CATUCCIO', 'Board President President, A3 Utah','scottcatuccio@gmail.com','scottcatuccio@gmail.com', 99, 5);

--INSERT INTO [Column] (ColumnHeader, ColumnInfo, ColumnLink, ColumnLinkDesc, Image_id, SectionNumber)
--VALUES ('KRISTEN MITCHELL', 'Board Vice President  Executive Director, Youth Futures','kristen@yfut.org', 'kristen@yfut.org', 99, 5);

--INSERT INTO [Column] (ColumnHeader, ColumnInfo, ColumnLink, ColumnLinkDesc, Image_id, SectionNumber)
--VALUES ('ALYSON DEUSSEN', 'Board Secretary Ouelessebougou Utah Alliance', 'alysondeussen@gmail.com','alysondeussen@gmail.com', 99, 5);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Staff', 'OUR STAFF', 2);

GO

SET IDENTITY_INSERT Image ON

INSERT INTO Image(Image_id, ImagePath)
VALUES (18, '..\resources\staff_justine.jpg');

INSERT INTO Image(Image_id, ImagePath)
VALUES (19, '..\resources\staff_susan.jpg');

INSERT INTO Image(Image_id, ImagePath)
VALUES (20, '..\resources\staff_alyson.jpg');

SET IDENTITY_INSERT Image OFF

GO

INSERT INTO Staff (StaffFirstName, StaffLastName, StaffEmail, StaffTitle, BoardTitle, Image_id, StaffStatus)
VALUES ('Justine', 'Murray', 'jmurray@yfut.org', 'Program Manager', null, 18, 'A');

INSERT INTO Staff (StaffFirstName, StaffLastName, StaffEmail, StaffTitle, BoardTitle, Image_id, StaffStatus)
VALUES ('Susan', 'McBride', 'smcbride@yfut.org', 'Floor Staff Co-Lead', null, 19, 'A');

GO

SET IDENTITY_INSERT Staff ON

INSERT INTO Staff ( Staff_id, StaffFirstName, StaffLastName, StaffEmail, StaffTitle, BoardTitle, Image_id, StaffStatus)
VALUES (3, 'Alyson', 'Deussen', 'aallred@yfut.org', 'Floor Staff Co-Lead', 'Board Secretary', 20, 'A');

INSERT INTO Board (BoardMemberName, BoardMemberTitle, Staff_id)
VALUES ('ALYSON DEUSSEN', 'Board Secretary Ouelessebougou Utah Alliance', 3);

SET IDENTITY_INSERT Staff OFF

GO

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Media', 'MEDIA', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('media headline', 'America First Provides an ''Assist'' to Homeless Shelter', 2);

GO

SET IDENTITY_INSERT Image ON

INSERT INTO Image(Image_id, ImagePath)
VALUES (21, '..\resources\media_check.jpg');

SET IDENTITY_INSERT Image OFF

GO

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('media check desc', 'At right, from left to right: Kristen Mitchell, executive director of Youth Futures Utah and Scott Tuccio, president of the Board of Directorsof Youth Futures Utah, stand with Nicole Cypers, public relations and social media manager for America First Credit Union, at the Weber State basketball game for a check presentation in the amount of $3,400 on Saturday, March 7 at Weber State University.', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('media check story1', 'OGDEN, Utah--America First Credit Union awarded Youth Futures Utah, a homeless shelter for youth, with $3,400 during the Weber State University basketball game. America First paid the organization $10 for each assist the Weber State University basketball team completed throughout the 2014 – 2015 season. With 340 assists, the donation amounted to $3,400 in total for the newly-opened youth homeless organization, located in Ogden, Utah.', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('media check story2', 'Youth Futures Utah is a 501(c)3 organization committed to the well-being of the youth of Utah. The mission of Youth Futures Utah is to provide shelter, support, resources and guidance to homeless, unaccompanied and runaway youth in Utah. Youth Futures connects each youth with food, housing and resources to build the skills needed to support a healthy future.', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Donors', 'DONORS', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Plat Donors','Plantinum Level Donors', 2);

INSERT INTO Donor (DonorName, DonorYear, DonorLevel, DonorStatus)
VALUES ('Miller Family Foundation Larry H. & Gail', '2015 & 2016', 'P', 'A');

INSERT INTO Donor (DonorName, DonorYear, DonorLevel, DonorStatus)
VALUES ('Ivy Lane Pediatrics', '2016', 'P', 'A');

INSERT INTO Donor (DonorName, DonorYear, DonorLevel, DonorStatus)
VALUES ('Sorenson Legacy Foundation', '2015', 'P', 'A');

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Gold Donors','Gold Level Donors', 2);

INSERT INTO Donor (DonorName, DonorYear, DonorLevel, DonorStatus)
VALUES ('Miller Family Foundation Larry H. & Gail', '2015 & 2016', 'G', 'A');

INSERT INTO Donor (DonorName, DonorYear, DonorLevel, DonorStatus)
VALUES ('Ivy Lane Pediatrics', '2016', 'G', 'A');

INSERT INTO Donor (DonorName, DonorYear, DonorLevel, DonorStatus)
VALUES ('Sorenson Legacy Foundation', '2015', 'G', 'A');

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Silver Donors','Silver Level Donors', 2);

INSERT INTO Donor (DonorName, DonorYear, DonorLevel, DonorStatus)
VALUES ('Miller Family Foundation Larry H. & Gail', '2015 & 2016', 'S', 'A');

INSERT INTO Donor (DonorName, DonorYear, DonorLevel, DonorStatus)
VALUES ('Ivy Lane Pediatrics', '2016', 'S', 'A');

INSERT INTO Donor (DonorName, DonorYear, DonorLevel, DonorStatus)
VALUES ('Sorenson Legacy Foundation', '2015', 'S', 'A');

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Bronze Donors','Bronze Level Donors', 2);

INSERT INTO Donor (DonorName, DonorYear, DonorLevel, DonorStatus)
VALUES ('Miller Family Foundation Larry H. & Gail', '2015 & 2016', 'B', 'A');

INSERT INTO Donor (DonorName, DonorYear, DonorLevel, DonorStatus)
VALUES ('Ivy Lane Pediatrics', '2016', 'B', 'A');

INSERT INTO Donor (DonorName, DonorYear, DonorLevel, DonorStatus)
VALUES ('Sorenson Legacy Foundation', '2015', 'B', 'A');

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('donations','DONATE', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('donations question', 'HOW CAN YOU HELP?', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('please donate', 'Your generosity helps keep the doors open and the lights on, providing a sanctuary for those in need. Please consider a donation.', 2);

GO

SET IDENTITY_INSERT Image ON

INSERT INTO Image(Image_id, ImagePath)
VALUES (22, '..\resources\donate_dollar.svg');

INSERT INTO Image(Image_id, ImagePath)
VALUES (23, '..\resources\donate_cart.svg');

--INSERT INTO Image(Image_id, ImagePath)
--VALUES (24, '..\resources\donate_hand.svg');

SET IDENTITY_INSERT Image OFF

GO

INSERT INTO [Column] (ColumnInfo, Image_id, SectionNumber)
VALUES ('Monetary donations are our biggest need right now. Recurring <span class = "green"><a href="https://www.paypal.com/donate/?token=jeB7uObfTI7Nfw4Tx4PaidB_PzukgOctKJHDDfMJzE7JdkG6dfpuY6AlEvS1ktKjGQ9H2W&country.x=US&locale.x=US">PayPal</a> </span> donations can be scheduled from our website, even $10 makes a difference.', 22, 7);

INSERT INTO [Column] (ColumnInfo, Image_id, SectionNumber)
VALUES ('Donate through rewards programs: <span class = "green"><a href="https://smile.amazon.com/ref=smi_ext_ch_45-3245622_dl?_encoding=UTF8&ein=45-3245622&ref_=smi_chpf_redirect&ref_=smi_ext_ch_45-3245622_cl">Amazon Smile,</a> </span> <span class = "green"><a href="https://www.smithsfoodanddrug.com/account/create/">Smiths Community Rewards,</a></span> or <span class = "green"><a href="https://www.unitedway.org/">United Way,</a></span> <span class = "green">Federal and State Employee contributions,</a></span> <span class = "green"><a href="https://loveutgiveut.razoo.com/organization/Youthfutures">LoveUTGiveUT', 23, 7);

INSERT INTO [Column] (ColumnInfo, Image_id, SectionNumber)
VALUES ('Donate your time as a volunteer to help with needs around the shelter! <span class="green"><a href="https://www.classy.org/charity/youth-futures/c37253">Sign up here.</a></span>', 15, 7);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('list of needs', 'LIST OF NEEDS', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Most important needs', 'MOST IMPORTANT NEEDS (In order of priority)',2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES('important needs', '<li>Cash donations</li> <li>Printer Paper</li> <li>Canned meat & Jerky</li> <li>Scotch tape</li> <li>Bus tokens or passes</li> <li>Earbud Headphones</li> <li>Cinch bags</li> <li>Batteries</li> <li>Sweat Pants</li> <li>Pajama Bottoms </li> <li>Sports bras</li> <li>Trail mix individuals</li> <li>Toilet Paper</li> <li>Condoms</li> <li>Tampons</li> <li>Carabiners</li> <li>Paper plates and cups</li>	<li>Mens and Womens Underwear</li> <li>Socks </li>	<li>Kleenex individuals</li> <li>Undershirts, S M L XL</li>	<li>Garbage bags 30 Gallon</li>	<li>Garbage sacks small</li> <li>Lip balm</li> <li>Ziploc bags, quart and gallon</li> <li>Energy Bars</li> <li>Heavy duty plastic storage bins that will not melt if heated in shed</li>', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Misc needs', 'MISC. NEEDS', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('misc list', '<li>Minivan</li> <li>NEW Printer</li>', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Gift cards', 'GIFT CARDS FOR', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('gift card list', '<li>Walmart</li> <li>Fun things to do</li> <li>Grocery store</li> <li>Maverick</li> <li>Restaurants</li>	<li>Movies</li> <li>Bus passes or tokens</li> <li>Phone minutes </li> <li>Beauty salons/haircuts</li> <li>For shoe stores</li> <li>Lagoon passes</li>', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('house furnishings', 'HOUSEHOLD FURNISHINGS NEEDS', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('furnishings list', '<li>NEW pots and pans</li> <li>New Couches</li>', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Voluneteers', 'VOLUNETEERS', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Voluneteers list', '<li>Mentors</li> <li>Educators</li> <li>Group activity facilitators</li> <li>Meal preparers/providers</li>	<li>Tutors</li>	<li>Life skills trainers</li> <li>Beauticians</li> <li>Street Outreach Workers</li> <li>Artists for classes</li> <li>Yard work</li> <li>Interior painters</li>', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Repair needs', 'REPAIR NEEDS', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Repair list', '<li>Concrete or pavers 1500 sq. feet</li> <li>Cement sidewalk repair& labor</li>', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Contact Title', 'CONTACT', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Contact us', 'CONTACT US', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Contact call us', 'CALL US', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Contact number', 'Tel: 801-528-1214', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('come see us', 'COME SEE US', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('address1', '60 Adams Ave. Ogden, UT', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('address2', 'Ogden, Utah 84401', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('social media', 'SOCIAL MEDIA', 2);