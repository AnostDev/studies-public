# Amen Amegnonan & Chriss Santi
## Loaded data: 1000


NB: We made a mistake during the load of the file and loaded the x_1000 rows file instead of x_1000000 one. We plan to re-work on that issue. In fact, we noticed during while interpretating the results that there is no such a big difference between some request, when we expected there should be.
We recognized that this mistake of our, is due to the fact that we encounter many issues to connect to the remote server you provided. So we tried many other options including hosting our own oracle server on aws which lately succeed, but didn't allow us to analyse the x_100000 rows.


# Requete 1

```sql
SELECT QUANTITE FROM Vente;
```


| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |  1000 | 13000 |     3   (0)| 00:00:01 |
|   1 |  TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |


| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT     |         |  1000 | 13000 |     3   (0)| 00:00:01 |
|   1 |  INDEX FAST FULL SCAN| QTE_IDX |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |  1000 | 13000 |     3   (0)| 00:00:01 |
|   1 |  TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT     |         |  1000 | 13000 |     3   (0)| 00:00:01 |
|   1 |  INDEX FAST FULL SCAN| QTE_IDX |  1000 | 13000 |     3   (0)| 00:00:01 |

### Analyse

We notice that there is on difference on the cost of CPU and TIME in indexing a or b.\
However whent looking at the data on context 1 and 3, oracle used the index on quantity. That lack of difference is certainly due to the fact that there is no constraint on the index (we looked up at all the data).

---------


# Requete 2

```sql
SELECT DISTINCT QUANTITE FROM Vente;
```
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH UNIQUE       |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT      |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH UNIQUE          |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   INDEX FAST FULL SCAN| QTE_IDX |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH UNIQUE       |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT      |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH UNIQUE          |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   INDEX FAST FULL SCAN| QTE_IDX |  1000 | 13000 |     3   (0)| 00:00:01 |

### Analyse
Here we observe the same results as earlier. Because this request doesn't use the index on `PRIXVENTEUNITAIRE`, sql, optimized to not use this index, even knowing that there is an index in the 3rd context.

---------

# Requete 3

```sql
SELECT QUANTITE FROM Vente WHERE QUANTITE = 25;
```
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |    41 |   533 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| VENTE |    41 |   533 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT |         |    41 |   533 |     1   (0)| 00:00:01 |
|*  1 |  INDEX RANGE SCAN| QTE_IDX |    41 |   533 |     1   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |    41 |   533 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| VENTE |    41 |   533 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT |         |    41 |   533 |     1   (0)| 00:00:01 |
|*  1 |  INDEX RANGE SCAN| QTE_IDX |    41 |   533 |     1   (0)| 00:00:01 |

### Analyse

Now we start to have more complexes sql request. In this request, there is a logical constraint `WHERE QUANTITE = 20`. We clearly see that making such a statement result in a difference on the CPU usage on either there is an index on `QUANTITE`. In fact context 1 and 3 consume more cpus than context 2 and 4.

---------
# Requete 4

```sql
SELECT QUANTITE FROM Vente WHERE QUANTITE = 70;
```
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |     1 |    13 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| VENTE |     1 |    13 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT |         |     1 |    13 |     1   (0)| 00:00:01 |
|*  1 |  INDEX RANGE SCAN| QTE_IDX |     1 |    13 |     1   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |     1 |    13 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| VENTE |     1 |    13 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT |         |     1 |    13 |     1   (0)| 00:00:01 |
|*  1 |  INDEX RANGE SCAN| QTE_IDX |     1 |    13 |     1   (0)| 00:00:01 |

### Analyse

This request follows the same pattern as the one before, that's why we don't observe a difference in the cpu consumption. However, because the constraint `WHERE QUANTITE = 70` returns `false`, the number of rows is 1 for all the contexes.


---------
# Requete 5

```sql
SELECT QUANTITE FROM Vente WHERE PRIXVENTEUNITAIRE = 25;
```
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |     1 |    26 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| VENTE |     1 |    26 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |     1 |    26 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| VENTE |     1 |    26 |     3   (0)| 00:00:01 |


| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT                    |                |     1 |    26 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| VENTE          |     1 |    26 |     1   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | PRXVTEUNIT_IDX |     1 |       |     1   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT                    |                |     1 |    26 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| VENTE          |     1 |    26 |     1   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | PRXVTEUNIT_IDX |     1 |       |     1   (0)| 00:00:01 |

### Analyse

The use of indexes on both `QUANTITE` and `PRIXVENTEUNITAIRE` clearly has an impact on the speed of the request as we can see in the 3rd and 4th context.

---------
# Requete 6

```sql
SELECT QUANTITE FROM Vente WHERE PRIXVENTEUNITAIRE = 75;
```

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |     1 |    26 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| VENTE |     1 |    26 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |     1 |    26 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| VENTE |     1 |    26 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT                    |                |     1 |    26 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| VENTE          |     1 |    26 |     1   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | PRXVTEUNIT_IDX |     1 |       |     1   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT                    |                |     1 |    26 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| VENTE          |     1 |    26 |     1   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | PRXVTEUNIT_IDX |     1 |       |     1   (0)| 00:00:01 |


### Analyse

The use of indexes on both `QUANTITE` and `PRIXVENTEUNITAIRE` clearly has an impact on the speed of the request as we can see in the 3rd and 4th context.

---------




# Requete 7

```sql
SELECT QUANTITE FROM Vente WHERE QUANTITE > 25;
```

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |     1 |    13 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| VENTE |     1 |    13 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT |         |     1 |    13 |     1   (0)| 00:00:01 |
|*  1 |  INDEX RANGE SCAN| QTE_IDX |     1 |    13 |     1   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |     1 |    13 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| VENTE |     1 |    13 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT |         |     1 |    13 |     1   (0)| 00:00:01 |
|*  1 |  INDEX RANGE SCAN| QTE_IDX |     1 |    13 |     1   (0)| 00:00:01 |

### Analyse

---------

Here there is a difference in the cpu consumption, because using the index on `QUANTITE`, helps oracle optimize the request especially when dealing with the constraint `WHERE QUANTITE > 25`.


# Requete 8

```sql
SELECT QUANTITE FROM Vente WHERE PRIXVENTEUNITAIRE > 25;
```

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |     1 |    26 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| VENTE |     1 |    26 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |     1 |    26 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| VENTE |     1 |    26 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT                    |                |     1 |    26 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| VENTE          |     1 |    26 |     1   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | PRXVTEUNIT_IDX |     1 |       |     1   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT                    |                |     1 |    26 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| VENTE          |     1 |    26 |     1   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | PRXVTEUNIT_IDX |     1 |       |     1   (0)| 00:00:01 |


### Analyse

The use of indexes on both `QUANTITE` and `PRIXVENTEUNITAIRE` clearly has an impact on the speed of the request as we can see in the 3rd and 4th context.
---------


# Requete 9

```sql
SELECT QUANTITE FROM Vente ORDER BY QUANTITE;
```
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  SORT ORDER BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT      |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  SORT ORDER BY        |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   INDEX FAST FULL SCAN| QTE_IDX |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  SORT ORDER BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT      |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  SORT ORDER BY        |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   INDEX FAST FULL SCAN| QTE_IDX |  1000 | 13000 |     3   (0)| 00:00:01 |

### Analyse

The `ORDER BY QUANTITE` operation has a great impact on the speed of the request. As we saw in the class, oracle execute the `ORDER` operation as a standalone operation.

# Requete 9
```sql
SELECT QUANTITE FROM Vente ORDER BY PRIXVENTEUNITAIRE;
```

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   1 |  SORT ORDER BY     |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 26000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   1 |  SORT ORDER BY     |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 26000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   1 |  SORT ORDER BY     |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 26000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   1 |  SORT ORDER BY     |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 26000 |     3   (0)| 00:00:01 |

