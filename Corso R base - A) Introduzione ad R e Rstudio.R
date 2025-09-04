#  COPYRIGHT 2025 Antonio Michele Piemontese

# Introduzione ad R - parte I

# Copyright 2021 Antonio Michele Piemontese

###########################################

# Mini intro ad R ---------------------------------------------------------

# - origini (università di Auckland (New Zealand) a fine anni '90, derivato da S di John Chambers del 1976 nei Bells Labs).

# - diffusione nel ML (il primo, testa a testa, con Python): molti siti (Quick R) e libri (Robert Kabacoff, Hadley Wickham, etc), riviste (R Journal),
#   "the R development core team", contributi world-wide (CRAN), siti documentativi (R-bloggers, Quick-R, Inside-R), siti Q&A (stackoverflow, R-devel).
#   come ML, R equivalente a Python; come RO, rapporto 10:1.

# - "provides the WIDEST variety of statistical (linear and nonlinear modelling, classical statistical tests, time-series analysis,
#   classification, clustering, …) and graphical techniques (base e ggplot)" - dal sito R.
#   NEW methods on a WEEKLY basis.

# - completamente open-source, veramente gratuito (i concorrenti costano da migliaia e decine di migliaia di euro);

# - interpretato, weakly typed, scritto in C e R stesso (facile da comprendere, perciò).

# - piattaforme supportate:
#   funziona su Windows, Mac, Linux, Unix, Ubuntu, etc.
#   funziona da web:
    url <- "https://rdrr.io/snippets/"
    browseURL(url, browser = getOption("browser"))
    url <- "https://cran.r-project.org/web/views/WebTechnologies.html"
    browseURL(url, browser = getOption("browser"))
#   Shiny is an R package that makes it easy to build interactive web apps straight from R.
#   c'è persino una versione per iPhone (sconsigliabile).

# - ha if, cicli e funzioni, ovviamente.

# - tutti gli "oggetti" sono in memoria durante l'esecuzione di una sessione.

# - molto estensibile: immensa comunità di utenti R (molto attiva) --> CRAN (23,000+ pacchetti al 2025), 48 task views.

# - aggancia codice C++ (rcpp) e Fortran (compilato) per velocizzare operazioni matematiche.

# - ha funzioni di debug e profiling.

# - supporta le operazioni matriciali (e quindi l'algebra lineare - importante nel ML).

# - connettività a 360°(Oracle, Access, DB2, .txt, .xlsx, .csv, .json, SAP, SAS)

#   può utilizzare SQL/ODBC ed accedere ai principali database, inclusi Oracle ed IBM (e ovviamente excel e file di testo).

# - può accedere a Hadoop (file system distribuito) e Spark cache engine (big data).

# - AWS SageMaker (il ML di AWS)

# - Microsoft Azure AI platform
    
# - IBM da qualche anno offre "massively parallel in-database analytics in R" nei suoi prodotti.
#   Idem per Microsoft (support esteso per R)
    
# - ha un suo dialetto ('tidyverse') per "functionality to model, transform, and visualize data".

# - RMarkdown ("the Latex-like documentation system for R") per produrre documenti HTML con codice R, URL, immagini, video, PDF, Word.

# - breve cfr. con altri linguaggi di Data Science / Machine Learning: Python/scikit-learn, Matlab/Octave, Orange, Excel.

# - OOP (Object Oriented Programming) in R:
#   "generally in DS/ML functional programming is much more important than object-oriented programming, because you typically
#   solve complex problems by decomposing them into simple functions, not simple objects [https://adv-r.hadley.nz/oo.html];
#   comunque, in R ci sono parecchi (troppi?) OOP systems;
#   i più usati sono:
#   * A) S3 e S4 (come S3 ma più formale e rigoroso), che fanno parte entrambe di R base ed implementano la "generic-function OOP,
#   aka functional OOP" (diversa da quella di Java o C++, perchè le chiamate ai metodi sembrano chiamate di funzione);
#   [ad es. i metodi 'print', 'plot', 'summary' o 'predict' dei vari oggetti sono metodi S3];
#   B) le Reference Classes (RC) ed R6 (che è molto simile alle RC), che implementano la "message-passing (encapsuleted) OOP" (che
#   è il paradigma OOP tradizionale usato negli altri linguaggi OO) [le prime fanno parte di R base, R6 invece del package R6];
#   C) i "base types", interni ad R (e scritti in C), che sono la base degli altri sistemi OOP prima visti; vedi
#   "Advanced R" di Wickham, pp. 99 e ss.
#   Attenzione: in R, qualsiasi cosa che può essere assegnata ad una variabile è un "oggetto": costanti, strutture dati, funzioni,
#   grafici. [non sono "oggetti" in senso sretto] - RIA 2nd ed. p. 22

