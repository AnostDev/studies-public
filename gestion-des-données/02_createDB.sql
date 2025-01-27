-- TD/TP
-- PRODUIT, CATEGORIE, MAGASIN, LIEU,VENTE.
--
-- PARTIE 1
--

----------
-- CREATE all tables for p1
----------
CREATE TABLE Lieu(
	IdL NUMBER PRIMARY KEY,
	NomLieu VARCHAR(30) NOT NULL,
	IdLrattach NUMBER,
	CONSTRAINT FK_Lieu_Lieu FOREIGN KEY( IdLrattach )
		REFERENCES Lieu( IdL ) );

--	
CREATE TABLE Magasin(
	IdM NUMBER PRIMARY KEY,
	Nom VARCHAR(30) NOT NULL,
	Type VARCHAR(30) NOT NULL,
	IdL NUMBER,
	CONSTRAINT FK_Magasin_Lieu FOREIGN KEY( IdL )
		REFERENCES Lieu( IdL ) );

--
CREATE TABLE Categorie(
	CodeCat NUMBER PRIMARY KEY,
	Designation VARCHAR(30) NOT NULL,
	CodeCatGen NUMBER,
	CONSTRAINT FK_Categorie_Categorie FOREIGN KEY ( CodeCatGen )
		REFERENCES Categorie( CodeCat ) );

--
CREATE TABLE Produit(
	IdP NUMBER PRIMARY KEY,
	Libelle VARCHAR(30) NOT NULL,
	PrixAchat NUMBER(5,2) NOT NULL,
	CodeCat NUMBER,
	CONSTRAINT FK_Produit_Categorie FOREIGN KEY ( CodeCat )
		REFERENCES Categorie( CodeCat ) );

--
CREATE TABLE Vente(
	IdP NUMBER,
	IdM NUMBER,
	DateV DATE NOT NULL,
	Quantite NUMBER NOT NULL,
	PrixVenteUnitaire NUMBER NOT NULL, -- Not in p2
	CONSTRAINT PK_Vente PRIMARY KEY (IdP, IdM, DateV ),
	CONSTRAINT FK_Vente_Produit FOREIGN KEY ( IdP )
		REFERENCES Produit( IdP ),
	CONSTRAINT FK_Vente_Magasin FOREIGN KEY ( IdM )
		REFERENCES Magasin( IdM ) );
