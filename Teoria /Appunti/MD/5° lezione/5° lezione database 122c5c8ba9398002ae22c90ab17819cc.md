# 5° lezione database

Due Date: October 16, 2024
Materia: Database
REVISIONATA : No
Status: Done

## GROUP-BY

È un comando che si utilizza quando si deve eseguire un raggruppamento.

Solitamente sono associati a funzioni di conteggio o somma come ad esempio **COUNT() o SUM() o AVG()**

Esempio: supponiamo di avere due entità **Clienti** e **Rappresentanti** e si vuole sapere quanti sono i clienti appartenenti ad un rappresentante in queto caso si deve eseguire un raggruppamento in quanto per ogni rappresentante si dovranno conteggiare tutti i clienti che ha fornito. In questi caso non si può inserire una condizione nel WHERE perché si deve eseguire un conteggio.  

Se nella query si hanno le parole per ogni solitamente si ha un raggruppamento. **Quando si utilizza questo comando bisogna prestare attenzione che nella SELECT ci sia lo stesso campo di cui si vuole effetaure il raggruppamento.** Ha la seguente sintassi:

```sql
SELECT campo

FROM nome tabella

WHERE condizione

GROUP BY campo
```

Si utilizza dopo il FROM se non si ha una condizione o dopo il WHERE se si ha una condizione esempio di raggruppamento con query nidificata.

## HAVING

![Screenshot 2024-11-06 at 14.25.30.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-11-06_at_14.25.30.png)

![Screenshot 2024-11-06 at 14.25.55.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-11-06_at_14.25.55.png)

Si utilizza per imporre una condizione sul raggruppamento. 

## Ordine di valutazione delle clausole

**1. WHERE
2. GROUP BY
3. HAVING**

## ORDER-BY

**La clausola ORDER BY ordina le righe
• ASC: ordine crescente, default
• DESC: ordine decrescente**

![Screenshot 2024-10-17 alle 14.31.02.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_14.31.02.png)

![Screenshot 2024-10-17 alle 14.31.17.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_14.31.17.png)

### Ordinamento tramite alias

![Screenshot 2024-10-17 alle 14.31.34.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_14.31.34.png)

### Ordinamento su colonne multiple

![Screenshot 2024-10-17 alle 14.44.05.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_14.44.05.png)

L’orodinamento può essere fatto anche con colonne che non sono nella target list

## JOIN in SQL

**è un comando che si utilizza per eseguire le congiunzioni ed ha la seguente sintassi.**

**SELECT specificare i campi**

**FROM 1° tabella**

**INNER JOIN tabella 2**

**ON tabella1.campo=tabella2.campo;**

esempio:

**SELECT Orders.OrderID, Customers.CustomerName**

**FROM Orders**

**INNER JOIN Customers**

**ON Orders.CustomerID = Customers.CustomerID;**

In questo caso si sta unendo la tabella Orders con la tabella Custumers

Sulla PK  **Orders.CustomerID**  nella 1° tabella e FK **Customers.CustomerID** sulla 2° tabella

**Esiste un altro modo per eseguire una congiunzione che è il seguente**:

**SELECT specificare i campi**

**FROM tabella1,tabella2 ,tabella n…**

**WHERE condizione di unione fra le due tabelle**

Esempio:

```sql
SELECT Data,Prezzo,Dipendente.Nome,Dipendente.Cognome

FROM Versamento,Azienda

WHERE (Azienda.Partita_iva=Versamento.Partita_iva)
```

In questo caso di stanno selezionando i campi               DataPrezzo,Dipendente.Nome,Dipendente.Cognome e si sta eseguendo la congiunzione tra Versamento e Azienda sulla PK Azienda.Partita_iva e sulla FK Versamento.Partita_iva

**La differnza tra 1° metodo e il 2° è che il 1° viene eseguito da tutti le tipologie di DB invece il 2° non viene eseguito in tutte le tipologie di DB**

**È preferibile utilizzare il 2° metodo quando si hanno più di 2 join**

## Prodotto cartesiano

Il prodotto cartesiano è ottenuto quando:

- Una condizione join è omessa
- Tutte le righe della prima tabella ammettono join con tutte le righe della seconda

Per evitare il prodotto cartesiano, includere sempre condizioni join valida nella clausola
WHERE.

### Esempio di prodotto cartesiano

![Screenshot 2024-10-17 alle 14.52.12.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_14.52.12.png)

### Esempio di NATURAL-JOIN

