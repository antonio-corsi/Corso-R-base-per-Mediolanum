
#  COPYRIGHT 2025 Antonio Michele Piemontese


# le directory base -------------------------------------------------------

# la directory corrente:
getwd()   # la stessa che RStudio mostra con (da menù): Session --> Set Working Directory --> Choose Directory/To Source File Location
dir()

# - so question 46819684;
# - https://support.rstudio.com/hc/en-us/articles/360047157094-Managing-R-with-Rprofile-Renviron-Rprofile-site-Renviron-site-rsession-conf-and-repos-conf
R.home()          # la directory home di R (dove è installato; le sottodirectory con l'argomento 'component'=...,
                  # es. R.home(component='bin')).
                  # è un Windows "short path-name" (vedi la voce Wikipedia EN "8.3 filename").
                  # check versione Windows con la app 'winver' --> la mia è Windows 10 Pro v.2004, build SO 19041.630.
                  # Windows 10, se non si modifica il registry, continua per default ad usare i nomi corti
url <- "https://www.devadmin.it/2019/12/17/windows-10-rimozione-del-limite-a-260-caratteri-nel-path-dei-file/"
browseURL(url, browser = getOption("browser"))

setwd(R.home())
getwd() # sempre visualizzata nel pane 'Files' (nel titolo in alto).

Sys.getenv("R_HOME") # la stessa cosa
Sys.getenv()

path.expand("~")     # la directory home utente (visualizzabile anche dal pane bottom-right --> tab 'Files' come default);
                     # contiene i files .RData, .Renviron, .Rhistory, e .Rprofile (dell'utente)
setwd(path.expand("~"))
dir()
setwd(path.expand("~"))
getwd()

Sys.getenv("R_USER") # la stessa cosa

# Sys.setenv()       # per impostare una variabile di ambiente

##################################################
# setwd("./XXX")    '.' è la directory corrente  #
##################################################

# Package -----------------------------------------------------------------

# help:
library(help="MASS")
library(ISLR)   # carica in memoria il package

# tre tipi (base, base recommended, contributed altrimenti detti user):
# - package base: sempre installati e caricati allo startup di RStudio (nella system library), non sono su CRAN (so 9700799); - non necessario installare nè fare 'library'
# - package base recommended: sono parte di R base, sono su CRAN e sono installati allo startup ma NON caricati --> library();
#   la lista è (per versione di R) in: "https://cran.r-project.org/src/contrib";
#   la lista dei package 'base' e 'base recommended' è visibile nel pane 'package' di destra al fondo (sotto la label 'System Library')
# - user package: sono su CRAN (3000 pacchetti nel 2010, 16000 nel 2020, a settembre 2025 23.000, e sono anche detti
#   "contributed packages", così anche visibili:
ap <- available.packages()  # disponibili su CRAN
View(ap)
ip <- installed.packages()  # installati nella mia configurazione (e quindi visibili dalla user library)
View(ip)

# Come installare un package da CRAN:
# - tab Packages --> bottone Install:
# - which CRAN da: [quello di default è in Austria]
#   Da Menù: Tools --> Global Options --> Packages --> check / modifica
# - which package: ha l'auto-completion, una lista di 23.000 entry (a settembre 2025) sarebbe scomoda
#   Se il package in oggetto non è disponibile, può essere un problema del CRAN mirror utilizzato --> cambiare CRAN mirror.
# - which library: si vede quelle impostate
# Oppure: usare 'install.packages', che per default usa la prima libreria dell'elenco '.libPaths'

# Come verificare/impostare le librerie dei package? In vari modi:

# a) il modo generale (per cultura generale):
Sys.getenv()  # la situazione CORRENTE (delle variabili di ambiente)
Sys.getenv("R_LIBS_USER")  # la user library (l'unica delle due modificabili)
Sys.setenv("R_LIBS_USER"="C:/Users/User/Documents")
Sys.setenv("R_LIBS_USER"="C:/Users/Utente/AppData/Local/R/win-library/4.5")

# --> spesso NON funziona - lasciar perdere

###########################################################################################################
# b) è anche possibile usare un comando specifico (PREFERIBILE solo per queste due variabili di ambiente):#
.libPaths()       # user e system library                                                                 #
.libPaths("C:/")  # si può cambiare solo la prima                                                         #
.libPaths()       # il pane non vede più i package della libreria utente.                                 #
.libPaths("C:/Users/Utente/AppData/Local/R/win-library/4.5")                                              # 
.libPaths()       # come prima                                                                            #
###########################################################################################################

# c) i modi a) e b) funzionano solo con alcune, ma non tutte, le modalità di attivazione di RStudio.
# Per un modo generale, sempre funzionante: --> aggiungere la variabile di ambiente WINDOWS di tipo utente
# (e riavviare Windows) - stackoverflow: 15170399.

# ATTENZIONE: R e RStudio cercano i package SOLO nelle due directory indicate!
# [anche 'library(...)' li cerca lì, nella prima e poi nella seconda - so: 45020527]
# a differenza di 'install.packages' che richiede obbligatoriamente gli apici, la funzione 'library' funziona anche senza apici.

# update package: tab 'Packages', bottone 'Update' (ci mette del tempo!)
# possibilità di skip di pacchetti.

# problema classico #1: installare in automatico, non manualmente 1 per 1 e non dovendo verificare l'installazione, i package mancanti (per il mio lavoro):
url <- "https://stackoverflow.com/questions/4090169/elegant-way-to-check-for-missing-packages-and-install-them"
browseURL(url, browser = getOption("browser"))
head(installed.packages())
str(installed.packages())
list.of.packages <- c("ggplot2", "Rcpp")   # vettore stringa dei package da installare ("mancanti")
# list.of.packages <- c("Amelia")            # vettore stringa dei package da installare ("mancanti") # --> c'è già --> NULL
(new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])])
# () ad inizio e fine comando R --> SIA il display del risultato a consolle CHE l'assegnazione all'oggetto a dx del comando.
# --> per mettere una coppia di parentesi (tonde, quadre, graffe) intorno ad una porzione di comando (o tutto il comando, come in questo
# caso), si seleziona la porzione di comando interessato (o tutto) e si preme la parentesi aperta (tonda, quadra, o graffa). RStudio
# mette in automatico la relativa parentesi chiusa al termine della porzione di comando stessa ( dell'intero comando).
if(length(new.packages)) install.packages(new.packages)

