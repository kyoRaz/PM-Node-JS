--manova encodage ana terminal // temporaire anaty onglet ouvert
chcp 65001

CREATE DATABASE task; 

--MIJERY encodage ana bdd
SELECT datname, pg_encoding_to_char(encoding) as encoding FROM pg_database ;

CREATE SEQUENCE seqTest AS INT  ;
SELECT nextval('seqTest');

-- config dbShema nextval('sequser'::regclass)
CREATE SEQUENCE seqUser AS INT  ;

CREATE TYPE sex AS ENUM ('Homme','Femme');
CREATE TYPE etat AS ENUM ('Actif','Désactivé');
CREATE TYPE  role AS ENUM ('user','admin');

--mamafa colonne
ALTER TABLE utilisateur DROP COLUMN status; 

-- List des enumerations;
select n.nspname as enum_schema,  
       t.typname as enum_name,  
       e.enumlabel as enum_value
from pg_type t 
   join pg_enum e on t.oid = e.enumtypid  
   join pg_catalog.pg_namespace n ON n.oid = t.typnamespace;

CREATE TABLE utilisateur (
    id INTEGER PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    CIN VARCHAR(50),
    email VARCHAR(50),
    numero varchar(50),
    password varchar(100),
    status VARCHAR(50)
    );
Alter table utilisateur ADD sexe sex ;

CREATE SEQUENCE seqTaskType AS INT  ;
CREATE TABLE TaskType (
  id INTEGER DEFAULT nextval('seqTaskType') PRIMARY KEY,
  nom VARCHAR(50)
);

CREATE SEQUENCE seqTask AS INT  ;

CREATE TABLE Task (
  id INTEGER DEFAULT nextval('seqTask') PRIMARY KEY,
  idType INTEGER,
  idUtilisateur INTEGER,
  libelle VARCHAR(50),
);

CREATE OR REPLACE VIEW  detailsTask
as select t.id ,t.libelle ,t.idtype ,t2.nom as type,t.idutilisateur,u.prenom as auteur from task t 
join tasktype t2 on t.idtype =t2.id 
join utilisateur u on t.idutilisateur =u.id ;

SELECT * from detailsTask ;

