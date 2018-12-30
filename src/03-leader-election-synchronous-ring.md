# Elezione del leader in un anello sincrono

## Il problema

Si suppone che il grafo di rete $G$ sia un anello che consiste di $n$ nodi,
numerati da 1 a $n$ in senso orario. Si conta spesso $\mod n$, pemettendo a 0
di essere un altro nome per il processo $n$, $n + 1$ per il processo 1, e così
via.

Presupposti:

* I processi associati con i nodi di $G$ non conoscono i propri indici, o
  quelli dei propri vicini.
* Le funzioni di generazione dei messaggi e di transizioni sono definite nei
  termini di nomi locali e relativi per i vicini.
* Ogni processo è in grado di distinguere il proprio vicino in senso orario da
  quello in senso antiorario.

Il requisito è che, eventualmente, esattamente un processo dovrebbe dare in
output la decisione per cui esso è il leader, ad esempio cambiando una
componente del suo stato chiamata *status* al valore *leader*.

Ci sono diverse versioni del problema:

1. Si richiede che tutti i processi non leader diano eventualmente in output il
   fatto che non sono leader, ad esempio cambiando il proprio componente *status*
   al valore *non-leader*

2. L'anello può essere unidirezionale o bidirezionale. Se unidirezionale,
   allora ogni arco è diretto da un processo al suo vicino in senso orario, per
   cui i messaggi possono essere inviati solo in senso orario.

3. Il numero $n$ di nodi nell'anello può essere conosciuto o sconosciuto. 
   * Se è conosciuto, significa che i processi devono comportarsi correttamente
     solo in anelli di dimensione $n$, e quindi che possono usare il valore $n$
     nei loro programmi.
   * Se è sconosciuto, significa che i processi devono essere in grado di
     lavorare in anelli di diverse dimensioni, per cui non possono usare
     informazioni sulla dimensione dell'anello.

4. I processi possono essere identici o distinguersi iniziando ognuno con un 
   *identificatore univoco (UID)* scelto da uno spazio grande e completamente
   ordinato di identificatori, come $\mathbb{N}^+$. Si da' per vero che l'UID
   di ogni processo sia diverso da ogni altro nell'anello, ma che non ci siano
   restrizioni su quali UID possano apparire nell'anello. Gli identificatori
   possono essere ristretti per essere manipolati solo tramite certe
   operazioni, come comparazioni, o possono ammettere operazioni senza
   restrizioni.

## Impossibilità per processi identici

Una prima e semplice osservazione è che se tutti i processi sono identici, il
problema non può essere risolto dato il modello proposto. Questo anche nel caso
in cui l'anello sia bidirezionale e la sua dimensione è conosciuta dai
processi.

\begin{theorem} 
  
  Sia $A$ un sistema di processi, $n > 1$, ordinati in un anello bidirezionale.
  Se tutti i processi in $A$ sono identici, allora $A$ non risolve il problema
  dell'elezione del leader. 

\end{theorem}

\proofbegin
 
Si supponga che esista il sistema $A$ descritto che risolve il problema
dell'elezione del leader. Si ottiene una contraddizione.

Si può dire senza nessuna perdita di generalità che ognuno dei processi di $A$
ha esattamente uno stato iniziale. Questo perché se ogni processo avesse più
di uno stato iniziale, si potrebbe scegliere uno qualunque degli stati
iniziali e ottenere una nuova soluzione in cui ogni processo ha un solo stato
iniziale. Con questo presupposto, $A$ ha esattamente una esecuzione.

Si consideri quindi l'univoca esecuzione di $A$. È semplice verificare, per
induzione sul numero di round $r$ che sono stati eseguiti, che tutti i
processi sono in stati identici immediatamente dopo $r$ round. Per cui, se
uno dei processi dovesse raggiungere uno stato in cui *status* corrisponde a
*leader*, allora tutti gli altri processi raggiungerebbero lo stesso stato
allo stesso momento, e questo violerebbe il requisito di unicità.

\proofend

## LCR - Un algoritmo di base

* Usa solo comunicazione unidirezionale 
* Non necessità la conoscenza della dimensione dell'anello
* L'unico output viene dal leader.
* Vengono usate solo operazioni di comparazione sugli UID.

### Algoritmo LCR (pseudocodice) {-}

```

process A(int my_id) {

  <invia my_id al prossimo nodo nell'anello>

  while(true) {

    received_id = <ricevi dal nodo precedente>

    if(received_id > my_id) {
      <invia received_id al nodo successivo>
    }
    else if(received_id == my_id) {
      output = leader
      break
    }

  }
}

```

In questo algoritmo, il processo con l'UID più grande è l'unico a dare come
output leader.

### Algoritmo LCR (formale) {-}

L'alfabeto dei messaggi $M$ è l'esatto insieme degli UID.

Per ogni $i$, lo stato in $states_i$ corrisponde alle seguenti componenti:

* $u$, uno UID, inizialmente l'UID di $i$
* $send$, uno UID o $null$, inizialmente lo UID di $i$
* $status$, con possibili valori $\{unknown, leader\}$, inizialmente $unknown$

L'insieme dei messaggi inizali $start_i$ consiste nel singolo stato definito
dalle assegnazioni date.

Per ogni $i$, la funzione di generazione dei messaggi $msgs_i$ è definita come
segue:

| invia il valore corrente di $send$ al processo $i + 1$

In realtà, i nodi non conoscono il valore $i + 1$, se non con un nome relativo
come *vicino in senso orario*. Viene riportato qui in questo modo per
semplicità.

Per ogni $i$, la funzione di transizione è definita come segue:

| $send := null$
| if (il messaggio in arrivo è $v$, uno UID)
|   case
|     $v > u: send := v$
|     $v = u: status := leader$
|     $v < u: noop$
|   endcase
 
La prima riga pulisce lo stato dagli effetti dell'invio del precedente
messaggio.

La descrizione dell'algoritmo ha una traduzione diretta in una macchina a stati
per processi descritta nel Capitolo 2:

* Ogni stato consiste nel valore di ognuna delle variabili.
* Le transizioni possono essere descritte in termini di cambiamenti alle
  variabili.

Per dimostrare che l'algoritmo è corretto, bisogna dimostrare che esattamente
un processo esegua eventualmente *leader* come output.
