# 4° lezione database

Due Date: October 14, 2024
Materia: Database
REVISIONATA : No
Status: Done

# Algoritmo di Query Optimization

## Equivalenza di espressioni

> Due espressioni sono equivalenti se producono lo stesso risultato qualunque sia l'istanza attuale della base di dati.
> 

L'equivalenza è importante in pratica perché i DBMS cercano di eseguire
espressioni equivalenti a quelle date, ma meno "costose".

## Push selection

$$
\sigma_{A = 10}(R_1 \Join R_2) = R_1 \Join \sigma_{A = 10}(R_2) \\ \text{questo si ha se A è attributo di}\space R_2
$$

Riduce in modo significativo la dimensione del risultato intermedio (e quindi il costo dell'operazione).

### Esempio query

***tutti i professori che hanno dato a Mario Rossi piu’ di 27.***

$$
\pi_{\text{Professore}} \left( \sigma_{\text{Nome = 'Mario Rossi'} \land \text{Voto >= 27}} (\text{STUDENTE} \Join ESAMI \Join CORSI) \right)

$$

$$
\pi_{\text{Professore}} \left(     \sigma_{\text{Nome = 'Mario Rossi'}} (\text{STUDENTE})     \bowtie \sigma_{\text{Voto > 27}} (\text{ESAME})     \bowtie \text{CORSO}\right)
$$

## Regole per la query optimization

> **Anticipare l’applicazione delle proiezioni e dellerestrizioni rispetto al prodotto (e quindi alle giunzioni), in modo da ridurre la dimensione delle tabelle a cui applicare il prodotto (e le giunzioni).**
> 

- **Raggruppamento di restrizioni**
    
    Questa regola permette di combinare due selezioni consecutive su una relazione in un'unica selezione con la congiunzione delle due condizioni.
    
    ![Screenshot 2024-10-14 alle 14.41.09.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_14.41.09.png)
    
- **Commutatività di σ e π**
    
    Se le condizioni della selezione riguardano attributi presenti anche nella proiezione, la selezione può essere eseguita prima della proiezione
    
    1. **Se tutti gli attributi su cui si esegue la selezione (X) sono contenuti negli attributi della proiezione (Y):**
    
    $$
    \sigma_{c_X} (\pi_Y (S)) = \pi_Y (\sigma_{c_X} (S)) \quad \text{se} \quad X \subseteq Y
    $$
    
    b**. Se gli attributi della selezione non sono contenuti in quelli della proiezione:**
    
    $$
    \pi_Y (\sigma_{c_X} (\pi_X (S))) = \pi_Y (\sigma_{c_X} (S)) \quad \text{se} \quad X \not\subseteq Y
    $$
    
- **Anticipazione di 𝜎 rispetto a ×.**
    
    La selezione può essere anticipata rispetto al prodotto cartesiano se la condizione della selezione coinvolge attributi presenti solo in una delle relazioni.
    
    1. Se la selezione riguarda solo gli attributi della prima relazione S:
    
    $$
    \sigma_{c_X} (S \times F) = \sigma_{c_X} (S) \times F \quad \text{se} \quad X \subseteq \text{att}(S)
    $$
    
    b. Se la selezione riguarda attributi delle due relazioni S e F:
    
    $$
    \sigma_{c_X \land c_Y} (S \times F) = \sigma_{c_X} (S) \times \sigma_{c_Y} (F) \quad \text{se} \quad X \subseteq \text{att}(S), Y \subseteq \text{att}(F)
    $$
    
- **Raggruppamento di proiezioni**
    
    Due proiezioni consecutive possono essere ridotte a una sola proiezione se la seconda proiezione è un sottoinsieme della prima.
    
    $$
    \pi_X (\pi_Y (S)) = \pi_X (S) \quad \text{se} \quad X \subseteq Y
    $$
    
- **Eliminazione di proiezioni superflue**
    
    Se la proiezione contiene tutti gli attributi della relazione, può essere eliminata poiché non apporta alcun cambiamento.
    
    $$
    \pi_X (S) = S \quad \text{se} \quad X = \text{att}(S)
    $$
    
- **Anticipazione della proiezione rispetto a ×**
    
    Le proiezioni possono essere anticipate rispetto al prodotto cartesiano per ridurre il numero di attributi coinvolti nel prodotto.
    
    $$
    \pi_{XY} (S \times F) = \pi_X (S) \times \pi_Y (F) \quad \text{se} \quad X \subseteq \text{att}(S) \text{ e } Y \subseteq \text{att}(F)
    $$
    

## Algoritmo per Anticipare la Selezione

1. **Anticipazione di $\sigma\space rispetto \space a\space \pi$:**

$$
\sigma_{c_X} \pi_Y (S) = \pi_Y \sigma_{c_X} (S)
$$

1. **Raggruppamento delle restrizioni:**

$$
\sigma_{c_X} \sigma_{c_Y} (S) = \sigma_{c_X \land c_Y} (S)
$$

1. Anticipazione dell'esecuzione di  $\sigma \space su\space \times$

$$
\sigma_{c_X} (S \times F) = \sigma_{c_X} (S) \times F \quad \text{se} \quad X \subseteq \text{att}(S)
$$

1. Eliminazione delle proiezioni superflue:
    
    $$
    \pi_X (S) = S \quad \text{se} \quad X = \text{att}(S)
    $$
    
2. Raggruppamento delle proiezioni:

$$
\pi_X \pi_Y (S) = \pi_X (S) \quad \text{se} \quad X \subseteq Y
$$

1. Anticipazione delle proiezioni rispetto al prodotto:

$$
\pi_Y \sigma_{c_X} \pi_X (S) = \pi_Y \sigma_{c_X} (S) \quad \text{se} \quad X \nsubseteq Y
$$

## Distributività

**La selezione e la proiezione si distribuiscono su unioni e differenze tra relazioni.**

- **Distribuzione della Selezione sull'Unione**
    
    $$
    \sigma_C (R_1 \cup R_2) = \sigma_C (R_1) \cup \sigma_C (R_2)
    $$
    
- **Distribuzione della Selezione sulla Differenza**
    
    $$
    \sigma_C (R_1 - R_2) = \sigma_C (R_1) - \sigma_C (R_2)
    $$
    
- **Distribuzione della Proiezione sull'Unione**
    
    $$
    \pi_X (R_1 \cup R_2) = \pi_X (R_1) \cup \pi_X (R_2)
    $$
    

# SQL Query Language

## SELECT

![Screenshot 2024-10-14 alle 15.24.18.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.24.18.png)

## Qual’è l’odine di esecuzione di una SELECT?

1. Considera il prodotto cartesiano tra le *tabelle* in ***Tabelle***

2. Fra queste seleziona solo le righe che soddisfano la ***Condizione***

3. Infine valuta le espressioni specificate nella target list ***Attributi***

La SELECT implementa gli operatori:

Ridenominazione

1.  Proiezione
2. Selezione 
3. Join

dell’algebra relazionale

![Screenshot 2024-10-14 alle 15.27.07.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.27.07.png)

Dove ***Tabella*** sta per una determinata relazione ed ***Attributo*** è uno degli attributi delle tabelle citate nella clausola **FROM**

## Semantica del SELECT

![Screenshot 2024-10-14 alle 15.28.29.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.28.29.png)

In algebra relazionale:

$$
\pi_{A_1, A_2, \ldots, A_n} (\sigma_C (R_1 \times R_2 \times \cdots \times R_m))
$$

### Esempio di una query in SQL

![Screenshot 2024-10-14 alle 15.31.18.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.31.18.png)

Conoscere l’indirizzo e il telefono di **Teo Verdi**

![Screenshot 2024-10-14 alle 15.32.18.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.32.18.png)

## Scrittura Comandi SQL

- **I comandi SQL non sono case sensitive.**
- **Possono essere distribuiti in una o più righe.**
- **Le parole chiave non possono essere abbreviate o spezzate in due linee.**
- **Le clausole sono usualmente inserite in linee separate.**

## Operatori aritmetici usati in SQL

![Screenshot 2024-10-14 alle 15.34.29.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.34.29.png)

### Esempi di Operatori aritmetici usati in SQL

![Screenshot 2024-10-14 alle 15.35.35.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.35.35.png)

## Alias delle colonne

- Rinominare il nome di una colonna
- Utile con dei calcoli
- Deve seguire immediatamente il nome di una
colonna; può essere usata opzionalmente la
parola chiave AS tra il nome della colonna e
l’alias
- Richiede doppio apice se l’alias ha degli spazi

### Esempio Uso Alias nelle colonne

![Screenshot 2024-10-14 alle 15.37.17.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.37.17.png)

## Alias nelle tabbelle

![Screenshot 2024-10-14 alle 15.38.15.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.38.15.png)

**Se i nomi degli attributi non sono univoci tra le tabelle si deve usare il nome della tabella nella
select!**

## Eliminazione delle righe duplicate

E’ consentito dall’uso della parola chiave **DISTINCT** nella clausola **SELECT**

![Screenshot 2024-10-14 alle 15.43.03.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.43.03.png)

### Esempio di DISTINCT

![Screenshot 2024-10-14 alle 15.43.42.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.43.42.png)

## La clausula WHERE

Limitare le righe

La clausola WHERE segue la clausola FROM

![Screenshot 2024-10-14 alle 15.45.28.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.45.28.png)

### Esempio di uso della clausola WHERE

![Screenshot 2024-10-14 alle 15.46.12.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.46.12.png)

## Predicati di confronto

![Screenshot 2024-10-14 alle 15.46.41.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.46.41.png)

### Esempio di uso dei predicati di confronto

![Screenshot 2024-10-14 alle 15.47.28.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.47.28.png)

![Screenshot 2024-10-14 alle 15.47.47.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.47.47.png)

- **BETWEEN AND**
    
    consente la selezione di righe con attributi in un particolare range.
    
    ![Screenshot 2024-10-14 alle 15.49.06.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.49.06.png)
    
    ![Screenshot 2024-10-14 alle 15.49.33.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.49.33.png)
    
- **IN**
    
    E’ usato per selezionare righe che hanno un attributo che assume valori contenuti
    in una lista.
    
    ![Screenshot 2024-10-14 alle 15.50.18.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_15.50.18.png)
    
- LIKE
    
    LIKE è usato per effettuare ricerche ***wildcard*** di una stringa di valori.
    
    Le condizioni di ricerca possono contenere sia letterali, caratteri o numeri.
    
    - % denota zero o più caratteri.
    - _ denota un carattere.
    
    ### Esempio di uso di LIKE
    
    ![Screenshot 2024-10-14 alle 16.11.08.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_16.11.08.png)
    
    **Il pattern-matching di caratteri può essere combinato.**
    
- IS NULL
    
    L’operatore **IS NULL** controlla l’esistenza di valori null
    
    Ha la seguente sintassi:
    
    ![Screenshot 2024-10-14 alle 16.15.22.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_16.15.22.png)
    
    ### Esempio di uso del contrutto IS [NOT] NULL
    
    ![Screenshot 2024-10-14 alle 16.16.16.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_16.16.16.png)
    
    ![Screenshot 2024-10-14 alle 16.17.10.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_16.17.10.png)
    
    ## Operatori Logici
    
    ![Screenshot 2024-10-14 alle 16.18.12.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_16.18.12.png)
    

### Esempio di uso degli operatori logici

- AND
    
    ![Screenshot 2024-10-14 alle 16.19.15.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_16.19.15.png)
    
- OR

![Screenshot 2024-10-14 alle 16.19.42.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_16.19.42.png)

- NOT

![Screenshot 2024-10-14 alle 16.20.15.png](4%C2%B0%20lezione%20database%2011fc5c8ba93980299579c4ce3b6f7ed2/Screenshot_2024-10-14_alle_16.20.15.png)