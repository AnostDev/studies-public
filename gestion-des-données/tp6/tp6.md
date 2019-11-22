# RDFS and SPARQL


## Questions:

- a: L'ensemble des triplets
```sql
SELECT distinct ?x ?y ?z
WHERE {
  ?x ?y ?z
}
```
85


-b 

# Q2
```sql
SELECT  distinct ?father
where {
  ?father h:hasChild ins:John.
  }	

SELECT  distinct ?father
where {
  ins:John h:hasFather ?father.
  }	
```

-c Nom du père de John
```sql

SELECT ?name
where { 
  ?person h:hasChild ins:John.
  ?person h:name ?name.
}
```

- d: Ami de David

```sql
SELECT ?amiDavid
WHERE {
    ins:David h:hasFriend ?amiDavid
}
```
- e: Mère et age de Lucas

```sql
SELECT ?lucasMother ?lucasAge
WHERE {
    ins:Lucas h:hasMother ?lucasMother.
    ins:Lucas h:Age ?lucasAge.
}
```

- f: Pointure

```sql
SELECT ?person ?sizeS
WHERE {
    ?person h:shoesize ?sizeS
}
```

- g: Personnes de moins de 18 ans

```sql
SELECT ?person ?age
WHERE {
    ?person h:age ?age;
    FILTER(xsd:integer(?age) < xsd:integer(18)).
}
```

- h Tous les hommes et femmes

```sql
SELECT ?man ?woman
  Where {
    ?man a h:Man.
    ?woman a h:Woman
  }
```

- i: hommes mariés et enfant

```sql
SELECT ?homme ?enfant
WHERE {
  ?homme h:hasSpouse ?spouse.
  ?homme h:hasChild ?enfant.
  ?homme a h:Man
}
```


- j: hommes mariés et maris des femmes

```sql
SELECT ?homme ?mari
WHERE {
  ?homme a h:Man.
  ?homme h:hasSpouse ?spouse.
  ?x a h:Woman.
  ?x h:hasSpouse ?mari.
}
```

- k: Les personnes ayant >= 2 enfants

```sql
SELECT ?person (count(?child) as ?childNumb)
WHERE {
  ?person h:hasChild ?child
}
GROUP BY ?person
HAVING (count(?child) >= 2)
```