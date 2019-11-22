# TP 1: RDF
**Chriss Osler Santi & Amen Amegnonan**


## 1: Prise en main de l'outil LODLIVE

Le projet LodLive fournit un exemple de l'usage qui peut être fait des standards du web sémantique (RDF, SPARQL) pour parcourir librement les ressources RDF.

- Dataset choisi: `DBPedia`
- Mots recherché: `Mark Zuckerberg`
- Analyse: Lodlive nous a permit de construire un graphe d'informations sur notre recherche. De la racine (considérer comme source) `Mark Zuckerberg`, différentes possibilités nous sont offertes et chacune d'elle nous mène à une information en relation avec la source. En effet LodLive construit les information sur le format triplet `(Resource Predicat Resource)`.

Dans notre example, nous avons pu obtenir le graphe ![Marck Zuckerberg LodLive](https://raw.githubusercontent.com/AnostDev/images-test/master/mark-zuckerberg-lodlive.png)

## 2: RDF/XML



- a : correction.

```xml
<?xml version="1.0"?>
<rdf:RDF
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:ex="http://example.org/stuff/1.0/">
  <rdf:Description rdf:about="http://www.example.org/index.html">
    <ex:auteur rdf:resource= "http://www.example.org/auteur#John Smith"/>
    <ex:theme>langage RDF</ex:theme>
    <ex:duree>6h</ex:duree>
    <ex:parties>
      <rdf:Bag>
        <rdf:_1>Introduction</rdf:_1>
        <rdf:_2>syntaxe</rdf:_2>
        <rdf:_3>modèle</rdf:_3>
        <rdf:_4>données</rdf:_4>
      </rdf:Bag>
    </ex:parties>
  </rdf:Description>
</rdf:RDF>
```
- b\
Le tag `rdf:Bag` permet de declarer des resources qui ont une racines communes. C'est un tag de liste.


- c: Automatisation
```xml
<?xml version="1.0"?>
<rdf:RDF
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:ex="http://example.org/stuff/1.0/">
  <rdf:Description rdf:about="http://www.example.org/index.html">
    <ex:auteur rdf:resource= "http://www.example.org/auteur#John Smith"/>
    <ex:theme>langage RDF</ex:theme>
    <ex:duree>6h</ex:duree>
    <ex:parties>
      <rdf:Bag>
        <rdf:li>Introduction</rdf:li>
        <rdf:li>syntaxe</rdf:li>
        <rdf:li>modèle</rdf:li>
        <rdf:li>données</rdf:li>
      </rdf:Bag>
    </ex:parties>
  </rdf:Description>
</rdf:RDF>
```


exo 4:

Tim Berners-Lee a vu le jour le 8 juin 1955 à Londres, en Angleterre. Fils de Conway Berners-Lee et de Mary Lee Woods, il étudie la physique à l'Université d'Oxford de 1973 à 1976, année durant laquelle il obtient son diplôme. Il profite de ses années à l'Université d'Oxford pour fabriquer son premier ordinateur à partir d'un microprocesseur Motorola 6800 et d'une vieille télévision.

Il est père de deux enfants. 




## 3: Completer un rdf xml


### a: Completion

```xml
<?xml version="1.0"?>
<!-- Add the different namespaces-->
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:ex="http://example.org/stuff/1.0/"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
>

    <rdf:Description rdf:about="http://www.example.org/ex/webDonnees.html">

        <rdfs:DataType rdf:resource="example.org/Text" />
        <dc:creator rdf:resource="http://www.lsis.org/sellamis"/>
        <dc:subject rdf:resource="http://linkeddata.org"/>
        <dc:student rdf:resource="http://www.example.org/webDonnees.html/student/html/" />
        <dc:date>2018</dc:date>
        <dc:title>SPARQL Tutorial</dc:title>
        <dc:title>Exercises</dc:title>
    </rdf:Description>
      
    <rdf:Description rdf:about="http://www.example.org/webDonnees.html/student/html/">
        <dc:student rdf:resource="http://www.example.org/webDonnees.html/student/html/#MARC" />
    </rdf:Description> 

     <rdf:Description rdf:about="http://www.example.org/webDonnees.html/student/html/">
        <dc:student rdf:resource="http://www.example.org/webDonnees.html/student/html/#LAURIE" />
    </rdf:Description> 

     <rdf:Description rdf:about="http://www.example.org/webDonnees.html/student/html/">
        <dc:student rdf:resource="http://www.example.org/webDonnees.html/student/html/#JEAN" />
    </rdf:Description>

    <rdf:Description rdf:about="http://www.example.org/webDonnees.html/student/html/#MARC">
        <dc:score>12</dc:score>
    </rdf:Description>

    <rdf:Description rdf:about="http://www.example.org/webDonnees.html/student/html/#LAURIE">
        <dc:score>8</dc:score>
    </rdf:Description>

    <rdf:Description rdf:about="http://www.example.org/webDonnees.html/student/html/#JEAN">
        <dc:score>20</dc:score>
    </rdf:Description>

</rdf:RDF>
```

### b: utilisation de `base:` et `ID`


```xml
<?xml version="1.0"?>
<!-- Add the different namespaces-->
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:ex="http://example.org/stuff/1.0/"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xml:base="http://www.example.org/ex/webDonnees.html"
>

    <rdf:Description rdf:about="http://www.example.org/ex/webDonnees.html">

        <rdfs:DataType rdf:resource="example.org/Text" />
        <dc:creator rdf:resource="http://www.lsis.org/sellamis"/>
        <dc:subject rdf:resource="http://linkeddata.org"/>
        <dc:student rdf:resource="http://www.example.org/webDonnees.html/student/html/" />
        <dc:date>2018</dc:date>
        <dc:title>SPARQL Tutorial</dc:title>
        <dc:title>Exercises</dc:title>
    </rdf:Description>
      
    <rdf:Description rdf:about="http://www.example.org/webDonnees.html/student/html/">
        <dc:student  rdf:resource="http://www.example.org/webDonnees.html/student/html/#MARC" />
    </rdf:Description> 

     <rdf:Description rdf:about="http://www.example.org/webDonnees.html/student/html/">
        <dc:student  rdf:resource="http://www.example.org/webDonnees.html/student/html/#LAURIE" />
    </rdf:Description> 

     <rdf:Description rdf:about="http://www.example.org/webDonnees.html/student/html/">
        <dc:student  rdf:resource="http://www.example.org/webDonnees.html/student/html/#JEAN"/>
    </rdf:Description>

    <rdf:Description rdf:ID="MARC">
        <dc:score>12</dc:score>
    </rdf:Description>

    <rdf:Description rdf:ID="JEAN">
        <dc:score>8</dc:score>
    </rdf:Description>

    <rdf:Description rdf:ID="LAURIE">
        <dc:score>20</dc:score>
    </rdf:Description>

</rdf:RDF>
```


### c: conversion de xml/rdf vers turtle

```java
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix dc: <http://purl.org/dc/elements/1.1/> .

<http://www.example.org/ex/webDonnees.html>
  rdfs:DataType <http://njh.me/example.org/Text> ;
  dc:creator <http://www.lsis.org/sellamis> ;
  dc:subject <http://linkeddata.org> ;
  dc:student <http://www.example.org/webDonnees.html/student/html/> ;
  dc:date "2018" ;
  dc:title "SPARQL Tutorial", "Exercises" .

<http://www.example.org/webDonnees.html/student/html/> dc:student <http://www.example.org/webDonnees.html/student/html/#MARC>, <http://www.example.org/webDonnees.html/student/html/#LAURIE>, <http://www.example.org/webDonnees.html/student/html/#JEAN> .
<http://www.example.org/webDonnees.html/student/html/#MARC> dc:score "12" .
<http://www.example.org/webDonnees.html/student/html/#LAURIE> dc:score "8" .
<http://www.example.org/webDonnees.html/student/html/#JEAN> dc:score "20" .
```


## 5: rdf et html
Example d'insertion de tags rdf dans du html.

```html
<html>
<head>
	<title>RDFa: Tout le monde peut avoir une API</title>
	<meta name="author" content="Mark Birbeck" />
	<meta name="created" content="2009-05-09" />
	<link rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/" />
</head>
.
.
.
</html>
`