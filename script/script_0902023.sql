CREATE DATABASE task;

CREATE SEQUENCE seqUser AS INT  ;

CREATE TYPE sex AS ENUM ('Homme','Femme');
CREATE TYPE etat AS ENUM ('Actif','Désactivé');
CREATE TYPE  role AS ENUM ('user','admin');

CREATE TABLE utilisateur (
    id INTEGER	PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    CIN VARCHAR(50),
    email VARCHAR(50),
    numero varchar(50),
    password varchar(100)
    );
Alter table utilisateur ADD sexe sex ;
Alter table utilisateur ADD status VARCHAR(50) ;

insert into utilisateur (id,nom,prenom,status) values (nextval('seqUser'),'Rakoto','Bema','Désactivé');
insert into utilisateur (id,nom,prenom,status) values (nextval('seqUser'),'Rakoto','Soa','Désactivé');
insert into utilisateur (id,nom,prenom,status) values (nextval('seqUser'),'Randria','Lita','Activé');


