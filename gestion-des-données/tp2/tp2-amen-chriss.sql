/*
TP 2 Amen et Chriss
07 Octobre 2019
*/

-- Create tables
DROP TABLE Hotel PURGE;

-- 2

-- TAble hotel
CREATE TABLE Hotel (
  NumH number primary key,
  NomH varchar2(255) default NULL,
  AdressH varchar2(255),
  TelephoneH varchar2(100) default NULL
);


----------


SELECT * FROM Hotel;

--3

INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (1,'Quail','Ilkeston','03 38 27 02 39');
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (2,'Cole','Morkhoven','04 52 05 03 97');
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (3,'Jakeem','Sint-Denijs','04 08 00 47 21');
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (4,'Unity','Picture Butte','07 38 36 03 36');
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (5,'Halla','Sooke','04 57 85 24 51');

-- 4
commit; 

-- 5
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (6,'Candace','Vigo','07 15 37 46 58');

INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (7,'Brooke','Staßfurt','02 56 59 51 60');
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (8,'Madeson','Hijuelas','02 61 65 01 25');
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (9,'Chaney','Baltimore','08 60 92 37 62');
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (10,'Joseph','Qualicum Beach','08 64 61 42 76');

-- 6


CREATE TABLE Chambre (
  Numc number primary key,
  NumH Number,
  NbPlaceC Number,
  EtageC Number,
  PrixC Number,
  CONSTRAINT FK_Chambre_Hotel Foreign KEY (NumH)
    REFERENCES
    Hotel(NumH)
);

SELECT table_name, owner FROM all_tables ORDER BY owner, table_name;


-- 7

-- 8

INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (1, 1, 2, 1, 75);
INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (2, 1, 2, 1, 75);

INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (3, 2, 4, 2, 200);
INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (4, 2, 2, 2, 95);

INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (5, 3, 1, 1, 65);
INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (6, 3, 1, 1, 65);


SELECT * FROM Chambre;
commit;

-- 9

UPDATE chambre
    SET PrixC = 100
    WHERE NumC = 1;
    
    
-- 10
Commit;

SELECT * FROM Chambre;

-- 11


--12

SELECT * FROM Chambre WHERE NbPlaceC = 1 FOR UPDATE;

-- 13

Commit;



SELECT * FROM Chambre FOR UPDATE;

-- 18

INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (9, 5, 6, 1, 150);

SAVEPOINT chambre_9_save;

INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (10, 5, 6, 1, 150);

SELECT * FROM Chambre;


SELECT * FROM Hotel;    


-- 24

/*
PClient( NumP, NomP, AdresseP, TelephoneP )
Reservation( NumR, NumP#, NumH#, DateA, DateP )
Occupation( NumP#, NumH#, NumC#, NumR# )

*/


DROP TABLE Chambre PURGE;

CREATE TABLE Chambre (
  NumC number,
  NumH Number,
  NbPlaceC Number,
  EtageC Number,
  PrixC Number,
  
  PRIMARY KEY (Numc, NumH),

  CONSTRAINT FK_Chambre_Hotel Foreign KEY (NumH)
    REFERENCES
    Hotel(NumH)
);

CREATE TABLE PClient (
  NumP number primary key,
  NomP varchar2(255) default NULL,
  AdresseP varchar2(255),
  TelephoneP varchar2(100) default NULL
);


CREATE TABLE Reservation (
    NumR number PRIMARY KEY,
    NumP number default NULL,
    NumH number,
    DateA DATE,
    DateP DATE,

    CONSTRAINT FK_Reservation FOREIGN KEY( NumR )
        REFERENCES Reservation( NumR ),
    CONSTRAINT FK_Client FOREIGN KEY( NumP )
        REFERENCES PClient( NumP ),
    CONSTRAINT FK_Hotel FOREIGN KEY( NumH )
        REFERENCES Hotel ( NumH )
);


CREATE TABLE Occupation (
    NumP number,
    NumH number,
    NumC number,
    NumR number,
           
    PRIMARY KEY ( NumP, NumH, NumC),
    
    CONSTRAINT FK_Client FOREIGN KEY( NumP )
        REFERENCES PClient( NumP ),
    CONSTRAINT FK_Hotel FOREIGN KEY( NumH )
        REFERENCES Hotel ( NumH ),
    CONSTRAINT FK_Chambre FOREIGN KEY( NumC )
        REFERENCES Chambre( NumC ),
    CONSTRAINT FK_Reservation FOREIGN KEY( NumR )
        REFERENCES Reservation( NumR )

);

DROP TABLE Occupation  Purge;

commit;






