# cheatsheet (fatti bene) su R,RStudio, RMarkdown ed altro

# - limiti di R:
#   * R base è meno veloce di Python e Matlab (su grandi dataset), in particolare nei cicli 'for', ma R avanzato (ad es. pacchetti specifici
#     per big data) può lavorare con GBs/TBs! (ad es. RIA, 2nd ed. Appendix F);
#   * in generale, R e Python sono meno veloci di C++, Fortran, .Net, Java, ABAP
#   * il data typing di R è a volte poco chiaro e poco coerente;
#   * manca a volte un "disegno" unico (CRAN ha 23.000 pacchetti di autori diversi); è l'inevitabile prezzo da pagare ad una comunità molto viva.
#   * R, come python, è mondo molto ampio e complesso (curva di apprendimento lunga per raggiungere alti obiettivi): è linguaggio + ML!

# perchè usare un linguaggio specifico di ML anzichè un linguaggio generico (general-purpose), come Java, C#, ABAP, ecc?
# 3 ragioni principali:
# - disponibilità di TUTTI gli algoritmi di ML oggi e domani disponibili (grazie al CRAN);
# - caricamento e gestione di dataset esterni molto facilitata; in particolare, R e python hanno il "funzionamento vettoriale";
# - eccellente data visualization (grafici interattivi, modificabili, ecc)
    
# LIBRI:
# - base/intermedio: "R in Action" (RIA) di Robert Kabacoff, 2nd edition, 2015;
# - avanzato: "Advanced R" di Hadley Wickham (2014); 2nd edition 2019 per Kindle.
# - umoristico, ma utile: "How to lie with Statistics" di Darrell Huff (1954) - ITALIANO

# Il corso -------------------------------------------------------------------

# Il corso è con Windows, comunque R è identico su tutte le piattaforme,
# le poche piccole differenze sono relative a:
# - installazione,
# - shortcut (https://libguides.libraries.claremont.edu/c.php?g=480755&p=3350989)
# - ed all'interazione con il sistema operativo.
# Comunque R ed RStudio funzionano MEGLIO su Mac e Linux che Windows (come sempre).
# corso case-driven (diverso dal tradizionale), senza slide ed al volo (no script preparati) per
# favorire il coinvolgimento.

# OUT-of-SCOPE (corso avanzato): progetti (con controllo versione), package (come crearli e renderli disponibili agli altri),
# ggplots (grafica avanzata), environment, rmarkdown (mix multimedia, testo e codice R).

# esempi del corso: generali, qualche riferimento FINANZIARIO (ove possibile)
url <- "https://cran.r-project.org/web/views/Finance.html"
browseURL(url, browser = getOption("browser"))


# Download ed installazione (R ed RStudio)----------------------------------------------------------------

# - R versione 4.5.1 dal sito:                  https://cloud.r-project.org/
# - RStudio desktop versione 2025.05.1 dal sito: https://rstudio.com/products/rstudio/download/
# C'è una versione desktop ed una web-based multi-user. Il corso è sulla prima.
# Il corso è per Windows.

# Tools --> Global Options --> tab 'Appearance': tema per RStudio, font, size, colore background e foreground dell'editor.
# Inversione nero/bianco:
# - Ambiance, Chaos e Vibrant Ink: bella l'enfasi del codice wrt commenti; ma stancante!
# - Clouds Midnight: meno brillante.
# Dawn: separazione codice / commenti, preservando foreground e background abituali.
# Tomorrow night blue: background blu (non male).
# Il default è 'TextMate'.

# l'installazione di RStudio e di R è in genere "banale". RStudio richiede una versione di R recente.
# con Windows e Mac è un'auto-installazione binaria (un pò più complicato con altri OS).
# ci sono guide all'installazione per specifico OS.
# ovviamente, R e RStudio sono open-source e possono quindi essere compilati da chiunque (ma è difficile da fare).
# l'installazione ha un log, che si trova in: Help --> Diagnostics --> Show Log Files