# problema classico #2: package .... not available
url <- "https://stackoverflow.com/questions/25721884/how-should-i-deal-with-package-xxx-is-not-available-for-r-version-x-y-z-wa"
browseURL(url, browser = getOption("browser"))
# 1 - check spelling (case sensitive in R)
# 2 - check CRAN (being pointed? --> eventualmente switchare a quello di default)
# 3 - available packages
ap <- available.packages()
View(ap)
# 4 - vuoi davvero un package? (o una funzione? o un dataset?)
data() # per la lista dei dataset caricati
# 5 - ci sono le dipendenze?
View(ap)  # colonna 'Depends' (checkbox di 'install package a FALSE?')
# ecc.

# problema classico #3: non si vede la user library
url <- "https://github.com/rstudio/rstudio/issues/11847"
browseURL(url, browser = getOption("browser"))

# problema classico #4: cambiare il path della user library
url <- "https://www.accelebrate.com/library/how-to-articles/r-rstudio-library"
browseURL(url, browser = getOption("browser"))

getOption("defaultPackages") # the packages BASE that are attached ("caricati") by default when R starts up.

search() # Gives a list of attached (cioè "caricati in memoria") packages (see library), and R objects, usually data.frames. (R help)
         # Tells you which packages are loaded and ready to use at at-startup (RIA, 2nd ed., p. 15)

# come si "scarica" (unload) un package da CONSOLLE? (da tab dx "Packages" si può deselezionare il checkbox del package)
detach(ISLR)     # non funziona (perchè ISLR contiene funzioni ed anche dataset??)
detach("ISLR")   # non funziona
# una possibilità è:
unloadNamespace("ISLR") # detach ed unload [so: 6979917] # --> e coerentemente RStudio deseleziona anche il checkbox a dx.

# --> alcuni package, ad es. ISLR, contengono anche dataset (oltre sempre alle funzioni), non tutti!

# la lista di TUTTE le funzioni e dataset di un package si ottiene così:
ls("package:Amelia") # --> lista funzioni
ls("package:ISLR")   # --> solo dataset

# grafico interessante - serve markdown per vederlo
knitr::include_graphics("25 R libaries.png")

# Dataset per partire -----------------------------------------------------

# a. CARICAMENTO dei dataset

library(ISLR)                                    # --> dataset in più (alcuni dei nostri, per questo corso)
data()                                           # --> lista di tutti i dataset disponibili nei package attualmente CARICATI
data(package = .packages(all.available = TRUE))  # --> lista di tutti i dataset disponibili nei package INSTALLATI;
                                                 #     complicato trovare lo specifico dataset, l'elenco NON è assegnabile per poi editarlo con 'View'.

DT::datatable(all_ds)  # funzione e dataset fornito dal MIO script 'Finding a dataset.R'
                       # in particolare, fornisce un box di search (peraltro comunque fornito anche da 'installed_packages')

library(help="ISLR")   # --> vedi anche Indice (contiene i dataset).
data(package="ISLR")   # --> la lista dei dataset di un determinato package.

# b. ora LAVORIAMO con questi dataset

# in questi giorni di corso lavoreremo principalmente con questi dataset:
# da ISLR:
# - Credit: "A simulated data set containing information on 400 (e non 10.000! errore dell'help) customers. The aim here is to predict
#   which will default on their credit card debt" (help R).

class(Credit)  # tipo di dati LOGICO --> il data.frame è l'oggetto R più frequente ed importante (righe per colonne).
               #                         a differenza della 'matrix' (anch'essa righe per colonne) le colonne del df possono essere
               #                         ETEROGENEE come tipo fisico di dato.

mode(Credit)   # tipo di dati FISICO (com'è memorizzato internamente l'intero df).

typeof(Credit) # la versione aggiornata di 'mode' (per consistenza con altri linguaggi OO).



#########################################################################################
# il tipo di dati "logico" è una vista superiore dell'oggetto (vista utente); il tipo   #
# di dati "fisico" descrive la memorizzazione interna ad R dell'oggetto.                #
#########################################################################################

Credit        # tutto il dataframe
head(Credit)  # solo le prime 6 righe
tail(Credit)  # solo le ultime 6 righe
str(Credit)   # 'str' abbreviativo di 'structure'


# - Auto: "Gas mileage, horsepower, and other information for 392 vehicles" (R help)
str(Auto)
head(Auto)

# - Carseats: "A simulated data set containing sales of child car seats at 400 different stores." (R help)
head(Carseats)
str(Carseats)

# questi 3 dataset (Credit, Auto, Carseats) fanno parte del package 'ISLR'.

# normalmente in R - ed in generale nella Data Science e nel Machine Learning - si lavora con un singolo file per volta,
# cioè NON si lavora su un database, composto di molte tabelle.
# R può accedere a qualsiasi tipo di file (txt, xlsx, csv, json, parquet, SQL table, ecc), normalmente si lavora con file CSV
# perchè sono i più agevoli da trattare in R. Tutti i database hanno la funzione di 'export table to csv'.

# un quarto file, preso dal SITO del libro ISLR:
# - Advertising (scaricarlo dal sito ISLR): "Sales of one product in 200 different markets, along with advertising budgets
#   for the product in each of those markets for three different media: TV, radio, and newpaper". (ISLR, p. 15)

# in che directory siamo in questo momento?
getwd()   # get working directory (per default iniziale è la directory alla quale lo script R appartiene)
# come si modifica la directory corrente? in due modi
setwd("C:/")
# il secondo modo: dal menù Session --> Set Working Directory --> To Source File Location (oppure Choose Directory)
setwd("C:/Users/Admin/Desktop/corso R base")

path.name <- "Advertising.csv" # desktop
# path.name <- "C:/Users/W 10 Pro/Desktop/Salvataggio Dati/Documents/Seminari/Data Science (corsi)/Corso R base/Advertising.csv" # desktop
# path.name <- "D:Advertising.csv" # laptop
read.csv("Advertising.csv")
Adv <- read.csv("Advertising.csv")
class(Adv)
head(Adv,10)
tail(Adv)
dim(Adv)
str(Adv)   

# str fornisce anch'essa il numero righe (obs.) e colonne (variables) nella prima riga del suo output.
# tuttavia, il comando 'dim' è molto comodo da usare nel codice; supponiamo di aver bisogno di una variabile numero colonne 
# del dataframe da usare in un loop:
n = dim(Adv)[1]
p = dim(Adv)[2]
n
p

# dal package 'MASS':
# - Boston: "Housing values and other information about Boston suburbs (ISLR, p. 14), based on a 1970 census on 506 districts"
library(MASS)
str(Boston)

# caricamento da file txt:
data<-read.table("edge_file_facebook_matlab v2.txt",header=FALSE)
head(data)

