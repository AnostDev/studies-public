# Amen Amegnonan et Chriss Santi
## TP7: DBPedia


## 3 Requêtes sur les oeuvres DBPedia

- a: Sous classes

```sql
SELECT distinct ?subClasses
WHERE {
 ?r rdfs:subClassOf ?subClasses
}

```

- b: Titre du film

```sql
SELECT ?title
WHERE {
 ?r a <http://dbpedia.org/ontology/Work>;
 rdfs:label ?title.
 FILTER (xsd:string(?r)="http://dbpedia.org/resource/Armageddon_(1998_film)")
}
```
- c: Abstract
```sql
SELECT ?abstract
WHERE {
 ?r a <http://dbpedia.org/ontology/Work>;
 dbo:abstract ?abstract.
 FILTER (xsd:string(?r)="http://dbpedia.org/resource/Armageddon_(1998_film)")

}
```
- d
```sql
SELECT ?resume
WHERE {
 ?r a <http://dbpedia.org/ontology/Work>;
 dbo:abstract ?resume.
 FILTER langMatches( lang(?resume), "fr" )
}
```
- e: Producers

```sql
SELECT ?title ?producer
WHERE {
 ?r a <http://dbpedia.org/ontology/Work>;
 dbo:producer ?producer;
 rdfs:label ?title.
 FILTER ((xsd:string(?r)="http://dbpedia.org/resource/Armageddon_(1998_film)") && (langMatches( lang(?title), "FR" )))
}
```

- f

```sql
SELECT ?titre ?wiki
WHERE {
 ?r a <http://dbpedia.org/ontology/Work>;
 rdfs:label ?titre;
 foaf:isPrimaryTopicOf ?wiki.
 FILTER (xsd:string(?r)="http://dbpedia.org/resource/Armageddon_(1998_film)" && langMatches( lang(?titre), "fr" ))
}
```

- g: Acteur par ordre descendants

```SQL
SELECT ?actor
WHERE {
 ?r a <http://dbpedia.org/ontology/Work>;
 dbo:starring ?actor.
 FILTER (xsd:string(?r)="http://dbpedia.org/resource/Armageddon_(1998_film)") 
}
ORDER BY DESC(?actor)
```

- h: Lieu de naissance des acteurs

```sql
SELECT distinct ?actor ?birthPlace
WHERE {
 ?r a <http://dbpedia.org/ontology/Work>;
 dbo:starring ?actor.

 ?actor a <http://dbpedia.org/ontology/Agent>;
 dbo:birthPlace ?birthPlace.

 FILTER (xsd:string(?r)="http://dbpedia.org/resource/Armageddon_(1998_film)") 
}
ORDER BY DESC(?actor)
```

- i:Déterminer le nombre d’acteurs nés avant 1956
```sql
SELECT Count(?actor) as ?acNumbBefore1956
WHERE {
 ?r a <http://dbpedia.org/ontology/Work>;
 dbo:starring ?actor.

 ?actor a <http://dbpedia.org/ontology/Agent>;
 dbo:birthYear ?birthYear.

 FILTER (xsd:string(?r)="http://dbpedia.org/resource/Armageddon_(1998_film)" && ?birthYear < xsd:date("1956")) 
}
```

- j: Acteur dans +50 films

```sql
SELECT ?actor COUNT(?film) as ?cFilms
where {
 ?film a <http://dbpedia.org/ontology/Work>;
 dbo:starring ?actor.
}
GROUP BY ?actor
HAVING (COUNT(?film) >= 50)
```

- k Acteurs nés à Paris ou à Marseille
```sql
SELECT ?actor
where {
 ?film a <http://dbpedia.org/ontology/Work>;
 dbo:starring ?actor.
 
 ?actor a <http://dbpedia.org/ontology/Agent>;
 dbo:birthPlace ?birthPlace.
}
```