# PROBLEMI? reinstallare è la prima scelta (R è veloce, RStudio meno e poi occorre re-installare tutti i package)
# ottima possibilità: stackoverflow

# Mini intro ad RStudio ---------------------------------------------------

# una IDE, ce ne sono altre (Jupyter, VS Code, Eclipse (generica), Microsoft R Open, Notepad++, Rgui, Rattle, ecc).
# RStudio runs on top of R and requires R to be installed separately.

# tour di RStudio (4 panes)

# con la disposizione di default:
# - upper left: for editing files;
# - lower left: for interacting with R;
# - upper right: 3 tabbed panes for interaction: workspace browser, history browser, connections (ODBC, Spark, etc);
# - lower right: 4 tabbed panes for interaction: file manager (for basic file operations), plots, packages, and help;

# modificabili: come pane.size in modo dinamico; come ordine e contenuti da: Tools --> Global Options --> Pane Layout;
#               come font e font.size da: Tools --> Global Options --> Appearance

# il pane consolle NON è adatto per blocchi di istruzioni, per questo c'è il pane editor.

# 'source': "source causes R to accept its input from the named file or URL or connection or expressions directly. Input
# is read and parsed from that file until the end of the file is reached, then the parsed expressions are evaluated
# sequentially in the chosen environment." - help R.
# 'source' vs 'run' (so 23923638):
# - The "run" button simply executes the selected line or lines. The "source" button will execute the entire active document.
# - 'Source' won't print anything unless you source with echo, which means that ggplot won't print to pngs, as another
#    posted mentioned.
# - "The difference between running lines from a selection and invoking 'source' is that when running a selection all lines
#   are inserted directly into the console whereas for Source the file is saved to a temporary location and then sourced
#   into the console from there (thereby creating less clutter in the console)." - RStudio support.
# --> sourcing functions in files makes them available for scripts to use.
# --> Rstudio breakpoints work in 'source' (Ctrl-Shift-S) but not in 'run' (Ctrl-Enter).
# 'source on save': This is kind of a shortcut to save and execute your code (so 51649302). E' un modo di programmare.
# MIE note:
# - 'source' anche di un altro script R (non quello aperto, che è il default), vedi esempio di Fontana (PoliMI).
# - A volte piccole differenze di comportamento tra 'run' e 'source'.
#
# tab 'Environment' (formerly Workspace), shows the project's GLOBAL WORKSPACE.

# cioè il nuovo valore di un valore/dato è visualizzato nella finestra 'Environment' non appena il comando R è eseguito [e,
# se ci sono molte variabili, la finestra si posiziona automaticamente sempre su quell'ultimo valore] - non serve save o synchronize.
# 'View' è invece uno snapshot e non è sincronizzata alla consolle (occorre rifare View in caso di modifica dei dati).
# data vs values in the tab 'Environment':
url <- "https://community.rstudio.com/t/data-vs-values-in-global-environment-in-r/24035/2"
browseURL(url, browser = getOption("browser"))

# - "What you see on that pane are objects loaded in memory, not files, and the difference is that the objects listed under "data"
#    are any sort of DATAFRAME (included tibbles, data.table, etc), MATRICES and LISTS, and the ones listed under "values" are
#    SCALARS and VECTORS.

# "scalare": un numero singolo
# "vettore": una lista di numeri (1..n) o di componenti (a,b,c,ecc)
# "matrici": lista di vettori (m righe x n colonne) - spreadsheet
# "tensore": matrice p-dimensionale con p>2

# - That's RStudio at work and not part of R. A more accurate labeling would be "Dimensioned Objects" and "Non-dimensioned(so: 38687880)
#


# Creare un nuovo script R ------------------------------------------------

# in diversi modi:
# - ctrl+shift+N
# - File --> New File --> R Script
# - dalla toolbar: icona "+"