# caricamento file csv grande, con tre importanti argomenti valorizzati:
findata <- read.csv("FinancialIndicators.csv",header=TRUE, sep = ",",nrows=100) # il modo migliore
head(findata)
View(findata)
str(findata)
class(findata)      # data type logico (utente)
typeof(findata)     # data type ficiso (interno R)

# caricamento file su internet
library(readr)      # questo package fornisce la funzione "read_csv"
AirTravel <- read_csv("https://people.sc.fsu.edu/~jburkardt/data/csv/airtravel.csv")
AirTravel

# it’s a small airline passenger dataset, useful for learning about time series and data import in R.
# it’s a classic toy dataset often used in examples.
# Source: Florida State University’s dataset archive.
# Structure: monthly airline passenger counts (in thousands) for international flights.
# Time period: 1958, 1959, 1960.
# Format: rows = months, columns = years.


# Analisi Dati Esplorativa (EDA) - Aspetti principali ------------------------------------------

# Nella Data Science / Machine Learning i due task principali sono:
# - analisi dati esplorativa del file --> vedi png
# - costruzione di modelli predittivi (sui dati del file)

# Lo script "Corso R base - B) Statistica descrittiva.R" contiene una EDA piùcompleta.

Credit
dim(Credit)
str(Credit)
head(Credit)

# subsetting di riga e di colonna (cioè "estrarre" un sottoinsieme di righe e/o di colonne)
# uno dei vantaggi di R (rispetto a Python) è la semplicità del subsetting --> c'è un unico modo standard: [riga,colonna]
Credit[1:10,]          # subsetting di riga (qui le prime 10)
Credit[,1:3]           # subsetting di colonna (qui le prime 3)
Credit[1:10,1:3]       # subsetting sia di riga che di colonna
Credit[1:10,c(1,2,3)]  # equivalente più flessibile
Credit[1:10,c(3,7,9)]  # equivalente più flessibile


# si può fare subsetting anche con i nomi colonna o riga 
Credit[1:10,"Income"]             # l'income dei primi 10 clienti
Credit[1:10,c("Income","Limit")]  # l'income e il limite dei primi 10 clienti

# a differenza di Python, nel subsetting di R se nella parenetsi quadre si specifica solo una dimensione, 
# R intende che sia la colonna (Python intende che sia la riga)
Credit[c("Income","Limit")]

# EDA

# nella EDA con R è importante la mediana
vettore.prova <- c(10,20,30,40,50)
vettore.prova
mean(vettore.prova);median(vettore.prova)   # --> caso fortunato nel quale media e mediana coincidono
vettore.prova <- c(10,20,30,40,500)
mean(vettore.prova);median(vettore.prova)   #  --> la mediana "è robusta rispetto agli outlier, non ne è influenzata"

# vediamo media e mediana sul dataset Credit, colonna Income
mean(Credit$Income)  
mean(Credit[,"Income"])   # equivalente
median(Credit$Income)

# la vista di insieme su tutte le colonne ("str" e "summary" corrispondono alla "describe" in Python)
summary(Credit)

# minimo e massimo
range(Credit$Income)

# vediamo ora un pò di PLOT
plot(Credit$Income,Credit$Balance)   # c'è una leggera correlazione?
cor(Credit$Income,Credit$Balance)    # no

plot(Credit$Income,Credit$Limit)

# dove è visualizzato il plot? nel tab "Plots" a destra
bmp("file_bmp")
plot(Credit$Income,Credit$Limit)
dev.off()

x11()      # apre il sistema di rendering grafico "X Windows" (abbreviato x11), che fornisce delle funzionalità
           # grafiche ulteriori rispetto al tab "Plots"
plot(Credit$Income,Credit$Limit)
x11()
plot(Credit$Income,Credit$Balance)
dev.off()  # chiude X11

# Data type (formati colonne) ---------------------------------------------------------------

# data type FISICI: NUMERICO (intero[INT] o reale [NUM]), CARATTERE, LOGICAL (bool), LISTE (collezioni di oggetti eterogenei) [ed inoltre COMPLESSO (con parte immaginaria) e RAW,
# cioè byte]: si verificano con 'mode' (Kabacoff) oppure con 'typeof' (meglio, secondo Wickham);

# 3 "scalari" (un solo valore, cioè no dimensioni):
a <- 204
b <- TRUE     # memorizzato come 1
c <- "pippo"  # è una stringa (non è un vettore di caratteri --> in R NON c'è il data-type 'char' singolo)

mode(a);typeof(a)

mode(b);typeof(b) # logical --> booleano
mode(c);typeof(c) # stringhe da 1+ caratteri (non c'è un data type 'char' di un singolo carattere)

# - data type LOGICI: scalare (0 dimensioni), vettore (1 dim), matrice (2D, elementi omogenei), array (estensione multi-dim. della matrice, utile
#   per implementare i tensori), data.frame (tabelle 2D), fattori (var. categoriche, cioè insieme finito di possibili valori), ecc. 
#   si verificano con 'class';

# Note:
# - le variabili non devono essere dichiarate; sono create all'assegnazione (weak typing);
# - il punto non ha significato (è un normale carattere e può essere usato nei nomi variabili);
pippo.var <- 1    # standard R
pippo_var <- 1    # standard Python (Unix)

# - per numeric, character, logical, vettori: CLASS = MODE,
# - pathname in Windows con '\' (anzichè '/').

# un vettore ('c' sta per "component"):
c(a,b)
C(a,b)                # non funziona, R è case-sensitive!
c(1:10,5)
seq(from=1,to=10,by=2)
d <- c("pippo","pluto","paperino")    # un vettore di stringhe
length(d)

e <- c("pippo",1)          # un vettore eterogeneo?? 1 è memorizzato come stringa
e
class(e)

A <- c(10:1)
seq(from=10,to=1,by=-1)
seq(to=1,from=10,by=-1)
# nota: è buona regola di programmazione R indicare il nome degli argomenti. R comunque li risolve in modo posizionale, se non indicati.
seq(10,1,-1)
seq(1,10,1)

length(A)    # lunghezza del VETTORE (1 dimensione)
length(c("pippo","pluto"))
length(c(FALSE,TRUE,FALSE))

# il comando 'dim' (che sta per dimensioni) si applica solo agli oggetti bi-dimensionali (matrici, dataframe), NON ai vettori.
dim(A)       # A è un vettore, non un oggetto bi-dimensionale --> non si può applicare la funzione 'dim'.
             # --> NULL, character(0) e numeric(0) sono i tre modi di R per indicare insiemi vuoti (Tardella).