### Analyse 10
The `ORDER BY PRIXVENTEUNITAIRE` operation has a great impact on the speed of the request. As we saw in the class, oracle execute the `PRIXVENTEUNITAIRE` operation as a standalone operation.

---------

# Requete 11

```sql
SELECT COUNT( QUANTITE ) FROM Vente;
```
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |     1 |     3   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE    |       |     1 |            |          |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT      |         |     1 |     3   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE       |         |     1 |            |          |
|   2 |   INDEX FAST FULL SCAN| QTE_IDX |  1000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |     1 |     3   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE    |       |     1 |            |          |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT      |         |     1 |     3   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE       |         |     1 |            |          |
|   2 |   INDEX FAST FULL SCAN| QTE_IDX |  1000 |     3   (0)| 00:00:01 |

### Analyse

`COUNT` on an index is optimized by the sgdb (here oracle). The also see a that a `SORT AGGREFGATE` operation happened during the execution. This sort operation has been triggered by the `COUNT` operator.

---------

# Requete 12

```sql
SELECT COUNT( QUANTITE ) FROM Vente GROUP BY QUANTITE;
```

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT      |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY        |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   INDEX FAST FULL SCAN| QTE_IDX |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT      |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY        |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   INDEX FAST FULL SCAN| QTE_IDX |  1000 | 13000 |     3   (0)| 00:00:01 |

### Analyse

The `GROUP BY` operation makes uses of a bigger amount of cpu (here 25%), because it uses an hashing alogorithm to aggregate the data. This use of hashing algorithms allows oracle to fast access the data with the help of the index.

---------

# Requete 13

```sql
SELECT QUANTITE, COUNT( QUANTITE ) FROM Vente GROUP BY QUANTITE;
```

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT      |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY        |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   INDEX FAST FULL SCAN| QTE_IDX |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT      |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY        |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   INDEX FAST FULL SCAN| QTE_IDX |  1000 | 13000 |     3   (0)| 00:00:01 |

### Analyse

The `GROUP BY` operation makes uses of a bigger amount of cpu (here 25%), because it uses an hashing alogorithm to aggregate the data. This use of hashing algorithms allows oracle to fast access the data with the help of the index.
---------


# Requete 14

```sql
SELECT QUANTITE, COUNT( DISTINCT QUANTITE ) FROM Vente GROUP BY QUANTITE;
```
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT    |           |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  VIEW               | VM_NWVW_1 |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   HASH GROUP BY     |           |  1000 | 13000 |     4  (25)| 00:00:01 |
|   3 |    TABLE ACCESS FULL| VENTE     |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT       |           |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  VIEW                  | VM_NWVW_1 |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   HASH GROUP BY        |           |  1000 | 13000 |     4  (25)| 00:00:01 |
|   3 |    INDEX FAST FULL SCAN| QTE_IDX   |  1000 | 13000 |     3   (0)| 00:00:01 |

 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT    |           |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  VIEW               | VM_NWVW_1 |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   HASH GROUP BY     |           |  1000 | 13000 |     4  (25)| 00:00:01 |
|   3 |    TABLE ACCESS FULL| VENTE     |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT       |           |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  VIEW                  | VM_NWVW_1 |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   HASH GROUP BY        |           |  1000 | 13000 |     4  (25)| 00:00:01 |
|   3 |    INDEX FAST FULL SCAN| QTE_IDX   |  1000 | 13000 |     3   (0)| 00:00:01 |

### Analyse

Using `DISTINCT` makes the request more complex. In order to better optimize, oracle on the first hand created a view on the QUANTITY and then used that view to count and aggreate the data.
---------

# Requete 15

```sql
SELECT QUANTITE, COUNT( PRIXVENTEUNITAIRE ) FROM Vente GROUP BY QUANTITE;

```
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT      |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY        |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   INDEX FAST FULL SCAN| QTE_IDX |  1000 | 13000 |     3   (0)| 00:00:01 |

 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT      |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY        |         |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   INDEX FAST FULL SCAN| QTE_IDX |  1000 | 13000 |     3   (0)| 00:00:01 |


