Reuete 1
SELECT QUANTITE FROM Vente;

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 1694252626
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |  1000 | 13000 |     3   (0)| 00:00:01 |
|   1 |  TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |
---------------------------------------------------------------------------





Requete 2
SELECT DISTINCT QUANTITE FROM Vente;

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 17876439
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH UNIQUE       |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |
----------------------------------------------------------------------------

 



Requete 3
SELECT QUANTITE FROM Vente WHERE QUANTITE = 20;

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 1694252626
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |    41 |   533 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| VENTE |    41 |   533 |     3   (0)| 00:00:01 |
---------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------


Requete 4
SELECT QUANTITE FROM Vente WHERE QUANTITE = 60;

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 1694252626
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |     1 |    13 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| VENTE |     1 |    13 |     3   (0)| 00:00:01 |
---------------------------------------------------------------------------




Requete 5
SELECT QUANTITE FROM Vente WHERE PRIXVENTEUNITAIRE = 20;

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 497719442
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT                    |                |     1 |    26 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| VENTE          |     1 |    26 |     1   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | PRXVTEUNIT_IDX |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------------------




Requete 6
SELECT QUANTITE FROM Vente WHERE PRIXVENTEUNITAIRE = 60;

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 497719442
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT                    |                |     1 |    26 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| VENTE          |     1 |    26 |     1   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | PRXVTEUNIT_IDX |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------------------




Requete 7
SELECT QUANTITE FROM Vente WHERE QUANTITE > 20;

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 1694252626
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT  |       |     1 |    13 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| VENTE |     1 |    13 |     3   (0)| 00:00:01 |
---------------------------------------------------------------------------




Requete 8
SELECT QUANTITE FROM Vente WHERE PRIXVENTEUNITAIRE > 20;

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 497719442
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT                    |                |     1 |    26 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| VENTE          |     1 |    26 |     1   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | PRXVTEUNIT_IDX |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------------------




Requete 9
SELECT QUANTITE FROM Vente ORDER BY QUANTITE;

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 591658718
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  SORT ORDER BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |
----------------------------------------------------------------------------



Requete 10
SELECT QUANTITE FROM Vente ORDER BY PRIXVENTEUNITAIRE;

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 591658718
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   1 |  SORT ORDER BY     |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 26000 |     3   (0)| 00:00:01 |
----------------------------------------------------------------------------



Requete 11
SELECT COUNT( QUANTITE ) FROM Vente;

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 1236710848
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |     1 |     3   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE    |       |     1 |            |          |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------




Requete 12
SELECT COUNT( QUANTITE ) FROM Vente GROUP BY QUANTITE;

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 429762770
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |
----------------------------------------------------------------------------



Requete 13
SELECT QUANTITE, COUNT( QUANTITE ) FROM Vente GROUP BY QUANTITE;

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 429762770
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |
----------------------------------------------------------------------------




Requete 14
SELECT QUANTITE, COUNT( DISTINCT QUANTITE ) FROM Vente GROUP BY QUANTITE;

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 1406173386
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT    |           |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  VIEW               | VM_NWVW_1 |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   HASH GROUP BY     |           |  1000 | 13000 |     4  (25)| 00:00:01 |
|   3 |    TABLE ACCESS FULL| VENTE     |  1000 | 13000 |     3   (0)| 00:00:01 |
---------------------------------------------------------------------------------




Requete 15
SELECT QUANTITE, COUNT( PRIXVENTEUNITAIRE ) FROM Vente GROUP BY QUANTITE;

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 429762770
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |
----------------------------------------------------------------------------




Requete 16
SELECT QUANTITE, COUNT( DISTINCT PRIXVENTEUNITAIRE ) FROM Vente GROUP BY QUANTITE;

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 1608004274
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT     |           |  1000 | 26000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY       |           |  1000 | 26000 |     4  (25)| 00:00:01 |
|   2 |   VIEW               | VM_NWVW_1 |  1000 | 26000 |     4  (25)| 00:00:01 |
|   3 |    HASH GROUP BY     |           |  1000 | 26000 |     4  (25)| 00:00:01 |
|   4 |     TABLE ACCESS FULL| VENTE     |  1000 | 26000 |     3   (0)| 00:00:01 |
----------------------------------------------------------------------------------




Requete 17

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 429762770
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 13000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 13000 |     3   (0)| 00:00:01 |
----------------------------------------------------------------------------




Requete 18

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 1236710848
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |     1 |     3   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE    |       |     1 |            |          |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------




Requete 19

Explain Plan
-----------------------------------------------------------

PLAN_TABLE_OUTPUT                                                                                                                                                             ***
Plan hash value: 429762770
 
| Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
|-----|-------------------|-------|-------|-------|------------|----------|
|   0 | SELECT STATEMENT   |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |  1000 | 26000 |     4  (25)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| VENTE |  1000 | 26000 |     3   (0)| 00:00:01 |
----------------------------------------------------------------------------
 




