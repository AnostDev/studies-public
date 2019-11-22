
# TP 2 Amen Amegnonan (a16018927) et Chriss Santi (s15026324)
## 12 Octobre 2019

# Partie 1: Comprendre les Sessions et les commandes `Commit` et `Rollback`

## 1: Ouvrir deux sessions

## 2: Créer la table hotel

```sql
-- Create tables session 1
CREATE TABLE Hotel (
  NumH number primary key,
  NomH varchar2(255) default NULL,
  AdressH varchar2(255),
  TelephoneH varchar2(100) default NULL
);
```

## 3: Inserer des données dans la table hotel

```sql
-- Insert 5 rows in session 1
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (1,'Quail','Ilkeston','03 38 27 02 39');
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (2,'Cole','Morkhoven','04 52 05 03 97');
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (3,'Jakeem','Sint-Denijs','04 08 00 47 21');
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (4,'Unity','Picture Butte','07 38 36 03 36');
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (5,'Halla','Sooke','04 57 85 24 51');


-- view the data from session 1 & 2
SELECT * FROM Hotel;
```
Nous prevoyons que les modifications ne seront pas visibles dans la session 2

Apres avoir effectué un select sur la table hotel, nous remarquons effectivements que les deux sessions ont connnaissance des données.
Après

## 4: Faire un commit

```sql
-- Make a commit in session 1
commit
```
Cette commande enregistre les modifications effectuées sur le disque dur. De ce fait toute session active sur la base de données est en mésure de voir ces modifications.

## 5: Effectuer une requête LMD

```sql
-- Insert data from session 1
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (6,'Candace','Vigo','07 15 37 46 58');
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (7,'Brooke','Staßfurt','02 56 59 51 60');
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (8,'Madeson','Hijuelas','02 61 65 01 25');
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (9,'Chaney','Baltimore','08 60 92 37 62');
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (10,'Joseph','Qualicum Beach','08 64 61 42 76');
```

Les modifications apportées par les requêtes ci-dessus ne sont pas visibles des deux sessions. En effet les requêtes LMD sont executées en transaction, les modifications ne sont appliquées que quand la command `commit` est executée.

## 6: Créer la table chambre

```sql
-- Create table in session 1
CREATE TABLE Chambre (
  Numc number,
  NumH Number,
  NbPlaceC Number,
  EtageC Number,
  PrixC Number,
  PRIMARY KEY (Numc, NumH),
  
  CONSTRAINT FK_Chambre_Hotel Foreign KEY (NumH)
    REFERENCES
    Hotel(NumH)
);
```

La création de la table est visible des deux sessions.


## 7:

Non les modifications ne sont pas toutes connues par les deux sessions.
La création de la table est connue. Par contre les modifications LMD ne sont pas car il n'y a pas de `COMMIT`.

## 8: Insere des données dans la table Chambre et effectuer un commit

```sql
-- Insert from session 1
INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (1, 1, 2, 1, 75);
INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (2, 1, 2, 1, 75);

INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (3, 2, 4, 2, 200);
INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (4, 2, 2, 2, 95);

INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (5, 3, 1, 1, 65);
INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (6, 3, 1, 1, 65);

-- Commit in the session 1
Commit

-- Select from the session 1
SELECT * FROM Chambre;
```

## 9: Modifier le prix d'une même chambre dans les deux session avec des prix différents

```sql
-- Update room price session 1
UPDATE chambre
    SET PrixC = 100
    WHERE NumC = 1;

-- Update room price session 2
UPDATE chambre
    SET PrixC = 110
    WHERE NumC = 1;
```
La mise à jour du prix devrait passer dans les deux sessions, vu que chaque transaction est supposée s'effectuer dans son propre espace de travail.

Result: La modification dans la session 2, engendre un requête infinie. Contrairement à ce que nous avions pensé, la requête n'est pas passée dans la session 2. Cela s'explique par le verrouillage des resources par la session 1.

## 10: Effectuer un commit

```sql
-- Commit change in session 1
Commit
```

