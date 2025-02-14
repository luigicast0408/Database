# 2° lezione dabase

Materia: Database
REVISIONATA : Yes
Status: Done

# **Operatori Derivati**

**Sono operatori utili che si possono esprimere in funzioni di quelli primitivi.**

- **Intersezione**
    
    Siano R ed S due relazioni dello stesso tipo
    
    $R \cap S = \{ t \mid t \in R \land t \in S \}$
    
     essa si può esprimere in funzione degli operatori primitivi:
    
    $R \cap S = R - (R - S)$
    
- **JOIN o Giunzione**
    
    È un’ operazione binaria perché agisce su due tabelle. In un buon database  le relazioni sono indipendenti fra di loro e non si ha una concentrazione di attributi in una sola tabella.
    
    Si possono congiungere due tabelle in modo non permanente  perché non si hanno tutti gli attributi in una tabella. Si utilizzano questi meccanismi quando si vogliono le informazioni di più tabelle contemporaneamente e la query richiede attributi che sono presenti in tabelle diverse e per tale motivo bisogna congiungerle. Quando si esegue una congiunzione  ci possono essere dei campi che sono uguali nelle due tabelle perché si ha una FK nella seconda tabella quindi una PK nella 1° , si prendono  i valori che in teoria dovrebbero corrispondere  si parla di natural join in temini di tipo. Si ha invece una JOIN esterna quando non corrispondono tutti i campi ma vengono presi ugualmente. 
    
    - **LEFT JOIN(sinistra)**: estrae tutti i valori della tabella a sinistra anche se non hanno corrispondenza nella tabella a destra;
    - **RIGHT JOIN(destra)**: estrae tutti i valori della tabella a destra anche se non hanno corrispondenza nella tabella di sinistra
    - **FULL JOIN** estrae sia i valori della tabella di destra che quelli della taella di sinistra anche se non si ha corrispondenza

La congiunzione si effetua tra due tabella quando i valori dei campi della prima e della 2 tabella sono in comune  . Si parla di **natural** join quando c’è coincedenza tra i record delle due tabelle e di Outher Join quando non c’è coincidenza

## Definizione formale di JOIN

Join (o giunzione) è l’operatore più importante dell’algebra relazionale. Il join è un'operazione binaria che si applica a due relazioni. La funzione del join è unire tuple logicamente collegate delle due relazioni in un'unica tupla. La relazione risultante   ha come schema l'insieme degli attributi di R ed S, mentre l'estensione viene espressa come il prodotto cartesiano di R ed S seguito dalla selezione delle tuple che soddisfano la condizione di join. Permette di combinare tuple da relazioni diverse basandosi sui valori degli attributi. Fondamentalmente abbiamo due tipi (più qualche variante): Natural-JOIN e Theta-JOIN.

## Definzione formale di Natural-JOIN

Sia R con attributi XY ed S con attributi YZ.   è una relazione di attributi XYZ costituita da tutte le n-uple t tali che  . Cioè le n-uple del risultato sono ottenute combinando le n-uple di R e S che hanno gli stessi valori negli attributi con lo stesso nome.

In presenza di due attributi uguali, viene rinominato l'attributo comune in una delle due relazioni e viene eliminata una delle colonne che risultano uguali. Nel natural-join, quindi, la condizione di join è implicita, e lo schema della relazione risultante è l'insieme degli attributi di R ed S meno uno degli attributi uguali.

![Screenshot 2024-10-07 alle 14.39.24.png](2%C2%B0%20lezione%20dabase%20118c5c8ba93980d39daafb696e05a28c/Screenshot_2024-10-07_alle_14.39.24.png)

![Screenshot 2024-10-07 alle 14.39.59.png](2%C2%B0%20lezione%20dabase%20118c5c8ba93980d39daafb696e05a28c/Screenshot_2024-10-07_alle_14.39.59.png)

![Screenshot 2024-10-07 alle 14.40.18.png](2%C2%B0%20lezione%20dabase%20118c5c8ba93980d39daafb696e05a28c/Screenshot_2024-10-07_alle_14.40.18.png)

![Screenshot 2024-10-07 alle 14.40.39.png](2%C2%B0%20lezione%20dabase%20118c5c8ba93980d39daafb696e05a28c/Screenshot_2024-10-07_alle_14.40.39.png)

## Theta-JOIN

Nel caso che il criterio di selezione delle tuple sia determinato da un operatore di confronto (<,>,=,ecc.) si può parlare di theta-join. È un’estensione del natural-join dove viene specificato un predicato per la selezione delle n-uple. Esso è un operatore derivato:

Un caso particolare del theta-join è l'**equi-join**, in cui si applica l'operatore di uguaglianza, quindi nella formula *F* è una congiunzione di uguaglianza.

![Screenshot 2024-10-07 alle 14.41.06.png](2%C2%B0%20lezione%20dabase%20118c5c8ba93980d39daafb696e05a28c/Screenshot_2024-10-07_alle_14.41.06.png)