# SALVARLO con encoding = 'UTF-8' (Tools --> Global Options --> Code --> tab Savings --> Default Text Encoding=UTF-8! (post))
# (importante, altrimenti problemi con altri sistemi operativi/macchine)
url <- "https://yihui.org/en/2018/11/biggest-regret-knitr/"
browseURL(url, browser = getOption("browser"))
# oppure, alternativamente (è la stessa cosa), da menù: File --> Save with Encoding --> UTF-8.
# NB. UTF-8 è un codificatore universale a 8 bit che ha in pratica sostituito il vecchio Ascii a 7 bit (Valentina Porcu, corso R su Text Mining).

# La storia dei comandi (prima di partire) --------------------------------------------

# 1) per partire (Tools --> Global Options --> tab 'General' --> box 'History' = TRUE)

# 2)
savehistory("030925-parteA",quiet=T)  # meglio (specifico)
                              # The name of the file in which to save the history, or from which to load it. The path is relative to
                              # the current working directory.
                              # Alla partenza, R carica il file .Rhistory nella home utente.
# clear history in the tab
loadhistory("161120-parteA")

# restore comandi da 'history': premere il bottone "To Console".

save(file="161120.RData")


# Varie -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

# commenti:
# - carattere iniziale
# - Selezionare linee, poi: Code --> Comment/Uncomment Lines

# indentare: tab e shift-tab.

# Code --> Reindent lines NON sempre funziona.

# R è case sensitive!

# working directory
getwd()
setwd() # più semplice da menù (Sessions --> Setting Working Directory)  

# ERRORI in ROSSO
# ATTENZIONE: se l'interprete di R non riconosce come valida la sintassi di un comando (per un errore di sintassi o perchè
# si è erroneamente inserito un CR in una linea del codice), UNA o TUTTE le linee di codice successive sono marcate in ROSSO.
# Sia l'apparizione che la scomparsa dell'avvertimento sono leggermente ritardate.

# ESEGUIRE un comando R dall'editor di RStudio
################################################################################################################
# eseguire un comando R da EDITOR di RStudio: diversi modi:                                                               #
# - posizionare il cursore sulla riga da eseguire (senza selezione!) e premere ctrl+enter;                     #
# -     "             "      "     "   "    "        "      "        " premere il bottone "Run" in alto a dx.  #
# - selezionare una parte di una riga e premere ctrl+enter oppure il bottone "Run".                            #
# - selezionare un insieme di righe (complete!) e premere ctrl+enter oppure il bottone "Run".                  #
#   a differenza dei precedenti modi, il cursore NON avanza di posizione e la selezione rimane attiva.         #
# da CONSOLLE:                                                                                                 #
# - digitare il comando o fare copy & paste del comando da editor;                                             #
# - richiamare un comando precedente con up-arrow;                                                             #
# - la selezione di parte di un comando + ctrl-enter NON funziona.                                             #
################################################################################################################


# I device --------------------------------------------------------------------------------------------------------------------------------------------------------------------
# output su file (oltre che su consolle):

ls()
sink("corsobaseRgiornoI.txt",append=TRUE,split=TRUE)  # solo output (no comandi, no environment, e no grafica).
#                                                     # append=TRUE appende al file esistente.
#                                                     # split=TRUE dirige l'output SIA su file CHE a video.

# ....
sink() # per chiudere la redirezione su file (e non 'dev.off()'!)

pdf("grafico.pdf") # apertura del dispositivo PDF (un device)
# Creo un grafico
plot(1:10, 1:10, main = "Grafico lineare semplice")
# Chiudo il dispositivo
dev.off()

bmp("immagine.bmp")
plot(1:10, 1:10, main = "Grafico lineare semplice")

dev.off()

# Cos’è un device?
# In R, un device grafico è un canale di output attraverso il quale i grafici vengono disegnati. Può essere:
# - lo schermo (finestra grafica interattiva)
# - un file (PDF, PNG, JPEG, BMP, ecc.),
# - in generale, qualsiasi supporto capace di ricevere e mostrare grafica.

# il device grafico X11
# Apro un nuovo device grafico X11
x11(width = 7, height = 7)

# Faccio un grafico
plot(1:10, (1:10)^2, main = "Grafico su device X11")

# Apro un altro device X11
x11()
hist(rnorm(1000), main = "Secondo grafico")

# Lista dei device aperti
dev.list() # il primo è il device null

# Passo al primo device
dev.set(1)

# Chiudo l'ultimo device aperto
dev.off()

library(ISLR)
plot(Credit$Income,Credit$Balance);

dev.off()