dim(Credit)  # 'dim' applicabile a data.frame o matrici (comunque ogetti bi-dimensionali)

# in altri linguaggi di data science (Matlab e Python) il check delle dimensioni di un oggetto per vettori e oggetti bi-dimensionali
# è lo stesso. in R è differente, e ciò è a volte criticato (il vettore dovrebbe essere trattato come una matrice uni-dimensionale).

# SUBSETTING di vettore, cioè estrazione di una PARTE del vettore:
A[10]        # in [] c'è la componente del vettore che voglio estrarre.
             # gli indici in R partono SEMPRE da 1, non da 0! (a differenza di Matlab e Python)
             # e arrivano a 'n' (e non a 'n-1').

###############################################################################
# in R si usano le () per indicare gli argomenti di una funzione;             #
# invece, si usano le [] per indicare gli elementi di un oggetto (subsetting) #
# e, come vedremo tra poco: le {} (alt+123) per indicare blocchi di codice.   #
###############################################################################

Credit(10,2)   # Error in Credit(10, 2) : could not find function "Credit"
class[a]       # Error in class[a] : object of type 'builtin' is not subsettable     

a[1]
a[2]           # non funziona perchè 'a' è uno scalare

A>5            # una lista di booleani.
               # vediamo in atto la "vettorizzazione" di R (--> applica un test logico a TUTTI gli elementi del vettore, uno per uno).
               # in un linguaggio tradizionale (non di Data Science) questa operazione è eseguita con un loop.

subset(A, A>5) # il subset di componenti di A che soddisfa il test logico (come VALORI).
which(A>5)     # equivalente a 'subset', ma fornisce gli INDICI posizionali (quali componenti del vettore A) e non i valori.
               # R è un linguaggio vettoriale, cioè molte funzioni (non tutte!) lavorano in modo PARALLELO su tutte le componenti del vettore.
               # con un linguaggio non-vettoriale il test precedente deve essere implementato con un ciclo (loop)

any(A>5)       # 'true' se c'è almeno 1 elemento del vettore che soddisfa il test logico.
all(A>5)
all(A[1:5]>5)

A[1:5]         # so che i primi 5 soddisfano la condizione

# combiniamo ora which() con subsetting:
A[which(A>5)]  # alternativa più potente (subsetting con gli INDICI forniti da 'which')
A[A>5]         # idem, senza 'which' --> più semplice, fornisce dirrettamente i VALORI

class(A)        # confonde un pò (nel senso che non c'è indicazione che è un vettore)
B <- 3;class(B) # uno scalare, qual è la differenza con il vettore??
                # seconda inconsistenza: perchè 'numeric' se il dato è un intero?

c(a,b,c)        # vettore eterogeneo, ancorchè tutto in caratteri (è possibile un df eterogeneo, non una matrice eterogenea).
                # R omogeneizza i 3 elementi trasformandone 2 (numero e booleano) anch'essi in stringhe
class(c(a,b,c)) # poco chiaro ... (nel senso di prima):
                # a. ha omogeneizzato tutti gli elementi a stringhe;
                # b. non riporta che è un vettore.

class("pippo")
class(c("pippo","pluto"))

# loop su vettore:
A <- 1:10
for (i in 1:length(A))
  {
  # do something
  }

seq_len(10)   # molto più veloce di '1:length(A)';
              # "I strongly recommend seq_len() over 1:length(). When the day comes that you have a vector of length 0,
              # you'll learn why." (risposta su Code Review a mia domanda)


# I dataframe -----------------------------------------------------------------------------------------------------------------------------------------------------------------

# il data.frame: un dataset m x n, dove:
# m righe: sono le osservazioni (aka, cases, points, record, istanze, ecc);
# n colonne: sono le variabili (feature, predittori, regressori, colonne, ecc)
# Spesso nel Machine Learning il dataframe è dimensionato n x p.

# 1. dataframe costruito per elencazione valori
df <- data.frame(prima.col=c(1:3,NA),seconda.col=4:7)
df
class(df)
mode(df)   # una lista (perchè i 'mode' delle singole colonne possono essere differenti, e il data-type fisico 'lista' consente appunto
           # l'eterogeneità)
View(df)   # 'view' è un'altra funzione!
fix(df)
str(df)    # 'str' sta per 'structure'

length(df) # 2?? perchè rileva 2 vettori verticali (le colonne), ma non è chiaro. - NON USARE
dim(df)    # 'dim' --> dimension
dim(df)[1] # il numero di RIGHE    (il primo elemento del vettore restituito dalla 'dim')
dim(df)[2] # il numero di COLONNE
# in concreto, per compattare il codice e renderlo più comprensibile, una delle prime cose che si fa dopo avere importato 
# su data.frame il nostro file dati (SAS, csv) è di assegnare a due variabili numeriche SCALARI il numero delle righe e 
# quello delle colonne del data.frame; ad esempio:
n <- dim(df)[1]
p <- dim(df)[2]


# 1.1: piccola nota sulle PARENTESI in R:
# nome.funzione ()   --> per le funzioni (dentro ci sono gli eventuali argomenti; 'dir()' ad esempio può non averne).
dim(df) # esempio
# nome.oggetto []    --> per individuare i singoli elementi dell'oggetto data.frame o dell'oggetto vettore o dell'oggetto array (SUBSETTING).
A[10]   # esempio
df[2,2]

# nome.oggetto [[]]  --> per      "           "        "        "        di tipo LISTA.
oggetto.lista <- attributes(df)  # vedi sezione apposita "Attributi" nella parte C) (è R avanzato)
class(oggetto.lista)
oggetto.lista[[1]]

# {} delimita un blocco di codice nei cicli 'for' oppure nelle 'if', oppure anche nella creazione di funzioni (user-defined).
# fine nota sulle parentesi

# nomi righe e colonne del df:
colnames(df)  # i nomi delle colonne del df
names(df)     # idem
rownames(df)  # i nomi delle righe (creati automaticamente per default dal comando 'data.frame')
rownames(df) <- c("A","B","C") # modificabili  a piacere (usate in genere per ragioni documentative --> è una descrizione sintetica
                                # della riga)
df

# rownames are evil. Historically ‘row names’ were used on R to label individual rows in a dataframe. It turned out that this is
# generally a bad idea, because sorting and some summary functions would get very confused and mix up row names and the data
# itself. It’s now considered best practice to avoid row names for this reason. Consequently, the functions in the 'dplyr' library
# remove row names when processing dataframes. [https://benwhalley.github.io/just-enough-r/rownames.html]

