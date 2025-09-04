# Corso-R-base-per-Mediolanum (settembre 2025)
Programma delle giornate

Giornata 1 (3.9.2025) - lista degli argomenti trattati

1. Funzionamento della Virtual Machine (VM)

- Si accede dalla URL https://lms.godeploy.it con il codice XZ9G66.

- Scegliere il corso CU-OEC021 Introduzione al linguaggio R

- La VM è una pila hardware / software con 12 GB RAM ed una CPU di 2.5 GHz, Windows 10, con le seguenti app già installate: Chrome e Edge, Copilot, R 4.5.1 e RStudio, Adobe Acrobat Reader, WinRAR.

- Nella finestra di configurazione a sinistra: attivare l'enhanced mode, scegliere il tipo di tastiera e premere il tasto di inserimento della password

- Una volta entrati nella VM, tramite l'àncora (resize handle) ridurre la dimensione della finestra di configurazione fino a farla sparire (l'àncora rimane comunque sempre visibile alla estrema sinistra dello schermo), in modo da riservare tutto lo spazio video alla VM.

Alla fine del lavoro: nella finestra di sinistra premere il bottone al fondo "END THIS LAB" e poi il bottone "SAVE YOUR PROGRESS". In questo modo le attività svolte sono salvate per 10 giorni, trascorsi i quali il lab continuerà comunque a essere disponibile  (sino a 180 giorni dalla data odierna, il 3.9.2025).
E' possibile spedire i file del file system della VM a chicchesia tramite 'wetransfer' (dal browser), versione gratuita.

Attenzione: le prime righe e l'ultima riga dello schermo sono relative al PC host. Al loro interno c'è lo spazio di lavoro della VM. In particolare, non confondere le due ultime righe (la barra di Windows della VM e quella del PC host).

Dal punto di vista del PC host la VM è il tab del browser 'go deploy - students'.

Alla VM possono accedere sino a 19 persone (18 partecipanti iscritti al corso + il docente).

2. Nella VM Creare una cartella di lavoro per il corso, ad esempio 'Corso R base' in Desktop.

3. Nella casella dell'URL del browser digitare il nome del repository ufficiale del corso, contenente tutto il materiale didattico aggiornato: https://github.com/antonio-corsi/Corso-R-per-Mediolanum. Si tratta di un repository pubblico. Premere il bottone verde 'Code' e poi 'Download ZIP' che scarica tutti i file del repository nella cartella locale 'Downloads'.
In questa cartella aprire lo zip con la app WinRAR e estrarre tutti i file dello zip nella cartella locale creata al passo 2.

A questo punto siamo pronti per lavorare con RStudio.

4. Introduzione a RStudio
- I 4 pane
- Le opzioni globali (Tools --> Global Options): 
  la versione di R (tab "General" - "Basic")
  default text encoding (tab "Code" - "Saving")
  l'appearance, in particolare colori di primo e secondo piano (tab "Appearance")
  pane e tab mostrati (tab "Pane Layout")
  primary e secondary CRAN repository (tab "Packages")

Note
- Per chi può installare R ed RStudio, non gli serve la VM e può accedere al repo github direttamente dal browser del suo PC.
- Repo su Github sarà disponibile per una settimana dalla fine del corso (cioè sino al 19 settembre).

5. Script R "Corso R base - Abis) Altro su RStudio"
- Sezione "Package" (in particolare .libPaths())


Giornata 2 (5.9.2025) - lista degli argomenti da trattare

1.Recap

2. Dallo script R "Corso R base - Abis) Altro su RStudio" le seguenti sezioni:
- sezione "Dataset per partire"
- sezione "Data type (formati colonne)"
- sezione "I dataframe"
- sezione "Cicli ed If"
- sezione "Funzioni custom"

3. Dallo script R "Corso R base - D) Varie" le seguenti sezioni:
- sezione "Debugging" sulla funzione vista prima - usare lo script ad hoc "funzione_debug"

4. Dallo script "Corso R base - A) Introduzione ad R e Rstudio" le seguenti sezioni:
- Mini intro ad R (con qualche primo esempio al volo)
- Download ed installazione (R ed RStudio) 
- Mini intro ad RStudio (recap e sottosezione sul tab "Environment")
- Creare un nuovo script R (saltare la storia)
- Varie
- I device
- Check versioni
- Startup: options and environment variables (solo cenni veloci)
- Gli environment di R ed RStudio (solo cenni veloci)

5. RMarkdown
- con il file prova_knit.
