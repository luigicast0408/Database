CREATE TABLE Azienda
(
    Partita_iva VARCHAR(10) NOT NULL PRIMARY KEY,
    Nome VARCHAR(10) NOT NULL,
    Indirizzo VARCHAR(10) NOT NULL,
    Settore VARCHAR(10) NOT NULL,
    Sede VARCHAR(10) NOT NULL
);


CREATE TABLE Dipendente
(
    Matricìola INT NOT NULL PRIMARY KEY,
    Nome VARCHAR(10) NOT NULL,
    Cognome VARCHAR(10) NOT NULL,
    Data_nascita DATE NOT NULL,
    Luogo_nascita VARCHAR(10) NOT NULL,
    Professione VARCHAR(10) NOT NULL,
    Reddito_annuo FLOAT NOT NULL,
    Email VARCHAR(10) NOT NULL,
    Trattenute FLOAT NOT NULL,
    N_familiari INT NOT NULL
);

CREATE TABLE Versamento
(
    Id_versamento VARCHAR(10) NOT NULL PRIMARY KEY,
    Partita_iva VARCHAR(11) NOT NULL,FOREIGN KEY(Partita_iva)
        REFERENCES Azienda(Partita_iva),
    Prezzo FLOAT NOT NULL,
    Data DATETIME NOT NULL,
    Matricola INT NOT NULL,FOREIGN KEY (Matricola)
        REFERENCES Dipendente(Matricola)

);

#1. Elenco dei dipendenti con matricola, cognome, nome, professione e reddito lordo.
SELECT Matricola,Cognome,Nome,Professione,Reddito_annuo
FROM Dipendente;

#2.Denominazione e indirizzo dell’azienda avente un codice prefissato.
SELECT Nome,Indirizzo
FROM Azienda
WHERE Partita_iva='1111111';

#3. Cognome e nome dei dipendenti che hanno un reddito superiore a una cifra prefissata.
SELECT Cognome,Nome
FROM Dipendente
WHERE Reddito_annuo>3000;

#4. Denominazione e indirizzo delle aziende che hanno la sede in un Comune prefissato.
SELECT Nome,Indirizzo
FROM Azienda
WHERE Sede='MASCALI';

#5. Cognome, nome, professione, reddito, per i dipendenti che svolgono una determinata professione e
# hanno il reddito inferiore a un valore prefissato.
SELECT Cognome,Nome,Professione,Reddito_annuo
FROM Dipendente
WHERE Professione='Operaio' AND Reddito_annuo<7000;

#6.Denominazione e indirizzo delle aziende che hanno la sede in un Comune prefissato.
SELECT Nome,Indirizzo
FROM Azienda
WHERE Azienda.Indirizzo='catania';

#7. Lista delle differenti professioni presenti in un’azienda di cui si conosce il codice.
SELECT DISTINCT  Professione
FROM Dipendente,Azienda,Versamento
WHERE (Dipendente.Matricola=Versamento.Matricola) AND (Versamento.Partita_iva=Azienda.Partita_iva) AND Azienda.Partita_iva='ciao';

#8.Cognome e nome dei dipendenti di una determinata azienda che svolgono una professione prefissata.
SELECT Cognome,Dipendente.Nome
FROM Dipendente,Azienda,Versamento
WHERE (Dipendente.Matricola=Versamento.Matricola) AND (Versamento.Partita_iva=Azienda.Partita_iva)AND Azienda.Nome='ciao' AND Professione='ingegnere';

#9.Lista delle professioni, con eliminazione dei duplicati, per le quali i redditi sono superiori a un valore prefissato.
SELECT DISTINCT Professione
FROM Dipendente
WHERE Reddito_annuo>1000;

#10.Elenco dei versamenti, con data e importo, effettuati per i dipendenti di una determinata azienda.
SELECT Data,Prezzo,Dipendente.Nome,Dipendente.Cognome
FROM Versamento,Azienda,Dipendente
WHERE (Azienda.Partita_iva=Versamento.Partita_iva) AND(Dipendente.Matricola=Versamento.Matricola) AND Azienda.Nome='meditech';

