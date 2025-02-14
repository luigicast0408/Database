# 1°esercitazione algebra relazionale

Due Date: November 9, 2024
Materia: Esercizi Database
REVISIONATA : No
Status: In progress
prof: SI

Dato il seguente schema relazionale:

**M(idm,   nomem,   rating,  eta)
B(idb,   nomeb,   colore)
P(idm,   idb,   data)**

1. **Trovare  i  colori  della  barca  prenotata  dal  marinaio  Marco;**

$$
\pi_{colore}((Marinaio \Join Prenotazione \Join Barca) \sigma _{nomem="MARCO"}) 
$$

1. **Stampare  gli  id  dei  marinai  che  hanno  un  rating  di  almeno  8   o  che  hanno  prenotato  la  barca  103;;**

$$
\pi_{idm}((Marinaio \Join Prenotazione)\sigma_{rating  \geq 8 \space\lor\space idb = 103}) 
$$

1. **Trovare  il  nome  dei  marinai  che  non  hanno   prenotato  barche  rosse;;**

$$
R_1 = Marinai \Join Prenotazioni \\ R_2 = \sigma_{colore= "Rosso"} (Barche) \\ R_3 = R_1 \Join R_2 \\ R_4 = R_3-R_2\\ R_5 = \pi_{idm} (R_4)
$$

1. **Trovare  l'id  dei  marinai  che  hanno  un'età  maggiore  di  20  e  che  non  hanno   prenotato  una  barca  rossa;;**

$$
R_1 = Marinai \Join Prenotazioni \\ R_2 = \sigma_{colore= "Rosso"} (Barche) \\ R_3 = R_1 \Join R_2 \\ R_4 = R_3-R_2 \\ R_5 = \pi_{id_m}(\sigma_{età >20} (R4))
$$

1. **Trovare  il  nome  dei  marinai   che  hanno  prenotato  almeno   due  barche;**
    
    $$
    
    $$
    
2. **Trovare  i  nome  dei  marinai  che  hanno  prenotato  tutte   le  barche;;**

$$
\pi_{nomem([\pi_{idm,idb)}(P)]/ \pi_{idb}(B)) \Join M)}
$$

1. **Trovare  il  nome  dei  marinai  che  hanno  prenotato  tutte  le  barche  di  nome  "BlueFish"**

$$
\pi_{nomem([\pi_{idm,idb)}(P)]/ (\pi_{idb}(\sigma_{nome= "Blue Fish"}))(B) \Join M)}
$$