![Screenshot 2024-10-17 alle 14.53.33.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_14.53.33.png)

### Esempio di proiezione selezione e join

![Screenshot 2024-10-17 alle 14.54.19.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_14.54.19.png)

### Esempio di ridenominazione

![Screenshot 2024-10-17 alle 14.54.55.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_14.54.55.png)

### Esempio di una SELECT con il ridimensionamento del risultato

![image.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/image.png)

![Screenshot 2024-10-17 alle 14.56.49.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_14.56.49.png)

## **LEFT JOIN**

La LEFT JOIN unisce tuti i dati della tabella di sinistra con i dati corrispondenti della tabella di destra

Si utilizza ad esempio quando la query richiede di visualizzare tutti i reparti che  non hanno articoli. Le R e L JOIN danno l’opportunità di prendere da una delle 2 tabelle tutti i dati sia che hanno sia che non hanno corrispondenza. Si prederanno in questo caso specifici tutti i dati della 1° tabella di (destra) e solo i dati che hanno corrispondenza con la 1° tabella nella 2° ed ha la seguente sintassi:

**SELECT specificare i campi**

**FROM tabella1 (sinistra)**

**LEFT JOIN tabella2 (destra)**

**ON tabella1.campo (PK)=tabella2.campo(FK)**

## **RIGHT JOIN**

**SELECT specificare i campi**

**FROM tabella1 (destra)**

**LEFT JOIN tabella2 (sinistra)**

**ON tabella1.campo (PK)=tabella2.campo(FK)**

## **FULL JOIN/CROSS JOIN**

La **CROSS JOIN** ritorna tutti i record della 1° e della 2° tabella ha la seguente sintassi:

SELECT specificare i campi

FROM tabella1

**CROSS JOIN tabella2**

## **SELF JOIN**

La **SELF JOIN** è una congiunzione sui campi della  tabella stessa. Ha la seguente sintassi:

SELECT nome delle colonne

FROM tabella1 T1,tabella2 T2

WHERE condizione

# Unione, intersezione e differenza in SQL

## Union

La SELECT da sola non permette di fare unioni; serve un costrutto esplicito:

![Screenshot 2024-10-17 alle 15.13.34.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_15.13.34.png)

i duplicati vengono eliminati, per mantenerli bisogna
specificarlo `UNION ALL`

![Screenshot 2024-10-17 alle 15.14.47.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_15.14.47.png)

Quando si usa `UNION`  bisogna usare AS su i campi 

Si hanno le stesse regole per `INTERSECT [ALL]` e  `EXCEPT [ALL]`

# Operatori Aggregati

Nelle espressioni della target list possiamo avere anche espressioni che calcolano valori a
partire da insiemi di ennuple

SQL-2 prevede 5 possibili operatori di aggregamento:

1. conteggio `(COUNT)`
2. minimo `(MIN)`
3. massimo `(MAX)`
4. media `(AVG)`
5. somma  `(SUM)`

**Gli operatori di aggregazione NON sono rappresentabili in Algebra Relazionale**

**Operano su insiemi di righe per dare un risultato per gruppo**

![Screenshot 2024-10-17 alle 15.25.53.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_15.25.53.png)

![Screenshot 2024-10-17 alle 15.26.15.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_15.26.15.png)

## **AVG() e SUM()**

**Possono esere usati su dati numerici**

![Screenshot 2024-10-17 alle 15.27.14.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_15.27.14.png)

## MIN() MAX()

**Possono essere usati su qualsiasi tipo.**

![Screenshot 2024-10-17 alle 15.34.57.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_15.34.57.png)

## COUNT()

Ritorna il numero di righe di una tabella.

![Screenshot 2024-10-17 alle 15.36.18.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_15.36.18.png)

**Count(attributo) il numero di valori di un particolare attributo non null**

### Esempi uso COUNT()

![Screenshot 2024-10-17 alle 15.38.01.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_15.38.01.png)

![Screenshot 2024-10-17 alle 15.39.10.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_15.39.10.png)

![Screenshot 2024-10-17 alle 15.38.40.png](5%C2%B0%20lezione%20database%20122c5c8ba9398002ae22c90ab17819cc/Screenshot_2024-10-17_alle_15.38.40.png)

Se una colonna A contiene solo valori. nulli, **`MAX, MIN, AVG, SUM`** restituiscono NULL, mentre **`COUNT**` vale zero. **`AVG, SUM`** ignorano i valori nulli