# 9° lezione database

Materia: Database
REVISIONATA : No
Status: Done

# Controllo d’accesso e transazioni

## Controllo dell'accesso

In SQL è possibile specificare chi (utente) e come (lettura,
scrittura, …) può utilizzare la base di dati (o parte di essa)

- Oggetto dei privilegi (diritti di accesso) sono di solito le tabelle, ma anche altri tipi di risorse, quali singoli attributi, viste o domini.
- Un utente predefinito _system (amministratore della base di dati) ha tutti i privilegi.
- Il creatore di una risorsa ha tutti i privilegi su di essa.

## Privilegi

Un privilegio è caratterizzato da:
**• la risorsa cui si riferisce
• l'utente che concede il privilegio
• l'utente che riceve il privilegio
• l'azione che viene permessa
• la trasmissibilità del privilegio**

## Tipi di privilegi offerti da SQL

- **insert:** permette di inserire nuovi oggetti (ennuple)
- **update:** permette di modificare il contenuto
- **delete:** permette di eliminare oggetti
- **select:** permette di leggere la risorsa
- **references:** permette la definizione di vincoli di integrità referenziale verso la risorsa (può limitare la possibilità di modificare la risorsa)
- **usage:** permette l'utilizzo in una definizione (per esempio, di un dominio)

## `grant e revoke`

In SQL, i comandi **GRANT** e **REVOKE** vengono utilizzati per gestire i privilegi di accesso alle risorse di un database. Questi comandi sono fondamentali per il controllo degli accessi e la sicurezza dei dati, poiché consentono agli amministratori di limitare o concedere l’accesso a tabelle, viste, procedure, e altre risorse del database a utenti specifici.

## **Concessione di Privilegi con `GRANT`**

Il comando `GRANT` permette di assegnare uno o più privilegi a uno o più utenti su specifiche risorse (come tabelle o viste) del database.

```sql
GRANT <privileges | ALL PRIVILEGES> ON risorsa TO utenti [WITH GRANT OPTION];
```

- **`<privileges>`**: Specifica uno o più privilegi da concedere, ad esempio `SELECT`, `INSERT`, `UPDATE`, `DELETE`, o `ALL PRIVILEGES` per concedere tutti i privilegi.
- **`risorsa`**: Specifica la risorsa su cui vengono concessi i privilegi (ad esempio, il nome di una tabella o vista).
- **`utenti`**: Specifica l’utente o gli utenti a cui vengono concessi i privilegi.
- **`WITH GRANT OPTION`**: Permette all’utente che riceve il privilegio di trasmetterlo a sua volta ad altri utenti.

### Esempio

```sql
GRANT SELECT ON Department TO Stefano;
```

All'utente **Stefano** viene concesso il privilegio di **SELECT** sulla tabella **Department**. Questo significa che Stefano può eseguire query `SELECT` per leggere i dati dalla tabella.

```sql
GRANT ALL PRIVILEGES ON Employee TO Anna WITH GRANT OPTION;
```

All’utente **Anna** vengono concessi **tutti i privilegi** sulla tabella **Employee**. Grazie a `WITH GRANT OPTION`, Anna può anche trasmettere questi privilegi ad altri utenti.

### 2. **Revoca di Privilegi con `REVOKE`**

Il comando `REVOKE` permette di rimuovere uno o più privilegi precedentemente concessi a uno o più utenti su una risorsa del database.

```sql
REVOKE privileges ON risorsa FROM utenti [RESTRICT | CASCADE];
```

- **`privileges`**: Specifica uno o più privilegi da revocare, come `SELECT`, `INSERT`, `UPDATE`, `DELETE`, ecc.
- **`risorsa`**: Indica la risorsa su cui vengono revocati i privilegi.
- **`utenti`**: Indica l’utente o gli utenti da cui vengono revocati i privilegi.
- **`RESTRICT`**: Impedisce la revoca se essa creerebbe dipendenze o problemi di autorizzazione per altri utenti. Se altri utenti dipendono dai privilegi concessi, la revoca con `RESTRICT` non sarà eseguita.
- **`CASCADE`**: Revoca i privilegi non solo per l'utente specificato, ma anche per tutti gli utenti a cui quest'ultimo li ha trasmessi. Questa opzione è utile per rimuovere in modo ricorsivo i privilegi trasmessi.

### Alcuni esempi

