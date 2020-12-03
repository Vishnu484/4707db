--First, we drop the bowling schema if it happens to exist.
-- by specifying the *cascade* option, we direct the
-- database to also drop all dependent objects.
-- This means if we run this script a second time we
-- will be starting with a clean slate.
drop schema if exists bowling cascade;

--After we ensure that we won't have any collisions by dropping
-- the schema we are free to create it.
create schema if not exists bowling;

--This is how we set our context in the postgres database.
set search_path to 'bowling';
--For mysql, use this command to set our context:
--use cars;


--The first table if not exists we create is the state table if not exists.
-- The states are identified by their abbr[eviation]
-- but the name of a state must also be unique.  Both
-- abbr and name are candidate keys for the corresponding
-- entity set.  A state name is required.
create table if not exists Alley (
	PhoneNum varchar(12) not null,
	Name varchar(100) not null,
	constraint pk_Alley primary key (PhoneNum),
);

--Using this form of the insert statement we can create
-- multiple rows at once.  We have already specified our
-- context as the bowling schema so this table if not exists will be
-- implicitly created there.
insert into Alley values
('763-503-2695','BrunswickZoneBrooklynPark');


/*create table if not exists Game (
	AlleyPhoneNum varchar(12),
	Time double ,
	Lanenum int,
	constraint pk_Game primary key (AlleyPhoneNum,Time,Lanenum),
	constraint fk_Game foreign key (AlleyPhoneNum) references state(PhoneNum)
);

insert into Game values
('763-503-2695',1567952467,43);


create table if not exists Line (
	GameAlleyPhonenum varchar(12) ,
	GameTime int,
	GameLaneNum int,
  PlayerNum int,
	PlayerName int,
	constraint pk_Line primary key (GameAlleyPhonenum, GameTime,GameLaneNum,PlayerNum),
	constraint fk_Line foreign key (GameAlleyPhonenum, GameTime,GameLaneNum) references Alley(AlleyPhoneNum,Time,Lanenum)
);

insert into Line values
('763-503-2695',1567952467,43,2,'MADDIE'),
('763-503-2695',1567952467,43,1,'COOPER'),
('763-503-2695',1567952467,43,3,'DAD');

create table if not exists Frame(
	LineAlleyPhoneNum varchar(12),
	LineGameTime int,
	LineGameLaneNum int,
	LinePlayernum int,
	FrameNum int,
	Roll1score int,
	Roll2score int,
	Roll3score int,
	isSplit bool,
	constraint ck_roll3score check ((Roll3score is null AND FrameNum <> 10)OR(Roll3score is not null AND FrameNum=10)),
	constraint ck_roll2score check ((Roll2score is null AND Roll1score=10 AND FrameNum<>10)OR (Roll2score is not null AND Roll1score =10 AND FrameNum=10)OR (Roll2score is not null AND Roll1score <>10 AND FrameNum<>10)OR(Roll2score is not null AND Roll1score <>10 AND FrameNum=10)),
	constraint pk_Frame primary key (LineAlleyPhoneNum,LineGameTime,LineGameLaneNum,LinePlayernum,FrameNum),
	constraint fk_Frame foreign key (LineAlleyPhoneNum,LineGameTime,LineGameLaneNum,LinePlayernum) references Line(GameAlleyPhonenum,GameTime,GameLaneNum,PlayerNum)
);

insert into Frame values
('763-503-2695',1567952467,43,2,2,0,9,NULL,FALSE),
('763-503-2695',1567952467,43,2,8,10,NULL,NULL,FALSE),
('763-503-2695',1567952467,43,1,6,8,0,NULL,TRUE),
('763-503-2695',1567952467,43,3,10,10,8,0,FALSE),
('763-503-2695',1567952467,43,1,1,3,7,NULL,FALSE);


select * from Alley;
select * from Game;
select * from Line;
select * from Frame;
*/
/*drop schema if exists menus cascade;

create schema if not exists menus;

set search_path to 'menus';

create table if not exists Menu (
  Restaurant_name varchar(50),
	URL varchar(50),
	description varchar(100),
	constraint pk_Menu primary key (Restaurant_name),
);

insert into Menu values
('Sally''s', 'http:/sallyssaloon.net/menu', 'Thanks for dining with us! 700 Wash Ave');

create table if not exists Category (
	R_name varchar(50),
	Name varchar(50),
	Description varchar(100),
	constraint pk_Category primary key (R_name,Name),
	constraint fk_Category foreign key (R_name) references Menu(Restaurant_name)
);

insert into Category values
('Sally''s','Appetizers',NULL),
('Sally''s', 'Sandwiches&Wraps','Servedwithkettlechips(unlessotherwisenoted)'),
('Sally''s','SaloonDailySpecials','SubjecttoChangeonEventDays.');

create table if not exists Upgrade (
	R_name varchar(50),
	Name varchar(50),
	Cost int,
	constraint pk_Upgrade primary key (R_name,Name),
	constraint fk_Upgrade foreign key (R_name) references Menu(Restaurant_name)
);

insert into Upgrade values
('Sally''s','Fries',2),
('Sally''s','TaterTots',2),
('Sally''s','HouseSalad',3),
('Sally''s','CupofSoup',3),
('Sally''s','Chicken',1),
('Sally''s','Tacobeef',1);

create table if not exists Dish (
	R_name varchar(50),
	CategoryName varchar(50),
	Title varchar(50),
	Description varchar(50),
	Option varchar(50),
	constraint pk_Dish primary key (R_name,CategoryName,Title),
	constraint fk_Dish foreign key (R_name,CategoryName) references Category(R_name,Name)
);

insert into Dish values
('Sally''s','Appetizers','Sally''sWings','ovenbaked...bleucheese.',NULL),
('Sally''s','Appetizers','Nachos','cheese...friendly.',NULL),
('Sally''s','Sandwiches&Wraps','SmokedPorkSandwich','smoked...bun.',NULL),
('Sally''s','SaloonDailySpecials','StreetTacoTuesday',NULL,NULL);

create table if not exists DishPrice (
	R_name varchar(50),
	CategoryName varchar(50),
	DishTitle varchar(50),
	size varchar(20),
	cost int,
	constraint pk_DishPrice primary key (R_name,CategoryName,DishTitle,size),
	constraint fk_DishPrice foreign key (R_name,CategoryName,DishTitle) references Dish(R_name,CategoryName,Title)
);

insert into DishPrice values
	('Sally''s','Appetizers','Sally''sWings','6pc',7),
	('Sally''s','Appetizers','Sally''sWings','12pc',12),
	('Sally''s','Appetizers','Nachos','',12),
	('Sally''s','Sandwiches&Wraps','SmokedPorkSandwich','',10),
	('Sally''s','SaloonDailySpecials','StreetTacoTuesday','',5);

create table if not exists Special (
	R_name varchar(50),
	CategoryName varchar(50),
	DishTitle varchar(50),
	weekDay varchar(50),
	startTime varchar(50),
	endTime varchar(50),
	constraint pk_Special primary key (R_name,CategoryName,DishTitle),
	constraint fk_Special1 foreign key (R_name,CategoryName,DishTitle) references  Dish(R_name,CategoryName,Title),
	constraint fk_Special2 foreign key (R_name,CategoryName) references Category(R_name,Name)
);

insert into Special values
	('Sally''s','SaloonDailySpecials','StreetTacoTuesday','Tuesday','5pm','Midnight');

create table if not exists CategoryUpgrade (
	R_name varchar(50),
	CategoryName varchar(50),
	UpgradeName varchar(50),
	constraint pk_CategoryUpgrade primary key (R_name,CategoryName,UpgradeName),
	constraint fk_CategoryUpgrade1 foreign key (R_name,CategoryName) references Category(R_name,Name),
	constraint fk_CategoryUpgrade2 foreign key (R_name,CategoryName) references Upgrade(R_name,Name)
);

insert into CategoryUpgrade values
	('Sally''s','Sandwiches&Wraps','TaterTots'),
	('Sally''s','Sandwiches&Wraps','HouseSalad');

	create table if not exists DishUpgrade (
		R_name varchar(50),
		CategoryName varchar(50),
		UpgradeName varchar(50),
		DishTitle varchar(50),
		constraint pk_DishUpgrade primary key (R_name,CategoryName,UpgradeName,DishTitle),
		constraint fk_DishUpgrade1 foreign key (R_name,CategoryName,DishTable) references Dish(R_name,CategoryName,Title),
		constraint fk_DishUpgrade2 foreign key (R_name,UpgradeName) references Upgrade(R_name,Name)
	);

insert into DishUpgrade values
	('Sally''s','Appetizers','Nachos','Chicken'),
	('Sally''s','Appetizers','Nachos','Tacobeef');

select * from Menu;
select * from Category;
select * from Upgrade;
select * from DishPrice;
select * from Special;
select * from CategoryUpgrade;
select * from DishUpgrade;*/
