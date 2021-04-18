CREATE TABLE "Films" (
	"ID"	INTEGER NOT NULL UNIQUE,
	"title"	TEXT NOT NULL,
	"duration"	INTEGER,
	"age_rating"	INTEGER,
	PRIMARY KEY("ID")
);


CREATE TABLE "Languages" (
	"ID"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	PRIMARY KEY("ID" )
);


CREATE TABLE "Countries" (
	"ID"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	PRIMARY KEY("ID" )
);

CREATE TABLE "Genres" (
	"ID"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	PRIMARY KEY("ID" )
);

CREATE TABLE "People" (
	"ID"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"surname"	TEXT NOT NULL,
	PRIMARY KEY("ID" )
);

CREATE TABLE "Films_Genres" (
	"Film_ID"	INTEGER NOT NULL,
	"Genre_ID"	INTEGER NOT NULL,
	PRIMARY KEY("Film_ID","Genre_ID"),
	FOREIGN KEY("Film_ID") REFERENCES "Films"("ID"),
	FOREIGN KEY("Genre_ID") REFERENCES "Genres"("ID")
);



CREATE TABLE "People_Countries" (
	"Person_ID"	INTEGER NOT NULL,
	"Country_ID"	INTEGER NOT NULL,
	PRIMARY KEY("Person_ID","Country_ID"),
	FOREIGN KEY("Person_ID") REFERENCES "People"("ID"),
	FOREIGN KEY("Country_ID") REFERENCES "Countries"("ID")
);


CREATE TABLE "Films_Countries" (
	"Film_ID"	INTEGER NOT NULL,
	"Country_ID"	INTEGER NOT NULL,
	PRIMARY KEY("Film_ID","Country_ID"),
	FOREIGN KEY("Film_ID") REFERENCES "Films"("ID"),
	FOREIGN KEY("Country_ID") REFERENCES "Countries"("ID")
);


CREATE TABLE "Films_Languages" (
	"Film_ID"	INTEGER NOT NULL,
	"Language_ID"	INTEGER,
	"type"  CHAR(20),
	PRIMARY KEY("Film_ID","Language_ID"),
	FOREIGN KEY("Film_ID") REFERENCES "Films"("ID"),
	FOREIGN KEY("Language_ID") REFERENCES "Languages"("ID")
);



CREATE TABLE "Formats" (
	"ID"	INTEGER NOT NULL UNIQUE,
	"name"	 INTEGER,
	PRIMARY KEY("ID" )
);


CREATE TABLE "Constructors" (
	"ID"	INTEGER NOT NULL UNIQUE,
	"Film_ID"	INTEGER NOT NULL,
	"Format_ID"	INTEGER NOT NULL,
	"Language_sub" INT,
	"Language_voice" INT,
	PRIMARY KEY("ID" ),
	FOREIGN KEY("Film_ID") REFERENCES "Films"("ID"),
	FOREIGN KEY("Format_ID") REFERENCES "Formats"("ID"),
	FOREIGN KEY("Language_voice") REFERENCES "Languages"("ID"),
	FOREIGN KEY("Language_sub") REFERENCES "Languages"("ID")
	
	
);






CREATE TABLE "Motion_picture_companies" (
	"ID"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	PRIMARY KEY("ID" )
);


CREATE TABLE "Films_Motion_picture_companies" (
	"Film_ID"	INTEGER NOT NULL,
	"Motion_picture_company_ID"	INTEGER NOT NULL,
	PRIMARY KEY("Film_ID","Motion_picture_company_ID"),
	FOREIGN KEY("Film_ID") REFERENCES "Films"("ID"),
	FOREIGN KEY("Motion_picture_company_ID") REFERENCES "Motion_picture_companies"("ID")
);

CREATE TABLE "Films_Formats" (
	"Film_ID"	INTEGER NOT NULL,
	"Format_ID"	INTEGER NOT NULL,
	PRIMARY KEY("Film_ID","Format_ID"),
	FOREIGN KEY("Film_ID") REFERENCES "Films"("ID"),
	FOREIGN KEY("Format_ID") REFERENCES "Formats"("ID")
);

CREATE TABLE "Jobs" (
	"ID"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	PRIMARY KEY("ID" )
);


CREATE TABLE "People_Films_Job" (
	"Person_ID"	INTEGER NOT NULL,
	"Film_ID"	INTEGER NOT NULL,
	"Job_ID"	INTEGER NOT NULL,
	PRIMARY KEY("Person_ID","Film_ID","Job_ID"),
	FOREIGN KEY("Film_ID") REFERENCES "Films"("ID"),
	FOREIGN KEY("Person_ID") REFERENCES "People"("ID")
);