### Analyse

The `GROUP BY` operation makes uses of a bigger amount of cpu (here 25%), because it uses an hashing alogorithm to aggregate the data. This use of hashing algorithms allows oracle to fast access the data with the help of the index.
---------

# Requete 16

```sql
SELECT QUANTITE, COUNT( DISTINCT PRIXVENTEUNITAIRE ) FROM Vente GROUP BY QUANTITE;
```

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT     |           |  1000 | 26000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY       |           |  1000 | 26000 |     4  (25)| 00:00:01 |
|   2 |   VIEW               | VM_NWVW_1 |  1000 | 26000 |     4  (25)| 00:00:01 |
|   3 |    HASH GROUP BY     |           |  1000 | 26000 |     4  (25)| 00:00:01 |
|   4 |     TABLE ACCESS FULL| VENTE     |  1000 | 26000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT     |           |  1000 | 26000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY       |           |  1000 | 26000 |     4  (25)| 00:00:01 |
|   2 |   VIEW               | VM_NWVW_1 |  1000 | 26000 |     4  (25)| 00:00:01 |
|   3 |    HASH GROUP BY     |           |  1000 | 26000 |     4  (25)| 00:00:01 |
|   4 |     TABLE ACCESS FULL| VENTE     |  1000 | 26000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT     |           |  1000 | 26000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY       |           |  1000 | 26000 |     4  (25)| 00:00:01 |
|   2 |   VIEW               | VM_NWVW_1 |  1000 | 26000 |     4  (25)| 00:00:01 |
|   3 |    HASH GROUP BY     |           |  1000 | 26000 |     4  (25)| 00:00:01 |
|   4 |     TABLE ACCESS FULL| VENTE     |  1000 | 26000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT     |           |  1000 | 26000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY       |           |  1000 | 26000 |     4  (25)| 00:00:01 |
|   2 |   VIEW               | VM_NWVW_1 |  1000 | 26000 |     4  (25)| 00:00:01 |
|   3 |    HASH GROUP BY     |           |  1000 | 26000 |     4  (25)| 00:00:01 |
|   4 |     TABLE ACCESS FULL| VENTE     |  1000 | 26000 |     3   (0)| 00:00:01 |

### Analyse

The `DISTINCT` operator triggered oracle to create a view on the column `PRIXVENTEUNITAIRE`. However there is no use of any of the indexes we've created.

---------

# Requete 17

```sql
SELECT PRIXVENTEUNITAIRE, COUNT( QUANTITE ) FROM Vente GROUP BY PRIXVENTEUNITAIRE;
```

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |

### Analyse

A further analysis is needed to decipher why oracle dind't make use of the indexes.
---------


# Requete 18

```sql
SELECT COUNT( QUANTITE ), COUNT( PRIXVENTEUNITAIRE ) FROM Vente;
```

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |     1 |     3   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE    |       |     1 |            |          |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT      |         |     1 |     3   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE       |         |     1 |            |          |
|   2 |   INDEX FAST FULL SCAN| QTE_IDX |  1000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |     1 |     3   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE    |       |     1 |            |          |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT      |         |     1 |     3   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE       |         |     1 |            |          |
|   2 |   INDEX FAST FULL SCAN| QTE_IDX |  1000 |     3   (0)| 00:00:01 |

### Analyse
Oracle used only the index on `QUANTITY` because the `COUNT` already triggered the aggreation and the sort, which under the hood use complexes optimization.

---------

# Requete 19

```sql
SELECT COUNT( QUANTITE ), COUNT( PRIXVENTEUNITAIRE ) FROM Vente GROUP BY QUANTITE, PRIXVENTEUNITAIRE;
```

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 26000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 26000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 26000 |     3   (0)| 00:00:01 |

| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 26000 |     3   (0)| 00:00:01 |


### Analyse

A further analysis is needed to decipher why oracle dind't make use of the indexes.

---------
