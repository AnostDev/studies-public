```sql
SELECT ?r
WHERE {
    ?r a sao:streamEvent
}
```

- Select end time
```sql
SELECT distinct ?end_time
WHERE {
 ?r a sao:streamEvent.
 ?p tl:end ?end_time;
}
```

- Select start time
```sql
SELECT distinct ?start_time
WHERE {
 ?r a sao:streamEvent.
 ?p tl:start ?start_time;
}
```

- Select unit of mesurment
```sql
SELECT distinct ?unit
WHERE {
 ?r sao:hasUnitOfMeasurement unit0:?unit
}
```

- Select temps d'observation
```sql
SELECT distinct ?time
WHERE {
 ?r tl:at ?time
}
```

- Select latitude
```sql
SELECT  ?latitude
WHERE {
 ?r ct:hasLatitude ?latitude
}
```


- Select longitude
```sql
SELECT ?longitude
WHERE {
 ?r ct:hasLongitude ?longitude
}
```

- Select node name
```sql
SELECT ?node
WHERE {
 ?r ct:hasNodeName ?node
}
```


```sql
SELECT ?node
WHERE {
 ?r sao:value ?node
}
```

- All
```sql
SELECT distinct ?r ?unit ?time ?value ?t ?ref_time ?latitude
WHERE {
  ?r a sao:Point.
  ?r sao:hasUnitOfMeasurement ?unit.

  ?r ct:hasFirstNode ?longitude.
  ?longitude ct:hasLongitude ?t.

  ?r sao:value ?value.
  ?r sao:time ?ref_time.
  ?ref_time tl:at ?time;
}
```


```sql
SELECT distinct ?r ?unit ?time ?value ?ref_time ?longitude
WHERE {
  ?r a sao:Point.
  ?r sao:hasUnitOfMeasurement ?unit.

  ?r sao:value ?value.
     
  ?r sao:time ?ref_time.
  ?ref_time tl:at ?time.
  
  ?r ns1:featureOfInterest ?interest.
  ?interest a sao:FeatureOfInterest.
  
  ?r ct:hasFirstNode ?ref_pos.
  ?ref_pos ct:hasLongitude ?longitude.
  
            
}
Limit 20
```


SELECT distinct ?r ?interest ?unit ?time ?longitude ?latitude
WHERE {

  
  ?r ns1:featureOfInterest ?interest.
  ?interest ct:hasFirstNode ?ref_pos.
  ?ref_pos ct:hasLongitude ?longitude.
  ?ref_pos ct:hasLatitude ?latitude.

           
  ?r a sao:Point.
  ?r sao:hasUnitOfMeasurement ?unit.
  
            
}
Limit 20