CREATE TABLE "Addresses"
( "ID" INT NOT NULL UNIQUE,
  "District" TEXT NOT NULL,
  "City" TEXT NOT NULL, 
  "Street" TEXT NOT NULL,
  "House" INT NOT NULL,
  "Building" INT,
  "Korpus" TEXT , 
  "Office" INT,
  PRIMARY KEY("ID" )

);

CREATE TABLE "Cinemas"
( "ID" INT NOT NULL UNIQUE,
  "TIN" INT UNIQUE,
  "Adress_ID" INT NOT NULL ,
  PRIMARY KEY("ID" ),
  FOREIGN KEY("Adress_ID") REFERENCES "Addresses"("ID")

);

CREATE TABLE "Halls"
( "RoomNumber" INT NOT NULL ,
  "Cinema_ID" INT NOT NULL ,
  PRIMARY KEY("RoomNumber", "Cinema_ID"),
  FOREIGN KEY("Cinema_ID") REFERENCES "Cinemas"("ID")
 
);

CREATE TABLE "Format_Hall"
( "RoomNumber" INT NOT NULL ,
  "Format_ID" INT NOT NULL ,
  "Cinema_ID" INT NOT NULL ,
  PRIMARY KEY("RoomNumber", "Format_ID", "Cinema_ID"),
  FOREIGN KEY("Format_ID") REFERENCES "Formats"("ID"),
  FOREIGN KEY("RoomNumber","Cinema_ID") REFERENCES "Halls"("RoomNumber","Cinema_ID")
 
);




CREATE TABLE "FilmSessions"
( "ID" INT NOT NULL UNIQUE,
  "StartDate" DATE ,
  "StartTime" TIME , 
  "Duration" TIME  ,
  "RemainingChairs" INT ,
  "Constructor_ID"  INT NOT NULL ,
  "RoomNumber"  INT NOT NULL,
  "Cinema_ID"  INT NOT NULL,
  "Price"  INT NOT NULL,
  "NumberPoints"  INT NOT NULL,
  

  PRIMARY KEY("ID" ),
  FOREIGN KEY("Constructor_ID") REFERENCES "Constructors"("ID"),
  FOREIGN KEY("RoomNumber","Cinema_ID") REFERENCES "Halls"("RoomNumber","Cinema_ID"),
  


);


CREATE TABLE "Chairs"
( "Number" INT CHECK(Number>0),
  "Line" INT CHECK(Line>0), 
  "RoomNumber" INT NOT NULL,
  "Cinema_ID"  INT NOT NULL,
  "Status" BIT,
  PRIMARY KEY("Number","Line","RoomNumber","Cinema_ID"),
  FOREIGN KEY("RoomNumber","Cinema_ID") REFERENCES "Halls"("RoomNumber","Cinema_ID"),
  

);



CREATE TABLE "Tickets"
( "ID" INT NOT NULL UNIQUE,
  "TStatus" BIT,
  "Number" INT NOT NULL ,
  "Line" INT NOT NULL ,
  "RoomNumber" INT NOT NULL ,
  "Cinema_ID"  INT NOT NULL,
  "FilmSession_ID" INT NOT NULL,
 
  PRIMARY KEY("ID" ),
  FOREIGN KEY("Number","Line","RoomNumber","Cinema_ID") REFERENCES "Chairs"("Number","Line","RoomNumber","Cinema_ID"),
  FOREIGN KEY("FilmSession_ID") REFERENCES "FilmSessions"("ID"),


);



CREATE TABLE "DiscountCards"
( "ID" INT NOT NULL UNIQUE,
  "DiscountPoints" INT CHECK(DiscountPoints>=0),
  PRIMARY KEY("ID")

);



CREATE TABLE "Clients"
( "ID" INT NOT NULL UNIQUE,
  "ClientName" TEXT NOT NULL ,
  "E-mail" CHAR(20) NOT NULL UNIQUE,
  "PhoneNumber" CHAR(12) NOT NULL UNIQUE,
  "DiscountCard_ID"  INT,
  PRIMARY KEY( "ID" ),
  FOREIGN KEY("DiscountCard_ID") REFERENCES "DiscountCards"("ID")


);
CREATE TABLE "Client_Ticket"
( "ClientID" INT NOT NULL,
  
  "Ticket_ID" INT NOT NULL,
  "StatusTime" TIME,
  "DiscountPayStatus" BIT,
  "PaidStatus" BIT,
  "CancellationStatus" BIT,
  PRIMARY KEY("ClientID","Ticket_ID" ),
  FOREIGN KEY("Ticket_ID") REFERENCES "Tickets"("ID"),
 FOREIGN KEY("ClientID") REFERENCES "Clients"( "ID")

);


