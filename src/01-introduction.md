# Introduzione

Il termine *algoritmi distribuiti* include una grande varietà di algoritmi
concorrenti usati per una vasta gamma di applicazioni. Originalmente, il
termine si riferiva ad algoritmi progettati per essere eseguiti su molti
processori "distribuiti" su una vasta area geografica. Nel corso degli anni,
date le similarità riscontrate tra queste categorie, il termine racchiude anche
gli algoritmi eseguiti su LAN e su multiprocessori a memoria condivisa.

Il termine "processori" suggerisce che si stia trattando di parti hardware. Ai
fini di questo trattato è più utile pensare a questi come processi sofware in
esecuzione sui processori hardware.

Ci sono molti tipi di algoritmi distribuiti. Alcuni degli attributi per cui si
differenziano sono:

* *Il modello di comunicazione tra processi (IPC)*: Gli algoritmi distribuiti
  sono eseguiti su più processori, che hanno bisogno di comunicare in qualche
  modo.

* Il *modello di temporizzazione*: I processori possono essere considerati:

  - **completamente sincroni**: eseguono comunicazioni e computazioni di pari
    passo. 

  * **completamente asincroni**, eseguono passi a velocità arbitrarie e in
    ordine arbitrario.

  * **parzialmente sincroni**: i processori hanno informazioni parziali sulla
    temporizzazione degli eventi (es. i processori hanno dei limiti sulle loro
    velocità relativa o hanno accesso a un clock approssimativamente
    sincronizzato).

* Il *modello di fallimento*: Si può supporre che il sistema sia completamente
  affidabile, o che l'algoritmo debba tollerare una certa quantità di
  comportamenti errati. I processi possono interrompersi, senza avvertimento,
  oppure possono esibire un più grave *fallimento bizantino*, dove si
  comportano in maniera arbitraria.

* I *problemi affrontati*: Ad esempio allocazione di risorse, comunicazione,
  consenso tra processori distrubuiti, controllo della concorrenza in un
  database, rilevamento dei deadlock, snapshot globali, e implementazione di
  diversi tipi di oggetto.

Il comportamento degli algoritmi distribuiti è spesso difficile da comprendere
per molti fattori dovuti da un maggiore tasso di *incertezza* e *indipendenza
delle attività*. Alcuni dei tipi di incertezza con cui gli algoritmi devono
confrontarsi sono:

* numero di processori non noto
* topologia di rete non nota
* input indipendenti in diverse locazioni
* diversi programmi in esecuzione tutti insieme, avviati in diversi momenti, e
  in operazione a diverse velocità
* non determinismo del processore
* tempi di arrivo dei messaggi incerti
* fallimenti dei processori e delle comunicazioni

Negli algoritmi distribuiti, invece di comprendere tutto sul loro
comportamento, il meglio che si può fare spesso è capire alcune proprietà
specifiche e certe del loro comportamento.