Le commit dans la session 1, à causer l'arrêt de la boucle infinie dans la session 2. Cela s'explique du fait que le `commit` à libérer la **verrou** dans la session 1, permettant à la session 2 d'executer à son tour ses requêtes.

```sql
SELECT * FROM Chambre;
```
    - Le prix est maintenant **100** dans **session 1**
    - Le prix est maintenant **110** dans **session 2**

## 11: Faire un commit dans la session 2

```sql
-- commit in the session 2
Commit
```

Cette commande devra enregistrer en disque dur les modifications de la session 2. Le prix de la chambre 1 devra donc être 110 pour toutes les sessions.

```sql
-- Select in the session 1
SELECT * FROM Chambre;
```
Effectivement cette commande montre que le prix de la chambre est 110, valeur de la session 2.


## 12: Utilisez un select

```sql
-- Session 1: Select chambre with nbPlace = 1
SELECT * FROM Chambre WHERE NbPlaceC = 1 FOR UPDATE;

-- Session2: Update chambre with nbplace = 1
UPDATE chambre
    SET PrixC = 70
    WHERE nbplacec = 1;
```
Analyse de la question 12

Nous nous attendons à ce que la commande `SELECT ... FOR UPDATE` bloquera les ressources qu'elle retournera, ne permettant donc aucune autre session (transaction) de modifier ces resources.

Effectivement, la commande `UPDATE` dans la session 2 reste en attente (boucle infinie).

## 13: Commit dans Session 2

```sql
-- Session 1
Commit
```

Après un commit dans la session 1, cela devra libérer les ressources qu'elle avait bloqué et donc permettre toute transaction qui étaient en attente de ces ressources de pouvoir s'effectuer.

Effectivement, la commande `commit` dans la session 1 à débloquée les ressources qu'elle avait boquée par `SELECT ... FOR UPDATE`. La modification des ressources dans la session 2, s'est exécuté.

La commande `SELECT * FROM Chambre` donne:

    - Le prix est maintenant **65** dans **session 1**
    - Le prix est maintenant **70** dans **session 2**
Cette différence de prix s'explique par le fait de l'incohérence du sgdbr.

## 14: Rendre le SGDBR cohérent

```sql
-- Session 1 & 2
Commit

-- verify from session 1 and 2
SELECT * FROM Chambre;
-- Retourne les mêmes valeures
```


## 15: Select ... For Update dans 1 and Insert dans 2

```sql
-- From session 1
SELECT * FROM Chambre FOR UPDATE;

-- From session 2
INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (7, 4, 2, 1, 80);
INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (8, 4, 2, 2, 70);
```

Attentes:

> La commande dans la  session 2 doit pouvoir s'effectuer car la commande de la session 1 ne bloque pas les ressource (non créées) que la session 2 demande.
Analyse:

>Effectivement la commande de la session 2 termine.

## 16: Faire commit

```sql
-- Session 1
Commit
```
Cette commande liberera les ressources précedemment bloquées par `SELECT ... FOR UPDATE` mais ne changera rien dans le SGDBR.

```sql

-- Select from Session 1 and Session 2
SELECT * FROM Chambre;
```
> La commande `SELECT` retourne **4 lignes** dans la session 1

> La commande `SELECT` retourne **6 lignes** dans la session 2


## 17: Rendre cohérent le SGDBR

```sql
-- Commit in session 1 & 2
Commit
```

```sql
-- Select from Session 1 and Session 2
SELECT * FROM Chambre;
```
> La commande `SELECT` retourne **6 lignes** dans la session 1

> La commande `SELECT` retourne **6 lignes** dans la session 2


## 18: Insert et créer un save_point

```sql
-- All from Session 1
INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (9, 5, 6, 1, 150);
SAVEPOINT chambre_9_save; 1
INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (10, 5, 6, 1, 150);
```

## 19: Ce que voient les deux sessions

```sql
-- Select from Session 1 and Session 2
SELECT * FROM Chambre;
```

Seule la session 1 voit les modifications.

## 20: 

```sql
-- Session 2
INSERT INTO Hotel (NumH,NomH,AdressH,TelephoneH) VALUES (7,'decal','Vigo','04 15 37 46 58');
commit;
SELECT * FROM Hotel;

-- Session 1
SELECT * FROM Hotel;
```
Attentes:
> Les modifications apportées par la session 2 doivent passer.

