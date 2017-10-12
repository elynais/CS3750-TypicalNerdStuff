Use master;
-- drop YouthShelterCMS database if it exists
IF EXISTS (SELECT * FROM sys.sysdatabases WHERE NAME = 'YouthFutureDb')
	DROP DATABASE YouthFutureDb;

CREATE DATABASE [YouthFutureDb]
ON Primary
--(NAME = N'YouthFutureDb', FILENAME = 
--N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\YouthFutureDb.mdf',
--SIZE = 5120KB, FILEGROWTH = 1024KB)
--LOG ON
--(NAME = N'YouthFutureDbLog', FILENAME = 
--N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\\YouthFutureDb.ldf',
--SIZE = 2048KB, FILEGROWTH = 10%);

(NAME = N'YouthFutureDb', FILENAME =
	N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\YouthFutureDb.mdf',
	SIZE = 5120KB, FILEGROWTH = 1024KB)

	LOG ON
	(NAME = N'YouthFutureDbLOG', FILENAME =
	N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\YouthFutureDbLog.ldf',
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
VALUES ('Header Fact', '14 WARM BEDS. YOUTH 12-17. YOUR TEMPORARY HOME', 1);

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
VALUES ('Our purpose fact', ' 7,085 MEALS SERVED. 511 DROP-IN SERVICES. 245 STREET OUTREACH HOURS. 64 SHELTERED YOUTH.', 1);

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
VALUES ('Served 7,085 meals; 3 meals a day and 2 snacks for shelter and drop-in youth. Opened the resource room 354 times with access to basic nec-essities including clothing, hygiene items, back packs, blankets, sleeping bags, basic medical supplies, etc.', 14, 4);

INSERT INTO [Column] (ColumnInfo, Image_id, SectionNumber)
VALUES ('Conducted more than 245 street outreach hours and provided items from the resource room to street youth', 15, 4);

INSERT INTO [Column] (ColumnInfo, Image_id, SectionNumber)
VALUES ('Provided 1,535 shelter night stays and 511 drop in services including case management, connections to health care, mental health care and group therapy, facilitation with other youth service providers, computer access, showers, laundry facilities, etc.', 16, 4);

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
VALUES ('YF outreach list1', 'Jefferson Park  Marshall White Center Park  Lorin Farr Skate Park', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('YF outreach list2', 'Basketball Court at Bonneville Park  Under the Ogden River bridge (sporadic)  Lantern House Homeless Shelter', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Board of Dir', 'BOARD OF DIRECTORS', 2);

INSERT INTO [Column] (ColumnHeader, ColumnInfo, ColumnLink, ColumnLinkDesc, Image_id, SectionNumber)
VALUES ('SCOTT CATUCCIO', 'Board President President, A3 Utah','scottcatuccio@gmail.com','scottcatuccio@gmail.com', 99, 5);

INSERT INTO [Column] (ColumnHeader, ColumnInfo, ColumnLink, ColumnLinkDesc, Image_id, SectionNumber)
VALUES ('KRISTEN MITCHELL', 'Board Vice President  Executive Director, Youth Futures','kristen@yfut.org', 'kristen@yfut.org', 99, 5);

INSERT INTO [Column] (ColumnHeader, ColumnInfo, ColumnLink, ColumnLinkDesc, Image_id, SectionNumber)
VALUES ('ALYSON DEUSSEN', 'Board Secretary Ouelessebougou Utah Alliance', 'alysondeussen@gmail.com','alysondeussen@gmail.com', 99, 5);

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

INSERT INTO Staff (StaffFirstName, StaffLastName, StaffEmail, StaffTitle, BoardTitle, Image_id, StaffStatus)
VALUES ('Alyson', 'Deussen', 'aallred@yfut.org', 'Floor Staff Co-Lead', 'Board Secretary', 20, 'A');

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
VALUES ('Monetary donations are our biggest need right now. Recurring PayPal donations can be scheduled from our website, even $10 makes a difference.', 22, 7);

INSERT INTO [Column] (ColumnInfo, Image_id, SectionNumber)
VALUES ('Donate through rewards programs Amazon Smile, Smiths Community Rewards or United Way Federal and State Employee contributions LoveUTGiveUT', 23, 7);

INSERT INTO [Column] (ColumnInfo, Image_id, SectionNumber)
VALUES ('Donate your time as a volunteer to help with needs around the shelter! Sign up here.', 15, 7);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('list of needs', 'LIST OF NEEDS', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Most important needs', 'MOST IMPORTANT NEEDS (In order of priority) Cash donations Printer Paper Canned meat & Jerky Scotch tape Bus tokens or passes Earbud Headphones Cinch bags Batteries Sweat Pants Pajama Bottoms Sports bras Trail mix individuals Toilet Paper Condoms Tampons Carabiners Paper plates and cups Mens and Womens Underwear Socks Kleenex individuals Undershirts, S M L XL Garbage bags 30 Gallon Garbage sacks small Lip balm Ziploc bags, quart and gallon Energy Bars Heavy duty plastic storage bins that will not melt if heated in shed', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Misc needs', 'MISC. NEEDS MiniVan NEW Printer', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Gift cards', 'GIFT CARDS FOR Walmart Fun things to do Grocery store Maverick Restaurants Movies Bus passes or tokens Phone minutes Beauty salons/haircuts Shoe stores Lagoon passes', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('house furnishings', 'HOUSEHOLD FURNISHINGS NEEDS NEW pots and pans New couches', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Voluneteers', 'VOLUNETEERS Mentors Educators Group activity facilitators Meal preparers/providers Tutors Life skills trainers Beauticians Street Outreach Workers Artists for classes Yard work Interior painters', 2);

INSERT INTO Content (ContentName, ContentInfo, PageNum)
VALUES ('Repair needs', 'REPAIR NEEDS Concrete or pavers 1500 sq. feet Cement sidewalk repairs & labor', 2);