# incoerenza di R (criticata), a differenza di Matlab e Python:
a <- 3        # scalare (0 dim)
A <- c(1:10)  # vettore (1 dim)
df            # un dataframe (2 dim)

dim(a)        # non funziona ('a' è uno scalare!)
length(a)     # ok

length(A)
dim(A)        # non funziona con vettori, funziona solo con oggetti 2D

length(df)    # funziona, ma è il numero di vettori colonna
dim(df)       # ok

# --> il limite di R nella gestione degli oggetti multi-dimensionali: vettori e matrici sono trattati differentemente 
#     (con funzioni differenti).

# altri modi per creare un df:
prima.col <- 1:3    # il primo vettore colonna
seconda.col <- 4:6  # il secondo vettore colonna

# modo 2 (modo 1 era la funzione 'data.frame' con l'assegnazione dei valori negli argomenti stessi):
data.frame(prima.col,seconda.col) # binding di due vettori (prima creati) della STESSA dimensione

# modo 3:
df.2 <- cbind(prima.col, seconda.col) # 'cbind' sta per 'column bind' (funziona con dataframe e matrici).
df.2
class(df.2)   # matrice! ('cbind' ha creato una matrice, NON un data.frame, perchè i data-type sono omogenei e la 
              # matrice è più efficiente di un data.frame (Kabacoff 2, p. 551)

df.3 <- as.data.frame(df.2)  # convertitore di formato (da matrice a data.frame)
class(df.3)

is.data.frame(df.2)
is.data.frame(df.3)

# attenzione: matrici e data.frame possono avere metodi OO (S4) / funzioni (S3) DIFFERENTI (in quanto oggetti differenti).

# cbind è utile, ad esempio, per aggiungere una colonna ad un df esistente
df.4 <- cbind(df.3,terza.col=20:22)  
class(df.4)                # è ancora un data.frame, ovviamente (ancorchè i data-type siano omogenei)

# modo 4:
data.frame(matrix(0,nrow=5,ncol=4))  # conversione di formato implicita (da matrice a data.frame)
# cioè:
# - c'è differenza tra la funzione 'data.frame' per creare un df NUOVO e la funzione 'as.data.frame' che CONVERTE un oggetto già ESISTENTE
# - tutte le funzioni R di conversione di tipo iniziano con 'as.'

str(Credit)
class(Credit$Gender)                        # tipo di dati logico 'fattore'
Credit$Gender <- as.integer(Credit$Gender)  # 1/2 anzichè Male/Female
str(Credit)                                 # ora è un intero

data(Credit)                                # 'Credit' è un df preso dal package 'ISLR' (non l'abbiamo creato noi),
                                            # le eventuali modifiche ad esso (che facciamo) sono volatili (non persistenti),
                                            # l'originale è sempre recuperabile con la funzione 'data'.

# attenzione: non confondere:
library(ISLR) # carica in memoria un pacchetto 
require(ISLR) # carica in memoria un pacchetto (equivalente)
data(Credit)  # carica in memoria un dataset

str(Credit)

# modo 5 (so 10689055):
df <- data.frame(Date=as.Date("31/03/2000", format="%d/%m/%Y"),
                 File="", User="", stringsAsFactors=FALSE)
df
class(df)
str(df)

# [il vantaggio di avere una data in formato R "Date" è che le si possono applicare tutta una serie di funzioni di manipolazione dati
# fornite da R base oppure da qualche pacchetto di R contributed (ad esempio: calcola la differenza in giorni tra due date, calcola 
# la data maggiore di 120 giorni della data in input). Queste operazioni NON sono fattibili se la data è in formato alfanumerico.]


# altro punto: aggiungere colonne o righe ad una matrice (oppure ad un dataframe):
df.2
class(df.2)                                                 # una matrice
df.3 <- cbind(df.2,terza.col=c("pippo","pluto","paperino")) 
class(df.3)                                                 # sempre una matrice, ovviamente
df.3                                                        # tutte stringhe!
df.3 <- rbind(df.3,c(80,90,"pluto2"))
df.3

# usiamo ora il dataset 'Credit' (più adatto):
View(Credit)
head(Credit)
head(Credit,10)
tail(Credit,20)

fix(Credit)                # modifica "in-place" (cioè, letteralmente, "sul posto", cioè su copia interna nella memoria di R,
                           # e non sul dataset ORIGINALE). Il comando 'fix' NON agisce mai sul contenuto originale del dataset.
                           # --> per ripristinare il contenuto originale del dataset, fare: 'data(dataset.name)'.
                           # questo comportamento è, da un punto di vista logico, identico a quello di 'fix(object.name)' quando
                           # l'oggetto 'object.name' è stato letto da un file esterno (.csv oppure .txt, ad esempio) tramite
                           # 'read.csv()'  'read.table()'. Anche in questo caso, cioè, il comando 'fix' agisce SOLO e SEMPRE
                           # sull'oggetto nella memoria di R, e non ovviamente sul file esterno. Se, dopo la fix, si vuole
                           # ricaricare l'oggetto con il contenuto originale del file esterno, è sufficiente rieseguire il
                           # comando 'read.csv()' o 'read.table()'.
                           # Se, al contrario, si vuole modificare il file esterno, si fa: 'write.csv()' o 'write.table()'. Non
                           # si può invece modificare il contenuto di un dataset dentro il package.

new.Credit <- edit(Credit) # salva nel nuovo oggetto (salva implicito, attuato tramite la chiusura della finestra)
                           # edit vs fix?? --> so: 34265643

names(Credit)      # i nomi delle variabili (le colonne)
colnames(Credit)   # come 'names'
rownames(Credit)   # le label delle righe (qui sono quelle di default)

# per evitare di dover referenziare le colonne di un dataframe sempre con il prefisso 'nome.df$' si può fare 'attach'
attach(Credit)
head(Income)

# attach è molto comodo:
# attenzione: se nell'environment space creato da noi o da qualche funzione R che è stata caricata in memoria prededentemente 
# in questa sessione corrente (ovviamente con library(package)) ci sono dei nomi oggetti (nomi funzioni, nomi variabili, ecc) UGUALI
# a quello ora "attached", R fa superseeding e prevale l'ultimo attached (lo segnala)

# plot
# R fornisce diversi sistemi grafici: base, lattice, ggplot2 (il più avanzato)
# il sistema grafico 'base' offre molti tipi di plot: scatterplot, istogramma, boxplot