```sql
REVOKE SELECT ON Department FROM Stefano;
```

All'utente **Stefano** viene revocato il privilegio di **SELECT** sulla tabella **Department**. Dopo questa operazione, Stefano non potrà più eseguire query `SELECT` su quella tabella.

```sql
REVOKE ALL PRIVILEGES ON Employee FROM Anna CASCADE;
```

Tutti i privilegi che erano stati concessi ad **Anna** sulla tabella **Employee** vengono revocati. Con l'opzione `CASCADE`, i privilegi saranno rimossi anche per eventuali utenti a cui Anna li aveva trasmessi tramite `WITH GRANT OPTION`

## Le transazioni

La **transazione** è un insieme di operazioni che devono essere trattate come un’unica unità di lavoro, indivisibile e atomica. Questo significa che tutte le operazioni della transazione devono essere completate con successo, altrimenti nessuna delle operazioni viene mantenuta. Le transazioni sono fondamentali nei sistemi che necessitano di coerenza e integrità dei dati, specialmente nei database e nei sistemi concorrenti.

Le transazioni rispettano le proprietà ACID:

- **Atomicità**
- **Consistenza**
- **Isolamento**
- **Durabilità (persistenza)**

- **Atomicità**
    
    La transazione deve essere eseguita per intero o non essere eseguita affatto. Questa proprietà garantisce che le operazioni all'interno di una transazione non possano essere eseguite solo parzialmente.
    
    ### Esempio
    
    Se immaginiamo una transazione che trasferisce fondi dal conto A al conto B. Questa transazione include due operazioni: il prelievo di fondi dal conto A e il versamento di fondi sul conto B. Se uno dei due passaggi fallisce (ad esempio, se il prelievo da A ha successo ma il versamento su B fallisce), l'intera transazione deve essere annullata. In questo modo si evita che i fondi vengano sottratti dal conto A senza essere trasferiti sul conto B.
    
- **Consistenza**
    
    Al termine dell'esecuzione di una transazione, i vincoli di integrità devono essere soddisfatti, garantendo che il sistema rimanga in uno stato valido. È possibile che, durante l'esecuzione della transazione, ci siano stati temporanei in cui i vincoli sono violati, ma alla fine della transazione questi stati intermedi non devono persistere.
    
    ### Esempio
    
    Durante il trasferimento di fondi, potrebbe verificarsi una situazione temporanea in cui i fondi sono stati prelevati dal conto A ma non ancora versati sul conto B. Tuttavia, al termine della transazione, i fondi devono essere presenti o su A o su B, ma non su nessuno dei due. Se la transazione non riesce a soddisfare questi vincoli alla fine, essa viene annullata ("abortita") e si torna allo stato iniziale.
    
- **Isolamento**
    
    Le transazioni devono essere isolate l'una dall'altra, in modo tale che il loro effetto risulti coerente anche in presenza di esecuzioni concorrenti. L'isolamento assicura che le transazioni eseguite contemporaneamente non interferiscano tra loro, come se ciascuna avvenisse separatamente.
    
- **Durabilità**
    
     Una volta che una transazione è stata completata con successo (committed), i suoi effetti sono permanenti. I risultati devono rimanere registrati in modo definitivo, anche in caso di guasti o interruzioni del sistema.
    
    ### Esempio
    
    Dopo un trasferimento di fondi completato correttamente, il saldo aggiornato dei conti coinvolti deve essere memorizzato in modo permanente nel sistema. Anche in caso di un’interruzione di corrente o di un guasto hardware subito dopo il commit, il risultato della transazione rimane salvato nel sistema.
    

## Transazioni in SQL

In SQL, le transazioni permettono di gestire una sequenza di operazioni in modo atomico, assicurando che vengano completate con successo o annullate se si verifica un errore.

- **Inizio della Transazione**
    - In molti sistemi SQL, una transazione inizia automaticamente al primo comando SQL eseguito dopo la connessione al database o alla conclusione di una transazione precedente.
    - Alcuni sistemi SQL offrono un comando opzionale `START TRANSACTION` (o `BEGIN TRANSACTION`) per iniziare una transazione in modo esplicito. Tuttavia, questo comando non è obbligatorio e potrebbe non essere supportato da tutti i sistemi