# in caso di problemi con la chiusura di un device grafico, vedi: so: 44336215
# while (!is.null(dev.list()))  dev.off()

# Check versioni ---------------------------------------------------------

R.version
sessionInfo() # per R (utile per domande, ad es. su stackoverflow)
              # --> questo comando, come molti comandi di configurazione di R, può fornire tipologie di informazioni
              #     un pò differenti da macchina a macchina (dipende dal sistema operativo, dalla versione di R, ecc).
              #

# check Versione RStudio da menù: Help --> About RStudio

# help (da menù): breve giro
# - About RStudio: la versione
# - Check for updates (attenzione, package da reinstallare)
# - Cheat Sheets

# RStudio non richiede una particolare versione di R, purchè sia abbastanza recente.
# Alla partenza, RStudio cerca una versione di R in varie posizioni:
# in Windows: Tools -> Global Options;
# col Mac: $ export RSTUDIO_WHICH_R=/usr/local/bin/r:
# Web-users really don't have a choice, as this is determined by who configures the server.


# Startup: options and environment variables ----------------------------

# la sezione più ostica!

# the startup process (p. 7):
# - 1) R is started in the working directory;
# - 2) if present, the .Rprofile file's commands are executed;
# - 3) if present, the .Rdata file is loaded (saved at a previous quit: "Save workspace image";
#                                          oppure in qualsiasi momento 'save.image(file="xxx.RData")');
#                                          R help: "the objects can be read back from the file at a later date
#                                          by using the function 'load(file="xxx.RData")');
#                                          this is PERSISTENCY of objects in the workspace (quest'ultimo da approfondire).
# - 4) other actions described in '?Startup' are followed.
?Startup

# This process allows R users to place commands they desire to run in every session in an .Rprofile file, and
# to have directory's .RData files loaded, so that different global workspaces can be used for different projects".

# how to control R options and environment variables on startup?
# https://support.rstudio.com/hc/en-us/articles/360047157094-Managing-R-with-Rprofile-Renviron-Rprofile-site-Renviron-site-rsession-conf-and-repos-conf:

# PREMESSA: 5 tipi file in R:
# .R         istruzioni (il codice R)
# .Rprofile  impostazioni di RStudio (a livello di progetto e/o di utente)
# .RData     oggetti/variabili (R loads a saved image of the user workspace from ‘.RData’ in the current directory
#                               if there is one).
# .Rhistory  storia delle istruzioni
# .Renviron  variabili di ambiente

# .Rprofile e .Renviron files are user-controllable files to set options and environment variables.
# - Sys.setenv(key1 = "value1")
# - Sys.getenv("Key1") will return "value1"
# Both .Rprofile and .Renviron files have equivalents that apply server wide (aka, .RProfile site and .Renviron site).

Sys.getenv()   # la lista dei valori correnti di tutte le variabili di ambiente

help("Rprofile")  # info su quali OPZIONI è possibile impostare nel file profilo

# accedere al file profilo (utente):
file.edit(file.path("~", ".Rprofile")) # edit .Rprofile in HOME

# le variabili di ambiente di Windows: digitare 'env' dopo bottone start.


# Gli environment di R ed RStudio -----------------------------------------

# un'altra sezione ostica!

# cos'è un environment?
# "an environment is a collection of objects such as functions, variables, and so on. Whenever we hit up the R interpreter, 
# an environment is created. So at this point, any new variable we create is now contained in the new environment.

search()      # la lista degli environment (la stessa della drop-down list del tab "Environment" in alto a dx.)

ls()          # la lista delle variabili del Global Environment (quelle definite dall'utente)
              # character(0) significa NULL

rm(list=ls()) # per resettare l'ambiente ("rimuove tutti gli oggetti in un colpo solo" - ISLR, p. 43)
              # --> 'ls' returns a vector of character strings giving the names of the objects in the
              #     specified environment.
              #     rm(ls()) does not work as ls() is NOT a list (class(ls()) --> "character"
              # You will get no warning, so don't do this unless you are really sure.

rm(A)         # rimuove un singolo oggetto

ls(name = "package:stats")
              # list objects/variables in the named environment (not necessarily the Global Environment)

# equivalente grafico: tab "Environment" nel pane in alto a dx, la drop-down list degli ambienti

ls(name = ".GlobalEnv")