?plot
par(mfrow=c(1,1)) # resetd del device grafico di output ad 1 plot
plot(Credit$Income,Credit$Age,xlab="Income",ylab="Age")                  # scatterplot
plot(Credit$Income,Credit$Age,xlab="Income",ylab="Age",bty="n")          # bty="n" per seguire il consiglio di Tufte.
plot(Credit$Income,Credit$Age,xlab="Income",ylab="Age",cex=0.8,bty="n")  # cex per vedere anche il nome delle ordinate.
                                                                         # cex=character expansion (def. 1).

plot(1:20,1:20,pch=1:20)                                                 # pch = point character (le possibilità di pch).
plot(Credit$Income,Credit$Age,xlab="Income",ylab="Age",pch=16)           # scatterplot
plot(Credit$Income,Credit$Age,xlab="Income",ylab="Age",bg="black",fg="red") # bg e fg del bordo
plot(Credit$Income,Credit$Age,xlab="Income",ylab="Age")                 # il plot base
title(main = "titolo del plot")                                         # sovrascrittura del titolo (ora è una funzione,
                                                                        # nelle precedenti versioni di R era un parametro)
                                                                        # attenzione: deve esserci un plot attivo, altrimenti dà errore.


# abbiamo visto alcuni dei parametri grafici più frequenti ('cex', 'pch'). 
# Per una lista completa dei parametri grafici utilizzabili in TUTTI i comandi plot di R base:
# --> vedi token 'par' (nell'help)

# anzichè fare gli scatterplot a coppie possiamo creare una scatterplot matrix:
plot(Credit)                              # la scatterplot matrix completa
my.vars <- c("Income","Age","Balance") 
head(Credit[my.vars])
plot(Credit[my.vars])                     # la scatterplot matrix limitata alle 3 variabili selezionate

pairs(Credit[my.vars])   # a scatterplot matrix, ie, a scatterplot for EVERY pair of variables in the given dataset

pairs(Credit)   # poco utile (non ben leggibile)

library(GGally)
ggpairs(Credit[my.vars])
# vantaggi di 'ggpairs':
# - molte informazioni compattate in un unico plot (scatterplot, distribuzioni e correlazioni)
# - no ridondanze
# - utilizza il sistema grafico ggplot2 (che è più avanzato del sistema grafico base di R)

# ggpairs calcola le correlazioni di Pearson. Per Spearman e Kendall vedi:
url <- "https://stackoverflow.com/questions/46679059/anyway-to-use-kendalls-tau-c-coef-when-using-ggpairs"
browseURL(url, browser = getOption("browser"))
ggpairs(data = Credit[my.vars], upper = list(continuous = wrap("cor", method = "kendall")));

# accesso al dataset:
Credit$Income
attach(Credit)     # usare con prudenza (mascheramento), perchè il puntamento è sempre all'ultimo dataset attached.

all(Income==Credit$Income)

###############################################################################################################################
# "If you have a variable in your Global Environment that is identical to that in an attached dataset, you will NEVER be able #
# to access and analyse that variable in the dataset. It will ALWAYS find the one in your Global Environment first".          #
# (Larson, 2017, p. 51)                                                                                                       #
###############################################################################################################################

Credit$Income
detach(Credit)     # ricordarsi di farla alla fine elaborazione del dataset
                   # 'detach' è il contrario di 'attach', NON è il contrario di 'library' (vedi prima)

print(as.list(.GlobalEnv)) # Income globale? Vince Income attached


# FINORA abbiamo acceduto a (letto) TUTTI gli elementi del df o della singola colonna.

# subsetting per colonna:
Credit[,6]      # display tabulare --> è un vettore (una colonna singola del df).
Credit[,1]      # la colonna 1 è l'ID riga (presente nel dataset originale - non è il row.name, che è aggiunto da R)

Credit[6]       # display colonnare degli stessi dati (R interpreta l'unico indice come indice di colonna - vedi sotto - , a
                # differenza di python che fa l'opposto.
                # in R l'indice di riga o colonna VUOTO (mancante) significa TUTTI (in altri linguaggi di Data Science si usa '*').

Credit[,"Age"]  #    "        "
Credit[,c(6)]   #    "        "
Credit[,c(2,6)] # formato necessariamente colonnare (perchè richieste due colonne)
Credit[,c("Income","Age")]    # subsetting per nome colonna, molto utile se le colonne sono molte e si ricorda il loro nome.
my.vars <- c("Income","Age")  # alternativa: l'elenco esplicito delle variabili (riusabile)
Credit[,my.vars]

# NB
Credit[my.vars]               # subsetting con una sola dimensione! R capisce che sono le colonne del df (tra doppi apici!) - RIA 2nd ed. p. 84.
                              # in python, invece, l'unica dimensione di un dataframe di pandas è interpretata come righe

# subsetting per riga:
Credit[1,]       # la prima riga effettiva del dataset
Credit["1",]     # subsetting per row.name. qui coincide, ma non sempre!
Credit[c(1,2,89),]
Credit[1:10,]
Credit[c(1,2,3,4,5,6,7,8,9,10),]
Credit[1:10]     # le prime 10 colonne (non le prime 10 righe) --> equivale a 'Credit[,1:10]'.

# subsetting per riga vincolato al suo valore
# alternativa (sempre subsetting per riga! come la clausola 'where' in un comando SQL):
ind <- which(Credit$Age==36) # 'which'  fornisce l'indice di riga (non il valore);
                             # attenzione a '==' (si usa per check, if e subsetting)
Credit[ind,]
# oppure semplicemente:
Credit[Credit$Age==36,]  # subsetting booleano: 'Credit$Age==36' è infatti un vettore di booleani;
                         # tutte le righe le cui colonne hanno Age = 36 è un vincolo di riga (NON di colonna).

Credit[Credit$Age>90,]   # stesso meccanismo (subsetting booleano)

subset(Credit, Age>90 )  # funzione del package 'base' (già vista prima con i vettori)

# il segno '-' esclude righe/colonne:
Credit[-1,]          # con l'indice della riga
Credit[-c(1,2),]     # con l'indice della riga
Credit[,-1]          # con l'indice della colonna
Credit[1:2,-1]       # con l'indice della colonna

##############################
# conferma in ISLR, p. 165.  #
##############################

# [ASIDE: inconsistenza del subsetting di R:

str(Credit)
# OK, siccome:
Credit[,"Income"]     # funziona! allora:
Credit[,-"Income"]    # non funziona purtroppo (piccola incoerenza di R nel subsetting)
Credit[,-c("Income")] # neppure