- **Conclusione della Transazione**
    
    Per terminare una transazione, si può scegliere tra due operazioni principali:
    
    - **Commit [WORK]**:
        - Il comando `COMMIT` finalizza tutte le operazioni eseguite all'interno della transazione corrente, rendendo i cambiamenti permanenti nel database.
        - Dopo un `COMMIT`, non è più possibile annullare le operazioni effettuate nella transazione.
        - Alcuni sistemi supportano l'opzione `[WORK]` (come `COMMIT WORK`), anche se è generalmente facoltativa e non cambia il funzionamento di `COMMIT`.
    - **Rollback [WORK]**:
        - Il comando `ROLLBACK` annulla tutte le operazioni eseguite dall'inizio della transazione corrente, riportando il database allo stato iniziale prima dell'inizio della transazione.
        - Come per `COMMIT`, alcuni sistemi supportano l'opzione `[WORK]`, ma è solo un’aggiunta facoltativa e non influisce sul comportamento del comando.
- **Modalità Autocommit**
    - In molti sistemi SQL, è disponibile la modalità **autocommit**, in cui ogni singolo comando SQL viene considerato automaticamente come una transazione autonoma. Ciò significa che ogni operazione viene automaticamente eseguita e salvata nel database senza la necessità di un `COMMIT` esplicito.
    
    ### Esempio
    
    Se la modalità autocommit è attiva, un’istruzione `INSERT` eseguirà immediatamente l’inserimento e confermerà i cambiamenti nel database, senza necessità di `COMMIT`.
    

### Esempio di una transazione in SQL

```sql
start transaction -- (opzionale)
update ContoCorrente
set Saldo = Saldo – 10
where NumeroConto = 12345 ;
update ContoCorrente
set Saldo = Saldo + 10
where NumeroConto = 55555 ;
commit work;
```

# Basi di dati attive

Le **basi di dati attive** sono database che includono **regole attive** (chiamate **trigger**) per rispondere automaticamente a determinate condizioni o eventi. Questi trigger consentono al database di eseguire azioni senza intervento manuale, rendendolo più dinamico e reattivo. Ecco una panoramica delle principali caratteristiche e dei contesti di utilizzo dei trigger in un database attivo.

## Il concetto di TRIGGER

## Paradigma Evento-Condizione-Azione (ECA)

- **Evento**: è l'elemento che attiva il processo. Può essere una modifica ai dati (come un `INSERT`, `UPDATE`, o `DELETE` in una tabella di database), oppure un evento di sistema, come un accesso o il logout di un utente.
- **Condizione**: è una verifica logica o controllo che determina se l'azione deve effettivamente essere eseguita. Se la condizione risulta vera, l'azione verrà eseguita; se è falsa, l'azione non sarà intrapresa.
- **Azione**: è l'insieme di operazioni da eseguire se l'evento si verifica e la condizione è soddisfatta. L'azione può includere modifiche ai dati, invio di notifiche, esecuzione di procedure, ecc.

Ogni trigger è caratterizzato da:

- **nome**
- **target (tabella controllata)**
- **modalità (before o after)**
- **evento (insert, delete o update)**
- **granularità (statement-level o row-level)**
- **alias dei valori o tabelle di transizione**
- **azione**
- **timestamp di creazione**

```sql
create trigger TriggerName
{ before | after }
{ insert | delete | update [of Column] } on
Table
[referencing
{[old_table [as] OldTableAlias]
[new_table [as] NewTableAlias] } |
{[old [row] [as] OldTupleName]
[new [row] [as] NewTupleName] }]
[for each { row | statement }]
[when Condition]
```

## Tipi di eventi