# 11.Ammontare dell’imposta lorda, calcolata sul reddito secondo una percentuale prefissata, per tutti i
# dipendenti che svolgono una determinata professione.
SELECT Reddito_annuo
FROM Dipendente
WHERE ((Reddito_annuo*40)/100) AND Dipendente.Professione='Insegnante';

#12.Elenco dei dipendenti di un’azienda prefissata con cognome, nome, reddito lordo, somma dei versamenti di imposta.
SELECT SUM((Dipendente.Reddito_annuo*40)/100)AS tot_versamenti_dipendenti
FROM Dipendente,Versamento,Azienda
WHERE (Azienda.Partita_iva=Versamento.Partita_iva)AND(Dipendente.Matricola=Versamento.Matricola);

#13.Cognome, nome e professione dei dipendenti che hanno il reddito compreso tra due cifre prefissate.
SELECT Cognome,Nome,Professione
FROM  Dipendente
WHERE Reddito_annuo BETWEEN 2000 AND 3000;

#Numero dei dipendenti che lavorano in un’azienda di cui si conosce la denominazione.
SELECT COUNT(*) AS N_dipendenti
FROM Dipendente AS D,Azienda AS A,Versamento AS V
WHERE D.Partita_iva=A.Partita_iva
  AND A.Partita_iva=V.Partita_iva
  AND A.Nome='cisco';

SELECT MIN(Reddito_annuo) AS R_min, MAX(Reddito_annuo) AS R_max
FROM Dipendente;

SELECT AVG(Reddito_annuo) AS reddito_medio
FROM Dipendente
WHERE Professione='programmatore';

SELECT SUM(Prezzo) AS somma_versamenti
FROM Versamento,Azienda
WHERE Azienda.Partita_iva='000';

SELECT Dipendente.Cognome,Dipendente.Nome
FROM Dipendente
ORDER BY Dipendente.Cognome, Dipendente.Nome;

SELECT *
FROM Azienda
ORDER BY Nome;

SELECT Dipendente.Cognome,Dipendente.Nome, (Dipendente.Reddito_annuo-Dipendente.Trattenute) AS Redito_netto
FROM Dipendente,Azienda,Versamento
WHERE Dipendente.Matricìola=Versamento.Matricola
  AND Azienda.Partita_iva=Versamento.Partita_iva
  AND Azienda.Nome='peugeot'
ORDER BY Dipendente.Cognome, Dipendente.Nome;

#Elenco alfabetico dei dipendenti di un’azienda con cognome, nome e detrazioni totali spettanti
# in funzione dei familiari a carico, conoscendo il valore unitario della detrazione per ogni familiare.

SELECT Dipendente.Cognome,Dipendente.Nome, (Dipendente.N_familiari*Destrazioni_per_famiglia) AS Tot_destrazioni
FROM Dipendente,Azienda,Versamento
WHERE Dipendente.Matricìola=Versamento.Matricola
  AND Azienda.Partita_iva=Versamento.Partita_iva
  AND Azienda.Nome='peugeot'
ORDER BY Dipendente.Cognome, Dipendente.Nome;

#21
SELECT Dipendente.Cognome,Dipendente.Nome, Azienda.Indirizzo
FROM Dipendente,Azienda,Versamento
WHERE Dipendente.Matricìola=Versamento.Matricola
  AND Azienda.Partita_iva=Versamento.Partita_iva
ORDER BY Dipendente.Cognome, Dipendente.Nome;

#22
SELECT SUM(Dipendente.Trattenute), Cognome,Dipendente.Nome
FROM Dipendente,Versamento,Azienda
WHERE Dipendente.Matricìola=Versamento.Matricola
  AND Azienda.Partita_iva=Versamento.Partita_iva
  AND Azienda.Nome='peugeot';

#23