# --> l'inclusione di righe / colonne funziona sia con subsetting numerico che alfanumerico
# --> l'esclusione di righe / colonne con '-' funziona solo con il subsetting numerico (e non quello esplicito per nome)

# MA: la funzione 'subset' funziona anche per escludere colonne per nome (con il segno -):
subset(Credit[1:2,], select = -c(Income,Age))  # è una funzione di R base 
                                               # (non è subsetting standard, e perciò NON si usano le parentesi quadre)

# La funzione 'subset' può anche essere usata per includere le colonne per nome, ovviamente:
subset(Credit[1:2,], select = c(Income,Age))      

# fine Aside]




# oppure (tornando al problema dell'inclusione di colonne) esiste un terzo modo ancora:
library(dplyr)       # ha molte funzioni di data manipulation (NON è R base, è tidyverse che è un dialetto di R particolarmente
                     # adatto per la manipolazione dei dati)
select(Credit[1:2,],Credit$Income,Credit$Age)

# vedi anche in proposito: https://www.listendata.com/2015/06/r-keep-drop-columns-from-data-frame.html

Credit[,c("Income","Age")][1:10,1] # possibile l'applicazione del subsetting in CASCATA (piping).
                                   # passo1: ho estratto due colonne dal df pieno;
                                   # passo2: dall'output del primo subsetting estraggo una porzione (le prime 10 righe e la prima colonna delle due):

# accesso a SINGOLO elemento:
Credit[2,2]
# accesso a subset di righe e di colonne
Credit[1:10,c("Income","Age")]

# cancellare righe (o colonne); so: 12328056
# "The key idea is you form a set of the rows you want to remove, and keep the complement of that set.
# In R, the complement of a set is given by the '-' operator.[come già sappiamo]
Credit <- Credit[,-c(2, 3)] # con riassegnazione (sovrascrive il df);
                            # è il subsetting di esclusione già visto prima, ma ora con sovrascrittura
Credit
data(Credit)            # per ricaricare l'originale completo di tutte le colonne;
                        # 'data(dataset)' funziona solo per dataset caricati da package.
                        # per gli altri occorre rifare la 'read.csv', 'read.table', ecc.

# nb, non confondere subsetting PRIMA o DOPO $ (stesso risultato, ma logica di subset differente):
Credit[45,]$Income      # 'income' della riga 45
Credit$Income[45]       # l'elemento 45 del vettore 'income' (cioè della riga 45)

# MATRICE:
# "una matrice è un'array 2D nella quale ogni elemento ha lo stesso tipo fisico ('mode'/'typeof'): numerico, carattere, logical" (RIA)
mat <- matrix(0,nrow=5,ncol=4);mat
class(mat)
mode(mat)               # numeric (cioè matrice di numeri)

mat[1,1] * mat[1,2]     # funziona

mat.2 <- matrix("A",nrow=5,ncol=4);mat.2
class(mat.2)
mode(mat.2)             # character (cioè matrice di character)

mat.2[1,1] * mat.2[1,2] # non funziona (giusto, è una matrice di character!)

# aggiungiamo una colonna alfanumerica alla matrice:
(mat.new <- cbind(mat,c("a","b","c","d","e"))) # --> sconsigliabile
class(mat.new)
mode(mat.new)                # è diventata una matrice di stringhe
mat.new[1,1] * mat.new[1,2]  # non si possono moltiplicare stringhe, ora

data.frame(mat)                           # crea un df da una matrice
df.conv <- as.data.frame(mat);df.conv     # converte una matrice a df
class(df.conv)
mode(df.conv)        # i df hanno sempre mode=list, dove ogni elemento della lista corrisponde ad una differente colonna (magari di tipo fisico diverso)
str(df.conv)

df.conv[[1]]         # [[.]] è l'estrattore dell'elemento '.' della lista (qui il primo vettore colonna);
                     # ciò vale per ogni data.frame di R (non solo per quelli convertiti da matrice, come qui)

df.conv$V1           # equivalente
df.conv[,"V1"]
df.conv[2,3]         # sempre valido

# i FATTORI, ora (variabili categoriche --> un insieme di valori FINITO, anche detto DISCRETO, in genere piccolo: 2,3, ...12 ...31):
# il 'fattore' in R normalizza i dati in 3NF (third normal form)  --> risparmio di memoria;
#                                                                     facilitazione degli ordinamenti;
#                                                                     invece, le prestazioni e la manutenibilità dei dati sono penalizzati.

iris                 # famoso dataset floreale usato da Fisher (vedi help)
                     # molti esempi di algoritmi di ML sono fatti con il dataset 'iris'
dim(iris)
str(iris)
table(iris$Sepal.Length)  # le frequenze di una colonna (categorica)
                          # per le frequenze di una colonna numerica è meglio usare 'hist()'.
data(iris)
attach(iris)
levels(Species)      # QUALI sono i livelli del fattore
nlevels(Species)     # QUANTI sono i livelli del fattore

iris[Species=='versicolor',]          # subsetting di riga (--> sottopopolazione)
detach(iris,unload = T)
levels(Species)                       # occorre il nome del df prima!

# es. da RIA, 2nd ed. p. 30 (creazione dei fattori):
patientID <- c(1, 2, 3, 4);patientID
status <- c("Poor", "Excellent","Improved", "Poor") # lo stato di salute dei pazienti
diabetes <- c("Type1", "Type2", "Type1", "Type1")   # i tipi di diabete di vari pazienti (NON i tipi di diabete in assoluto)
class(diabetes)
diabetes <- factor(diabetes)
diabetes <- as.factor(diabetes)                     # equivalente a 'factor'

#####################
# è importante fattorizzare le variabili categoriche se importate dall'esterno come vettori di stringhe (default)
#####################
class(diabetes)

table(diabetes) # le occorrenze per livello del fattore
status <- factor(status,levels = c("Poor","Improved","Excellent"),order=TRUE) # fattore ordinato, cioè con livelli CONFRONTABILI.
                                                                              # (NB. i metodi statistici di R si comportano differentemente se il fattore
                                                                              #  è ordinato!)

table(status)                         # le occorrenze per livello del fattore; 
                                      # MA con l'ordinamento dei livelli (prima "Poor", poi "Improved" ed infine "Excellent")

# [domanda: cosa cambia se il fattore non è "ordinato"? Vediamolo:
status <- c("Poor", "Excellent","Improved", "Poor") # ripristino della lista degli stati.
status.no <- factor(status)
table(status.no)                      # ordinamento dei livelli ALFABETICO, ora (appunto NON ordinato)
                                      # per 'nlevels' alto l'output di questa funzione è meno leggibile
