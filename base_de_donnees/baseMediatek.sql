SET FEEDBACK OFF
SET LINESIZE 150
SET PAGESIZE 40
SET AUTOCOMMIT ON;

PROMPT --> DEBUT DU SCRIPT

REM ** Requête SQL de création des tables **

DROP TABLE utilisateurs CASCADE CONSTRAINTS PURGE
/
DROP TABLE document CASCADE CONSTRAINTS PURGE
/
DROP SEQUENCE seqDocument
/

PROMPT CREATION DES TABLES ET SEQUENCES

CREATE SEQUENCE seqDocument MINVALUE 1 INCREMENT BY 1;

CREATE TABLE utilisateurs
(
Username VARCHAR2(25) NOT NULL,
Password VARCHAR2(25) NOT NULL,
Type INTEGER,
PRIMARY KEY (Username)
)
/

CREATE TABLE document
(
IdDoc INTEGER NOT NULL,
Titre VARCHAR(50) NOT NULL,
Auteur VARCHAR(50) NOT NULL,
Type INTEGER NOT NULL,
UsAbo VARCHAR(25) DEFAULT NULL,
PRIMARY KEY (IdDoc),
CONSTRAINT FK_IdAbo FOREIGN KEY (UsAbo) REFERENCES utilisateurs(Username)
)
/

PROMPT INSERTION DES DONNEES

INSERT INTO utilisateurs (username,password,Type) values('rezouane','123' , 1);
INSERT INTO utilisateurs (username,password, Type) values('rudy','123' , 1);

INSERT INTO utilisateurs (username,password,Type) values('rezouaneB','123' , 2);
INSERT INTO utilisateurs (username,password,Type) values('rudyB','123',2);

INSERT INTO document (IdDoc,Titre,Auteur,Type) values(seqDocument.NEXTVAL,'Le Horla','Maupassant',1);
INSERT INTO document (IdDoc,Titre,Auteur,Type) values(seqDocument.NEXTVAL,'Le Don Juan','Moliere',1);
INSERT INTO document (IdDoc,Titre,Auteur,Type) values(seqDocument.NEXTVAL,'Avengers Infinity War','Anthony Russo et Joe Russo',2);
INSERT INTO document (IdDoc,Titre,Auteur,Type) values(seqDocument.NEXTVAL,'Black Panther','Ryan Coogler',2);