- **BEFORE**
    
    Il trigger viene attivato prima che l'evento (come una modifica al database) avvenga.
    
    I trigger "BEFORE" non possono modificare direttamente lo stato del database, ma possono influenzare i valori "new" a livello di riga (ad esempio, con l'istruzione `SET t.new = expr`).
    
    Questa modalità viene generalmente utilizzata quando si vuole verificare o modificare i dati prima che vengano effettivamente aggiornati nel database.
    
    ```sql
    create trigger LimitaAumenti
    before update of Salario on Impiegato
    for each row
    when (New.Salario > Old.Salario * 1.2)
    set New.Salario = Old.Salario * 1.2
    ```
    
- **AFTER**
    
    Il trigger viene attivato dopo che l'evento è stato completato.
    
    È la modalità più comune e viene utilizzata nella maggior parte delle applicazioni, poiché consente di eseguire operazioni subito dopo una modifica al database, come il logging o l'aggiornamento di altre tabelle.
    
    ```sql
    create trigger LimitaAumenti
    after update of Salario on Impiegato
    for each row
    when (New.Salario > Old.Salario * 1.2)
    UPDATE Impiegato SET Salario = Old.Salario * 1.2 WHERE Matricola = NEW.Matricola
    ```
    

## Granularità degli eventi

**Modalità statement-level (di default, opzione "for each statement")**

Il trigger viene attivato ed eseguito solo una volta per ogni comando (statement) che lo ha scatenato, indipendentemente dal numero di righe (tuple) che sono state modificate.

Questa modalità è in linea con il comportamento orientato agli insiemi di SQL.

**Modalità row-level (opzione "for each row")**

Il trigger viene attivato ed eseguito una volta per ogni riga (tupla) modificata.

Scrivere trigger in modalità row-level è generalmente più semplice, poiché consente di gestire singole righe in modo più preciso.

## **Clausola REFERENCING**

La clausola `REFERENCING` dipende dalla granularità del trigger:

- **Modalità row-level**:
    
    Quando il trigger è in modalità row-level, sono disponibili due variabili di transizione: `OLD` e `NEW`. Queste variabili rappresentano rispettivamente i valori precedenti e successivi di una riga (tupla) che è stata modificata.
    
- **Modalità statement-level**:
    
    Quando il trigger è in modalità statement-level, sono disponibili due tabelle di transizione: `OLD_TABLE` e `NEW_TABLE`. Queste tabelle contengono i valori precedenti e successivi di tutte le righe modificate dallo statement.
    

Inoltre:

- **`OLD` e `OLD_TABLE`** non sono presenti quando l'evento è un `INSERT`.
- **`NEW` e `NEW_TABLE`** non sono presenti quando l'evento è un `DELETE`.

### Esempi di trigger row-level

```sql
create trigger AccountMonitor
after update on Account for each row
when new.Total > old.Total
insert
into Payments values
(new.AccNumber,new.Total-old.Total)
```

### Esempio di trigger statement-level

```sql
create trigger FileDeletedInvoices
after delete on Invoice
referencing old_table as OldInvoiceSet
insert into DeletedInvoices
(select *
from OldInvoiceSet)
```

## Esecuzione di Trigger in conflitto

Quando vi sono più trigger associati allo stesso evento (in
conflitto) vengono eseguiti come segue:

- Per primi i BEFORE triggers (statement-level e row-level)
- Poi viene eseguita la modifica e verificati i vincoli di integrità
- Infine sono eseguiti gli AFTER triggers (row-level e statement level)

Quando vari trigger appartengono alla stessa categoria, l’ordine di esecuzione è definito in base al loro timestamp di creazione (i trigger più vecchi hanno priorità più alta)

## Modello di esecuzione ricorsivo dei trigger

- In SQL:1999, i trigger sono associati a un "Trigger Execution Context" (TEC).
- L'azione di un trigger può generare eventi che attivano altri trigger. Questi nuovi trigger verranno eseguiti all'interno di un nuovo TEC, separato da quello originario.
- Lo stato del TEC che ha attivato il trigger (TEC includente) viene salvato, mentre il TEC del trigger chiamato (TEC incluso) viene eseguito. Questo processo può avvenire in modo ricorsivo.
- Al termine dell'esecuzione di un TEC incluso, lo stato del TEC includente viene ripristinato e l'esecuzione prosegue da dove era stata interrotta.
- L'esecuzione termina correttamente quando si raggiunge uno "stato quiescente" (cioè uno stato stabile senza ulteriori trigger attivati).
- Se viene raggiunta una profondità di ricorsione troppo alta, si verifica un errore e l'esecuzione viene interrotta con un'eccezione di "non-terminazione".
- Se si verifica un errore o un'eccezione durante l'esecuzione di una sequenza di trigger attivati da un'istruzione iniziale, viene effettuato un rollback parziale dell'istruzione stessa.

## Trigger in Oracle

Si usa una sintassi differente: sono consentiti eventi multipli, non sono previste
variabili per le tabelle, i before trigger possono prevedere update, la condizione è
presente solo con trigger row-level, l’azione è un programma PL/SQL

```sql
create trigger TriggerName
{ before | after } event [, event [,event ]]
[[referencing
[old [row] [as] OldTupleName]
[new [row] [as] NewTupleName] ]
for each { row | statement } [when Condition]]
PL/SQLStatements
Event ::= { insert | delete | update [of Column] } on Table
```

## Conflitti tra i trigger in Oracle

Quando molti trigger sono associati allo stesso evento, ORACLE segue il
seguente schema:

- Per primi, i BEFORE statement-level trigger
- Poi, i BEFORE row-level trigger
- Poi viene eseguita la modifica e verificati i vincoli di integrità
- Poi, gli AFTER row-level trigger
- Infine, gli AFTER statement-level trigger
- Quando vari trigger apparttengono alla stessa categoria, l’ordine di
esecuzione è definito in base al loro timestamp di creazione (i trigger più
vecchi hanno priorità più alta)
- “Mutating table exception”: scatta se la catena di trigger attivati da un
before trigger T cerca di modifcare lo stato della tabella target di T

```sql
# Evento:  updateof QtyDisponibile in Magazzino
# Condizione: Quantità sotto soglia e mancanza ordini esterni
# Azione: insertof OrdiniEsterni
create trigger Riordino
after update of QtyDisponibile on Magazzino
for each row
when (new.QtyDisponibile < new.QtySoglia)
begin
	declare X number;
	select count(*) into X
		from OrdiniEsterni
		where Parte = new.Parte;
	if X = 0 then
		insert into OrdiniEsterni
		values(new.Parte,new.QtyRiordino,sysdate)
	end if;
end
```

## Proprietà formali dei trigger

È fondamentale garantire che l'interferenza tra i trigger, durante la loro attivazione, non causi comportamenti anomali nel sistema. Per assicurare il corretto funzionamento, esistono tre proprietà principali:

- **Terminazione**: Qualunque sia lo stato iniziale e la transazione, il sistema deve arrivare a uno stato finale (chiamato "stato quiescente"), evitando cicli infiniti o esecuzioni non complete.
- **Confluenza**: L'esecuzione dei trigger deve terminare sempre con uno stato finale unico, indipendentemente dall'ordine in cui i trigger vengono eseguiti. Questo garantisce che non ci siano risultati diversi a causa di una sequenza di esecuzione variabile.
- **Univoca osservabilità**: I trigger devono essere confluenti e produrre lo stesso effetto verso l'esterno, come ad esempio messaggi o azioni di visualizzazione, indipendentemente dall'ordine di esecuzione. In altre parole, l'utente osserva sempre lo stesso risultato, senza variazioni dovute all'ordine dei trigger.

La **terminazione** è la proprietà principale, poiché senza di essa il sistema potrebbe non terminare mai correttamente.

## Analisi della terminazione

Si usa una rappresentazione delle regole detta grafo di triggering:
• Un nodo per ogni trigger
• Un arco dal nodo ti al nodo tj se la esecuzione dell’azione di ti può attivare il trigger tj (ciò può essere dedotto con una semplice analisi sintattica)
• Se il grafo è aciclico, l’esecuzione termina
• Non possono esservi sequenze infinite di triggering
• Se il grafo ha cicli, esso può avere problemi di terminazione:
lo si capisce guandando i cicli uno per uno.

## Esempio con due trigger

```sql
#T1: 
create trigger AdjustContributions
after update of Salary on Employee
referencing new table as NewEmp
update Employee
set Contribution = Salary * 0.8
where RegNum in ( select RegNum
								  from NewEmp)

#T2: 
create trigger CheckBudgetThreshold
after update on Employee
referencing new_table as NewEmp1
when 50000 < ALL (select (Salary+Contribution)
from NewEmp1)
update Employee
set Salary = 0.9*Salary
```

Grafo di triggering corrispondente

![Screenshot 2024-11-08 at 11.29.08.png](9%C2%B0%20lezione%20database%20133c5c8ba93980c6b758df62a28d7dd5/Screenshot_2024-11-08_at_11.29.08.png)

Ci sono due cicli ma il sistema termina.
• Per renderlo non terminante basta cambiare il comparatore nella
condizione di T2 oppure moltiplicare per un fattore più grande di 1
nella azione di T2.

### Esempio di non terminazione

```sql
#T2’
#Esempio di non terminazione
create trigger CheckBudgetThreshold
after update on Employee
for each row
when New.Salary < 50000
update Employee
set Salary = 0.9*Salary
```

![Screenshot 2024-11-08 at 11.30.59.png](9%C2%B0%20lezione%20database%20133c5c8ba93980c6b758df62a28d7dd5/Screenshot_2024-11-08_at_11.30.59.png)

## Aspetti evoluti delle basi di dati attive

1. **Modalità di esecuzione dei trigger**:
    - **Immediata**: Il trigger viene eseguito immediatamente quando si verifica l'evento che lo attiva.
    - **Differita**: Il trigger viene eseguito dopo che l'operazione che lo ha attivato è stata completata.
    - **Distaccata**: Il trigger viene eseguito in un momento separato, lontano dall'evento che lo ha originato.
2. **Amministrazione delle regole**:
    - **Priorità**: È possibile assegnare una priorità ai trigger per determinare l'ordine di esecuzione quando più trigger vengono attivati dallo stesso evento.
    - **Gruppi**: I trigger possono essere organizzati in gruppi per una gestione più efficiente.
    - **Attivazione e disattivazione dinamica**: I trigger possono essere attivati o disattivati dinamicamente durante l'esecuzione, a seconda delle necessità.
3. **Clausola "Instead-of"**:
    - Questa clausola permette di sostituire l'azione di un'operazione (ad esempio, `INSERT`, `UPDATE`, `DELETE`) con l'esecuzione di un'azione definita dal trigger, anziché quella di default del database.
4. **Altri eventi**:
    - **Eventi di sistema**: Eventi generati dal sistema di gestione del database (DBMS), come modifiche strutturali.
    - **Eventi dell'utente**: Eventi generati dalle azioni degli utenti, come operazioni di lettura o scrittura.
    - **Eventi definiti dal sistema**: Eventi predefiniti che il DBMS riconosce, ma che non sono direttamente legati a operazioni utente.
5. **Eventi complessi e calcolo degli eventi**:
    - Gli eventi possono essere combinati in eventi complessi tramite logiche di calcolo. Questo permette di definire trigger più sofisticati che reagiscono a sequenze di eventi piuttosto che a singoli eventi.
6. **Stream Database**:
    - Una nuova categoria di sistemi di database che gestiscono flussi di dati in tempo reale (streaming). Questi database sono progettati per gestire e analizzare grandi volumi di dati che arrivano in modo continuo e veloce.

---

## Esempi

![Screenshot 2024-11-08 at 11.35.14.png](9%C2%B0%20lezione%20database%20133c5c8ba93980c6b758df62a28d7dd5/Screenshot_2024-11-08_at_11.35.14.png)

```sql
#1)
create trigger T1
after delete on DIPARTIMENTO
for each row
when (exists (select *
from IMPIEGATO
where DipNum=Old.DipNum))
udpade IMPIEGATO set DipNum = 99 where
DipNum=Old.DipNum
```

```sql
#2)
create trigger T2
after delete on DIPARTIMENTO
for each row
when (exist (select *
						from IMPIEGATO
						where DipNum=Old.DipNum))
delete from IMPIEGATO where DipNum=Old.DipNum
```

```sql
#3)
create trigger T3
after update of Salario on IMPIEGATO
for each row
declare x number;
begin
select Salary into x
from IMPIEGATO join DIPARTIMENTO on Nome = NomeManager
where DIPARTIMENTO.DipNum = New.DipNum
if new.Salario > x then
	update IMPIEGATO set Salario = x
	where Nome = New.Nome
end
```

```sql
#4)
create trigger T4
after update of Salario on IMPIEGATO
for each row
	declare x number;
	declare y number;
	declare l number;
begin
select avg(salario), count(*) into x, l
from IMPIEGATO
where DipNum=new.DipNum;
y=((x*l)-new.Salario+old.Salario)/l;
if (x>(y*1.03)) then
	update IMPIEGATO set Salario=old.Salario
	where DipNum=new.DipNum AND nome=new.nome;
end
```

```sql
create trigger T4
after update of Salario on IMPIEGATO
for each row
	declare x number;
	declare y number;
begin
select SUM(salario) into x
from IMPIEGATO
where DipNum=new.DipNum;
y=x-new.Salario+old.Salario;
if (x/y>1.03) then
	update IMPIEGATO set Salario=old.Salario
	where DipNum=new.DipNum AND nome=new.nome;
end
```