# ]

diabetes
status

# consiglio: in assenza di una motivazione chiara per l'ordinamento conviene fattorizzare senza ordine (il default)

age <- c(25, 34, 28, 52)
patientdata <- data.frame(patientID, age, diabetes, status)
str(patientdata)
summary(patientdata)                 # le info riportate sono differenti a seconda del tipo dati.

# conversione di tipo: 'as.factor()'
vett <- c(1,2,3)
class(vett)
vett.fact <- factor(vett)
class(vett.fact)
levels(vett.fact)
nlevels(vett.fact)

# la discretizzazione di una variabile numerica in un fattore (binning);
# torniamo al nostro dataset reale (Credit):
library(arules)
data(Credit)
Credit$Balance    # variabile numerica, che voglio discretizzare
Credit$Balance <- discretize(x=Credit$Balance,method="fixed",breaks=c(0,500,1000,2000),labels=c("basso","medio","alto"),
                             include.lowest = TRUE)
                             # n labels (qui 3) e n+1 breaks (qui 4)
Credit$Balance
class(Credit$Balance)        # è diventato un fattore (perchè i livelli sono in numero finito)

# il booleano (logical)
frode <- "True"
class(frode)
frode <- as.logical(frode)
class(frode) # non più una stringa, ora sono applicabili gli operatori booleani (and, or, ecc)

# ovviamente, esistono anche altri tipi di dati, meno usati (ad es. 'array', 'complex')


# Cicli ed If -----------------------------------------------------------------------------------------------------------------------------------------------------------------

# esempio che contiene sia for (ciclo) che if annidate (una esterna ed una interna).
# discretizzazione di 'Balance' (0,1,2): cioè suddivisione in 3 fasce di reddito (basso, medio, alto)

# la sintassi:
# - sia la for che la if hanno una condizione da verificare: la for min e max variabile di controllo, 
#   la if quale ramo eseguire
# - la condizione deve stare in parentesi tonde
# - il blocco di codice da eseguire (sia per la for che per la if) sta dentro le parentesi graffe
# - tutto il codice deve essere indentato in modo corretto

# Attenzione alle parentesi (graffe) aperte e chiuse.

data(Credit)
for (i in 1:nrow(Credit)) {                                 # 'i' è la variabile di controllo
                                                            # 'i' varia da 1 a 400 (numero righe di Credit)
                                                            # '1:K' è un range (qui K = nrow(Credit))
                                                            # la parentesi graffa aperta inizia il blocco di codice
                                                            # la then è la parentesi graffa aperta
  
  if (Credit$Balance[i]>500) {     # if-then-else esterna
    
    if (Credit$Balance[i]<1000) {  # if-then-else interna
      Credit$Balance[i] <- 1       # 1 significa 'Balance' tra 500 e 1000
      
    } else {                       # else della if-then-else interna
      Credit$Balance[i] <- 2       # 2 significa che 'Balance' > 1000 
      
    } # fine if-then-else interna
    
  } else {                         # else della if-then-else esterna
    Credit$Balance[i] <- 0         # 0 significa 'Balance' < 500
  } # fine if-then-else esterna
  
} # fine for

# il risultato della for/if:
Credit$Balance
# le frequenze
table(Credit$Balance)    # --> molti balance bassi, pochi alti  

# conferma dai dati ORIGINALI:
data(Credit)
hist(Credit$Balance)   

# secondo esempio banale di ciclo for
# calcolo della somma dei tre numeri 3,2,19
# ciclo 'for' di confronto con il ciclo della introduzione a python di ISLR
total = 0

for (i in c(3,2,19))
  {
    total = total + i
  }
total


# Funzioni custom -------------------------------------------------------------------------------------------------------------------------------------------------------------

# sintassi: 'nome.funzione(lista argomenti)'
# oppure:   ''nome.funzione()' per funzioni che possono non avere argomenti (ad es. 'dir()' oppure 'ls()').
# nome.funzione (senza parentesi) --> il codice interno della funzione (a volte utile da esaminare)

# vediamolo sulle funzioni base (non custom)
ls()

args(nome.funzione) # Displays the argument names and corresponding default values of a function or primitive
args(mean)          # per le funzioni
formals(ls)         # per le primitive (funzioni scrite in C come: ls, length, ecc)

# quasi tutto in R è una funzione
"+"(2,2) # persino gli operatori aritmetici

# definizione della funzione CUSTOM (utente) secondo la solita sintassi:
# - tra parentesi tonde gli argomenti FORMALI della funzione
# - tra parentesi quadre il corpo della funzione
f <- function (x,y,z=1) {      # z=1 di default se non attualizzato alla chiamata della funzione
  result <- x + (2*y) + (3*z)
  return(result)               # il valore della funzione.
  # se 'return' non è presente, il valore della funzione è quello assegnato nell'ultimo statement.
}
class(f)
mode(f)
args(f)       # i nomi degli argomenti ed i valori di default (funzione interattiva)
formals(f)    #   "      "       "            "         "     (funzione programmatica)

x             # non riconosciuto, è locale ad f.

# le CHIAMATE alla funzione con gli argomenti ATTUALI

f(2,3)        #     "        "     "      "          (e default per z)
f(x=2,y=3)    #     "        "     "  nome-argomento (e default per z)
f(x=2,y=3,z=3)#     "        "     "  nome-argomento (z valorizato)
f(z=3,y=3,2)  # gli argomenti z ed y passati per nome, e R assume che il primo argomento non specificato (2) sia x.

# gli argomenti passati per nome possono essere in qualsiasi ordine.
# ciò vale per TUTTE le funzioni R, anche quelle standard (non solo quelle generate dall'utente).
mean(sleep$NonD,,T)  # 8.67 come sopra
mean(na.rm=T,x=sleep$NonD)  # 8.67 come sopra

# attenzione: gli argomenti sono sempre passati per valore, non per referenza (puntatore). dunque R ne crea una copia (problema con big data).

# da lab ISLR (ch.3):
LoadLibraries    # not yet
LoadLibraries()  # not yet
LoadLibraries=function(){
  library(ISLR)
  library(MASS)
  print("The libraries have been loaded.")
}
LoadLibraries
LoadLibraries()

# Note:
# - lista argomenti nell'ordine dell'help oppure nomi argomento espliciti (che aiuta anche la comprensione)
# - output: return oppure ultimo assignment

# problemi?
url <- "https://stackoverflow.com/questions/7027288/error-could-not-find-function-in-r"
# browseURL(url, browser = getOption("browser"))


antonio = 1
