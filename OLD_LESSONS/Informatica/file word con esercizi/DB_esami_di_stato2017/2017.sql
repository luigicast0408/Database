CREATE TABLE Autisti
(
    CF VARCHAR(20) NOT NULL PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    DataNascita DATE NOT NULL,
    LuogoNascita VARCHAR(50) NOT NULL,
    N_patente VARCHAR(20) NOT NULL,
    DataScadenza DATE NOT NULL,
    LinkFoto VARCHAR(100) NOT NULL,
    Targa VARCHAR(10) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    N_telefono VARCHAR(20) NOT NULL,
    Soste VARCHAR(100) NOT NULL,
    Bagagli VARCHAR(100) NOT NULL,
    Animali VARCHAR(100) NOT NULL
);

CREATE TABLE Viaggi
(
  ID_viaggio INT NOT NULL  PRIMARY KEY AUTO_INCREMENT,
  Citta_partenza VARCHAR(50) NOT NULL,
  Citta_arrivo VARCHAR(50) NOT NULL,
  Data_ora_partenza DATE NOT NULL,
  Compenso INT NOT NULL,
  Posti_disponibili INT NOT NULL,
  CF VARCHAR(20) NOT NULL, FOREIGN KEY (CF)
    REFERENCES Autisti(CF)
);

CREATE TABLE Prenotazioni
(
  ID_prenotazione INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  ID_viaggio INT NOT NULL, FOREIGN KEY (ID_viaggio)
    REFERENCES Viaggi(ID_viaggio),
  Voto INT NOT NULL,
  Esito VARCHAR(50) NOT NULL,
  Feedback VARCHAR(100) NOT NULL,
  Tipologia VARCHAR(50) NOT NULL,
  ID_passegiero INT NOT NULL, FOREIGN KEY (ID_passegiero)
        REFERENCES Passegieri(ID_passegiero)
);

CREATE TABLE Passegieri
(
    ID_passegiero INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    DataNascita DATE NOT NULL,
    LuogoNascita VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    N_telefono VARCHAR(20) NOT NULL,
    Ducumento_identita VARCHAR(20) NOT NULL
);
#1.data una città di partenza, una di arrivo e una data,
#elencare gli autisti che propongono un viaggio corrispondente con prenotazioni
#non ancora chiuse, in ordine crescente di orario, riportando i dati dell’auto
#e il contributo economico richiesto;
SELECT Autisti.Nome, Autisti.Cognome, Autisti.Targa, Viaggi.Compenso, Viaggi.Data_ora_partenza
FROM Autisti, Viaggi
WHERE Autisti.CF = Viaggi.CF AND Viaggi.Citta_partenza = 'Milano' AND Viaggi.Citta_arrivo = 'Roma' AND Viaggi.Data_ora_partenza = '2019-12-12' AND Viaggi.Posti_disponibili > 0
ORDER BY Viaggi.Data_ora_partenza;

#2.dato il codice di una prenotazione accettata, estrarre i dati necessari per predisporre
# l’email di promemoria da inviare all’utente passeggero;
SELECT Autisti.Nome, Autisti.Cognome, Autisti.Email, Viaggi.Citta_partenza, Viaggi.Citta_arrivo, Viaggi.Data_ora_partenza, Viaggi.Compenso
FROM Autisti, Viaggi, Prenotazioni
WHERE (Autisti.CF =Viaggi.CF)
AND (Viaggi.ID_viaggio = Prenotazioni.ID_viaggio)
AND  (Esito = 'Accettata' AND ID_prenotazione=22);

#3. dato un certo viaggio, consentire all’autista di valutare le caratteristiche dei passeggeri visualizzando
# l’elenco di coloro che lo hanno prenotato,
# con il voto medio dei feedback ricevuti da ciascun passeggero, presentando
# solo i passeggeri che hanno voto medio superiore ad un valore indicato dall’autista
SELECT *
FROM Passegieri, Prenotazioni,Viaggi
WHERE (Passegieri.ID_passegiero = Prenotazioni.ID_passegiero) AND (Prenotazioni.ID_viaggio = Viaggi.ID_viaggio)
AND (Viaggi.ID_viaggio = 1) AND Voto=(SELECT AVG(Voto) AS Voto_medio FROM Prenotazioni WHERE ID_viaggio = 1 AND Voto > 3)
GROUP BY Passegieri.ID_passegiero, Passegieri.Nome;




