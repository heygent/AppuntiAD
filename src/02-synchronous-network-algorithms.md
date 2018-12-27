# Modello di rete sincrona

## Sistemi di rete sincroni

\newcommand{\outnbrs}{out\text{-}nbrs} 

\newcommand{\innbrs}{in\text{-}nbrs}

Un *sistema di rete sincrono* consiste di una collezione di processi locati ai
nodi di un grafo orientato di rete.

Per definire un sistemda di rete sincrono formalmente, si inizia con un grafo
diretto $G = (V,E)$. Si usa la lettera $n$ per indicare $|V|$, il numero di
nodi nel grafo di rete.

Per ogni nodo $i$ di $G$, si usano le notazioni:

* $\outnbrs_i$ per indicare i *vicini in uscita* di $i$, ovvero quei nodi che
  hanno archi entranti che partono da $i$
* $\innbrs_i$ per indicare i *vicini in entrata* di $i$, ovvero quei nodi da
  cui partono archi entranti in $i$.
* $distance(i,j)$ indica la lunghezza del cammino minimo tra $i$ e $j$ in $G$,
  se esiste. Altrimenti, $distance(i,j) = \infty$
* $diam$, il *diametro*, indica la massima $distance(i,j)$ tra tutte le coppie
  di nodi $(i,j)$

Si suppone anche di avere un alfabeto fisso di messaggi $M$, e si considera
$null$ un segnaposto che indica l'assenza di un messaggio.

Associato a ogni nodo $i \in V$, si ha un *processo*, che consiste formalmente
dei seguenti componenti:

* $states_i$, un (non necessariamente finito) insieme di *stati*
* $start_i$, un sottoinsieme non vuoto di $states_i$, indicato come gli *stati
  iniziali*
* $msgs_i$, una *funzione di generazione dei messaggi*, che associa $states_i
  \times \outnbrs_i$ a elementi di $M \cup \{null\}$.
* $trans_i$, una *funzione di transizione di stato* che associa a $states_i$ e
  a vettori di elementi $M \cup \{null\}$ (indirizzati da $\innbrs_i$) a
  $states_i$

Ogni processo ha quindi un insieme di stati, di cui un sottoinsieme è di stati
iniziali. L'insieme di stati non deve essere finito, permettendo quindi di
modellare sistemi che includono strutture dati illimitate come contatori.

Funzione di generazione dei messaggi
: specifica, per ogni stato e vicino in uscita, il messaggio (o $null$) che il
processo $i$ invia al vicino indicato, a partire dallo stato dato.

Funzione di transizione di stato
: specifica, per ogni stato e collezione di messaggi da tutti i vicini in
entrata, il nuovo stato verso cui $i$ si sposta.

Canale (o link)
: una locazione associata a ogni arco $(i,j)$ che può, in ogni momento,
contenere al massimo un singolo messaggio di $M$.

L'esecuzione dell'intero sistema inizia con tutti i processi in stati iniziali
arbitrari, e con tutti i canali vuoti. Poi i processi, insieme e passo per
passo, eseguono i seguenti due passi:

1. Applicano la funzione di generazione dei messaggi allo stato corrente per
   generare i messaggi da inviare ai vicini in uscita, e mettono questi
   messaggi nei canali appropriati.

2. Applicano la funzione di transizione di stato allo stato corrente e ai
   messaggi in entrata per ottenere il nuovo stato, rimuovendo i messaggi dai
   canali.

La combinazione dei due passi è chiamata *round*. Notare che, in generale, non
vengono imposte restrizioni sull'ammontare di computazione che un processo deve
eseguire per computare i valori delle sue funzioni di generazione dei messaggi
e di transizione di stato.

Notare anche che il modello presentato è deterministico, nel seno che le
funzioni di generazione dei messaggi e di transizione di stato hanno valori
singoli. Per cui, a partire da una particolare combinazione di stati iniziali,
la computazione si svolge in modo univoco.

Stati di halt

: L'halt dei process può essere tenuto in considerazione in questo modello
designando alcuni stati dei processi come *stati di halt*, e specificando che
da questi stati non ci può più essere alcuna attività, ovvero: nessun messaggio
viene più generato, e l'unica transizione possibile è un loop verso lo stato
stesso. Questi stati non svolgono lo stesso ruolo che hanno negli automi
finiti, e *non* sono quindi considerati *di accettazione*, ma hanno il solo
scopo di interrompere il processo. Ciò che viene computato dal processo deve
essere determinato in un altro modo.

Nodo e processo di ambiente

: Occasionalmente, si vuole considerare un sistema sincrono in cui i processi
si avviano in diversi round. Si modella questa situazione estendendo il grafo
di rete per includere uno speciale *nodo di ambiente*, che ha archi verso tutti i
nodi ordinari. Lo scopo del corrispondente *processo di ambiente* è di inviare
degli speciali *messaggi di wakeup* a tutti gli altri processi.