Effectivement les deux sessions voient les même modifications effectuées par la session 2.


## 21: Faites un ROLLBACK TO  Save_point

```sql
-- Session 1 & 2
SELECT * FROM Chambre;

-- Session 1 & 2
SELECT * FROM Hotel;
```

Attentes:
> Les modifications faites dans la session 2, doivent être visible après la commande `ROLLBACK` dans la session 1, car nous effectué un `COMMIT`.\
Dans la session 1, les modifications lmd faites avant le `ROLLBACK` doivent disparaittre, cependant, les modifications ayant été faites dans la session 2 suvi du `COMMIT` doivent être toujours visibles.

Resultast:
> Les résultats vérifient nos attentes.

## 22: Faites un `COMMIT`

```sql
-- Session 1
COMMIT;
```
Attentes:
> Le commit devra persiter les données (avant `ROLLBACK`) d'être visibles dans la session 2.

Resultats:
> Le SGDBR est cohérent. Les modifications effectuées avant `ROLLBAK` sont toutes visibles des deux sessions.


## 23:

```sql
-- Session 1

INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (11, 2, 1, 1, 70);

SAVEPOINT save_point_1;

INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (12, 3, 1, 1, 65); 

ROLLBACK TO save_point_1;

INSERT INTO Chambre (Numc,NumH,NbPlaceC,EtageC, PrixC) VALUES (13, 1, 1, 1, 70);

COMMIT;

```

# Partie 2: Les transaction et les niveau d'isolation, basiques

## 1: Lecture uniquement
```sql
-- Lecture uniquement pour la transaction courante
SET TRANSACTION  READ ONLY ;
```

## 2: Retour au mode par défaut

```sql
-- Session 1: 1ere methode
SET TRANSACTION READ WRITE;

-- Session 1: 2e methode
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
```

# Partie 3: Les transaction et les niveau d'isolation, expert

## 1: Lectures non-bloquantes par d'autres read ou write
```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
```
## 2: Lectures non blocantes par rien

```sql
-- Session 1: Lecture non bloquantes par rien
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITED;
```


## 3: Pas de lecture impropre

```sql
-- Session 1: Pas de lecture impropre
SET TRANSACTION ISOLATION LEVEL READ COMMITED;
```

## 4: Pas de perte de données

```sql
-- Session 1: Pas de perte de mise à jour
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ ;
```

## 5: Possibilité de lecture non reproductible
```sql
-- Session 1: Possibilité de lecture non reproductible
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
```

## 5: Possibilité de lignes fantômes
```sql
-- Session 1: Possibilité de lignes fantômes
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
```

# Partie 4: Empêcher les lectures non reproductibles

## 1: Read only transaction

Si la transacation ne modifie pas les données, alors un niveau `READ COMMITTED` est suffisant pour empêcher les lectures non repetables. Cependant nous conseillons un niveau plus stricte `REPEATABLE READ`.

## 2: Possibilité de modification
Dans le cas ou la transaction modifies des données, il est possible d'empêcher les lectures non reproductibles en mettant le niveau d'isolation de transation à `REPEATABLE READ`. Ce niveau strict nous assure qu'il n'y aura pas de lecture non reproductible.

# Partie 5: Empêcher les lignes fantômes.

## 1: Read only transaction

Uniquement le niveau `SERIALAZABLE` empêche la possibilité d'avoir des lignes fantômes.

## 2: Possbilité de modification
En mettant le niveau d'isolationà `SERIALIZABLE` nous nous assurons d'empêcher la présence des lignes fantômes.

#### Annexes
Suppression de tables

```sql
-- Supprimer la table Hotel
DROP TABLE Hotel PURGE;

-- Supprimer la table Chambre
DROP TABLE Hotel Chambre;

-- Supprimer la table PClient
DROP TABLE Hotel PClient;

-- Supprimer la table Reservation
DROP TABLE Hotel Reservation;

-- Supprimer la table Occupation
DROP TABLE Hotel Occupation;
```
