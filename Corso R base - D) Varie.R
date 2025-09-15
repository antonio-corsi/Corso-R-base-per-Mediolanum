# Copyright Antonio Piemontese 2025

# gli ambienti  ------------------------------------------------------------

# environment = workspace (il vecchio termine)

# prima fare:
ls()  # --> 'ls' returns a vector of character strings giving the names of the objects in the
#     specified environment (default .GlobalEnv).
rm(list=ls()) # per cancellare tutti gli oggetti dell'ambiente corrente.
#     rm(ls()) does not work as ls() is NOT a list (class(ls()) --> "character"

# è una gerarchia di ambienti annidati, il top level è .GlobalEnv (può essere reso persistente come già visto).
library(pryr) # "provides tools to pry back the surface of R and dig into the details. It has been developed in conjunction with
              # "Advanced R programming" to make it easier to understand what's going on in R" by Hadley Wickham.
              # sostituisce il precedente package 'parenvs'.

parenvs(all = TRUE)   # --> lista di tutti gli ambienti
parenvs()             # --> l'ambiente corrente

# l'ambiente padre di tutti è base.
# le funzioni hanno propri ambienti (chiusi a fine esecuzione).
# i progetti hanno propri ambienti.


# shortcut da tastiera (per navigazione ed altro)  -------------------------------------------------

# ctrl+alt+#: inizio riga di commento (non eseguita)
# ctrl+shift+n: crea nuovo script
# ctrl+L: pulisce la consolle
# ctrl+F: search/replace (escape per uscire)
# ctrl+1, ctrl-2, ecc: navigazione tra pane (vedi tab 'View')
# ctrl+ / ctrl- per zoom in / zoom out
# alt+-: scrive i 4 caratteri di assegnazione: spazio, <, -, spazio

# funzionano QUASI sempre (ctrl-1 e ctrl-2 SEMPRE)

# per una LISTA Windows vs Mac: --> Verzani p. 33 e 64/65


# running code ------------------------------------------------------------

# 3 modi (da RStudio):
# - Select the lines and press the Ctrl+Enter key (or use the Run toolbar button); or
# - After executing a selection of code, use the Re-Run Previous Region command (or its associated toolbar button) to run
#   the same selection again. Note that changes to the selection including additional, removal, and modification of lines will be reflected in this subsequent run of the selection.
# - To run the entire document press the Ctrl+Shift+Enter or Ctrl+Shift+S (or use the Source toolbar button).

# esecuzione batch:
# - prompt DOS
# - C:/Programmi/R/R.3.6.3/bin/R.exe CMD BATCH (esempio)

# attivare R (stand-alone):
# - da icona desktop / app Windows
# - doppio click su file .Rdata --> seleziona quella cartella come default e carica l'ambiente.

# caratteri speciali ------------------------------------------------------

# --> assegnazione: ' <- ' può essere usato sempre (alt + -, con l'aggiunta di uno spazio), '=' in alcuni casi non funziona (Wickham, p. 67)
X<-rnorm(100)
Y<-rnorm(100)
str(out=lm(Y~X))  # non funziona nelle sotto-espressioni (alt + 126)
str(out<-lm(Y~X)) # funziona sempre (~ significa prevedere Y (a sx) in funzione della X /(a dx))

# backtick: alt+96
# parentesi graffe: alt+123

# anche su Windows, usare sempre '/' nei pathname (e non '\')

# parentesi sincronizzate, tilde, cancelletto, parentesi graffe, seconda parentesi chiusa non presa.
# in R molti caratteri sono a coppie: parentesi di vari tipi e virgolette. Si può disabilitare con
# Tools --> Global Options --> Code --> Editing

# inserire automaticamente doppia parentesi intorno ad un'espressione:
# - doppio click sull'espressione
# - poi premere (

a <- 1+(1+2)


# display valore oggetto:
X
(X<-rnorm(100))
# doppio click sull'oggetto (selezione) e ctrl-enter
# check su pane/tab 'environment'
head(X)     # solo i primi valori

# attenzione: linguaggio case-sensitive.

# search & replace --------------------------------------------------------

# - ctrl-F: cerca in TUTTO le script (oggetti, istruzioni e commenti)
# - selezione parola e poi ctrl-F
# - finestra in alto 'Go to file/function': cerca dentro gli OGGETTI degli script aperti (o del progetto, se c'è);
#   è utilissima --> pop-up window con TUTTE le istanze (non serve 'next').
#

# help --------------------------------------------------------------------

# A) ricerca ESATTA nelle pagine dell'HELP di R (per: funzioni R, dataset, package base o caricati):
# tab "Help" (con topic e subtopic)
help("lm")
?lm # alternativa
# se il package NON è ancora caricato:
help(rlm,package="MASS")

# B) ricerca FUZZY nelle pagine dell'HELP di R  (cioè quando non si conosce il nome esatto):
apropos("^glm")  # --> molto comodo (Verzani, p. 41); "Getting help with R" (https://www.r-project.org/help.html)
help.search("^glm") # ricerca nei package installati

# C) Google!

help.start()  # --> la pagina inziale dell'help

data()        # --> lista di tutti i dataset disponibili nei package attualmente caricati
library(help="ISLR") # --> vedi anche Indice (contiene i datatset)
library(ISLR) # --> dataset in più (alcuni dei nostri, per questo corso)

# per RStudio:
url <- "https://support.rstudio.com/hc/en-us"
browseURL(url, browser = getOption("browser"))

sos::findFn("givens")# http://rfunction.com/archives/2525

search() # Gives a list of attached packages (see library), and R objects, usually data.frames.

# domande su R su siti  ------------------------------------------------

# 1) stackoverflow - thread 'R'

# 2) R devel:
url <- "https://www.r-project.org/mail.html"
browseURL(url, browser = getOption("browser"))

# audience molto ampia, rispondono esperti!
# bisogna solo rispettare le regole di pubblicazione


# loading data -----------------------------------------------------------

# "Today’s data analysts need to be able to access data from a wide range of sources (mainly, database management systems,
# text files, statistical packages, and spreadsheets)".

# molti modi:
# 1) da tastiera (con edit);
# 2) da codice;
# 3) da file (ASCII con 'read.table', XML con il package 'XML');
# 4) da Excel (il modo migliore è da file csv, con 'read.csv');
# 5) dal web (ad es. con 'url');
# 6) da social media (Twitter, Facebook, ecc) e piattaforme web (Google, Amazon, ecc);
# 7) da/verso DBMS (Oracle, SQL Server, DB2, Access, ecc via ODBC o JDBC);
#    two-way communication (ie, we can also update DBMS data); any valid SQL statement can be run against the DBMS;
# 8) da big data platform (ad es. Hadoop, HDF5, ecc)
# 9) da altri pacchetti statistici (ad es. SPSS, SAS, Stata, ecc)
# 10) 'import dataset' sotto tab 'Environment' funziona male, soprattutto con file .csv (Verzani, p. 16).

# vediamo i primi 5 (gli altri sono out-of-scope per questo corso):

# 1) da tastiera:

my.data <- data.frame(eta=numeric(0),sesso=character(0),peso=numeric(0))
my.data <- edit(my.data)  # assegnazione necessaria
class(my.data)
mode(my.data);typeof(my.data)
dim(my.data)
str(my.data)

# 2) da codice:

my.data.txt <- "
eta sesso peso
25 M 74
30 F 56
18 F 60
"
my.data.txt  # \n: vai a capo
my.data <- read.table(header = T,text=my.data.txt) # restituisce un dataframe.
                                                   # 'write.table' è l'opposto ["prints its required argument x
                                                   # (after converting it to a data frame if it is not one nor a
                                                   # matrix) to a file]
my.data
View(my.data) # no edit
edit(my.data) # sì edit

# 3) da file ASCII:
data<-read.table("edge_file_facebook_matlab v2.txt",header=FALSE)
head(data)

# 4) da excel:
findata<-read.csv("FinancialIndicators.csv",header=TRUE) # il modo migliore
head(findata)
str(findata)
class(findata)

# read.csv2 # "they are (almost) the same functions.The only difference is default parameters." (so 22970091)

# 5) da URL

# read.table(url)   # so: 6299220


# PEMDAS ------------------------------------------------------------------

# vedi tutorial di Larson (TDWI Monaco 2017)

url <- "https://www.thecalculatorsite.com/articles/math/how-does-pemdas-work.php"
browseURL(url, browser = getOption("browser"))


# if-then-else ------------------------------------------------------------

# discretizzazione di 'Balance' (0,1,2): esempio di 'for' esterna con dentro due 'if-then-else' annidate.
# Attenzione alle parentesi (graffe) aperte e chiuse.

data(Credit)
for (i in 1:nrow(Credit)) {

  if (Credit$Balance[i]>500) {  # if-then-else esterna

    if (Credit$Balance[i]<1000) {  # if-then-else interna
      Credit$Balance[i] <- 1

    } else { # else della if-then-else interna
      Credit$Balance[i] <- 2

    } # fine if-then-else interna

  } else {  # else della if-then-else esterna
    Credit$Balance[i] <- 0
  } # fine if-then-else esterna

}# fine for

View(Credit$Balance)
table(Credit$Balance)

# cicli 'for' notoriamente non veloci, non abusarne; meglio vettorizzare oppure altre tecniche.

# date ed ore  ---------------------------------------------

# da RIA, 2nd ed.,p.79+:
# - una data è in genere inserita come stringa di caratteri.
# - una data in R è invece rappresentata internamente come il numero di giorni dal 1 gennaio 1970. così
#   si possono fare operazioni aritmetiche.
# - la conversione è fatta dalla funzione as.Date().

mydates <- as.Date(c("2007-06-22","2004-02-13")) # the default input format is 'yyyy-mm-dd' ("%Y-%m-%d")

mydates <- as.Date(c("2007-06-22","2004-02-13"),format = "%Y-%m-%d") # è la stessa cosa

# ci sono vari formati, un elenco è qui:
# https://campus.datacamp.com/courses/intermediate-r-for-finance/dates?ex=6

strDates <- c("01/05/1965","08/16/1975")  #  un altro formato (mm/dd/yyyy).
dates <- as.Date(strDates,"%m/%d/%Y")     #  si codifica così.
                                          #  attenzione, Y maiuscola!

myformat <- "%m/%d/%Y"                    # una volta per tutte, e poi usare questo formato in tutte le conversioni

# una volta che la data è nel formato interno (numerico), si può usare tutto l'arsenale di funzioni R
Sys.Date()   # data corrente
date()       # data-ora correnti

# differenze di date in gg.:
startdate <- as.Date("2004-02-13")
enddate <- as.Date("2011-01-22")
days <- enddate-startdate
days

# intervalli di tempo (espressi in secondi, minuti, ore, giorni, o settimane):
today <- Sys.Date()
dob <- as.Date("1980-01-20")  # una data di nascita
difftime(today,dob,units="weeks")
difftime(today,dob,units="days")
difftime(today,dob,units="mins")

# conversione da formato inerno a stringa (il contrario):
as.character(startdate)

help(as.Date)    # more on this topic.
# i package 'lubridate' e 'timeDate' hanno molte funzioni per la gestione delle date.

as.POSIXct() # Verzani p. 19


# finestre ----------------------------------------------------------------

par(mfrow=c(2,2))  # a vector of the form c(nr, nc)
                   # alternatives: 'layout', 'split.screen'
opar=.....         # per salvare prima i vecchi parametri (da restorare dopo)

data(Credit)
x11(width=10,height=10)              # to open an interactive graphics device
plot(Credit$Balance,Credit$Income)

# grafica -----------------------------------------------------------------

# "A picture REALLY can be worth a thousand words".
# "Modern data analysis increasingly relies on graphical presentations to uncover meaning and convey results."
# "The attractive graphycal results/reports can be distributed to stakeholders and the public.

# R offre la grafica di più alta qualità sul mercato.
# Molti dei grafici statistici che vediamo sui giornali sono fatti con R.
# esempio del NYT:
url <- "https://blog.revolutionanalytics.com/2011/03/how-the-new-york-times-uses-r-for-data-visualization.html"
browseURL(url, browser = getOption("browser"))

# alcune demos (focus deel mouse sulla consolle):
demo(persp)
demo(image)

# alcuni motori grafici di R:
# - base: per grafici statistici, facile da usare; offre grafici predefiniti ed anche custom.
# - package 'lattice': ottimo per dati multivariati; offre grafici predefiniti ed anche custom.
# - package 'ggplot2' (implementa "The Grammar of Graphics" di Wilkinson, scritto da H. Wickham): offre in più grafici attraenti;
#   non è immediato da usare (c'è una grammatica).

# x11(width, height) --> X Window System Graphics
#                        si possono modificare colori, font, background, titoli, ecc (vedi help)

# dati di esempio (dal dataset 'Credit' di ISLR):
library(ISLR)
Credit
str(Credit)
attach(Credit)

# grafici interattivi: 2 funzioni per interagire con i grafici (help R e Verzani, p. 45):
# - A) 'locator': "Returns the position of the graphics cursor (in the "user coordinate system") when the (first) mouse button is pressed;
#   the identification process can be terminated by clicking the second button and selecting ‘Stop’ from the menu, or from the ‘Stop’
#   menu on the graphics window; 'locator' is only supported on screen devices such as X11 and windows.
x11()
n <- 3 # the maximum number of points to locate. Valid values start at 1.
plot(Income,Balance); locator(n,type="p")  # locator is only supported on screen devices such as X11

# - B) 'identity' reads the position of the graphics pointer when the (first) mouse button is pressed. It then searches the coordinates
#   given in x and y for the point closest to the pointer. If this point is close enough to the pointer, its index will be returned as
#   part of the value of the call".
x11()
plot(Income,Balance); identify(Income,Balance)    # --> visualizza label SUBITO
# oppure (senza x11() aperto):
plot(Income,Balance); identify(Income,Balance)    # --> visualizza label a fine processo (escape)

# attenzione: a volte, se non ben terminati, i grafici interattivi lasciano le finestre x11() aperte che non si riescono
# a chiudere a mano, e nemmeno con dev.off. si deve chiudere RStudio.

# pdf() - "it starts the graphics device driver for producing PDF graphics (R help):
pdf("nome.file.pdf")
plot(Income,Balance);
dev.off()

jpeg("nome.file.jpg")
plot(Income,Balance);
dev.off()

# c'è anche 'bmp', 'png', ecc

# grafici 3D: vari modi:

library(scatterplot3d)
scatterplot3d(Income,Age,Balance)    # 3d prospettico

# --> STATIC plots (like the above one) are convenient if one need to compare (and save) many plots.

library(rgl)
plot3d(Income,Age,Balance)           # vero 3d, interattivo

# --> drawback: when you save it, you cannot set orientation.

# grafici parametrici, cioè con "Gui controls" che permettono di manipolare il grafico (Verzani, pp. 46 / 47):
library(manipulate)
dens <- list("Normal"=rnorm,"Exponential"=rexp)
manipulate(
  {
    # plot expression (when evaluated, it produces the desired plot)
    y <- dens[[distribution]](n)
    plot(density(y,bw=bw,kernel=kernel))
    if(addPoints)
      points(y, rep(0,length(y)))
  },
  # define controls
  n=slider(5,100,initial=10),
  distribution=picker("Normal","Exponential"),
  kernel=picker("gaussian","epanechnikov","rectangular","triangular","cosine"),
  bw=slider(.05,2,initial = 1),
  addPoints=checkbox(TRUE,"Add points")
)

# colori:
colors()  # lista colori, settabile nei plot con l’argomento col=intero del colore.

# argomento 'col' = indice (intero), nome, RGB o HSV
plot(Income,Balance,col="brown");
plot(Income,Balance,col=32);

# indice è utile per plot di sottopolazioni,
# col=as.integer(class-type), dove class-type è il fattore target della classe, che internamente
# da R è sempre memorizzato come intero, anche se i suoi livelli (levels(factor)) sono alfanumerici.

# esempio con iris
iris
str(iris)
attach(iris)
levels(Species)
plot(Sepal.Length,Sepal.Width,col=as.integer(Species),pch=16) # help 'par' --> help 'points' --> 'pch values'

# contour plot e heatmap (ISLR, p. 46-47)
x=seq(1,10)  # piccolo excursus sulle sequenze:
x
x=1:10
x
x=seq(-pi,pi,length=50)
y=x
f=outer(x,y,function(x,y)x^2+y^2)        # per ogni punto della griglia (X,Y) questa funzione calcola X^2+Y^2
                                         # su una terza dimensione.
persp(x,y,f)                             # ecco la funzione (convessa)

contour(x,y,f)                           # ed ecco le sue curve di livello (come nelle cartine topografiche);
                                         # i valori più bassi di f sono al centro (funzione convessa)
contour(x,y,f,nlevels=45,add=T)
image(x,y,f)                             # 'image' è come 'contour', ma a colori (heatmap); spesso usata per
                                         # plottare le temperature nelle previsioni del tempo

# attenzione:
contour(Income,Balance,Age)              # --> non ha senso (la terza dimensione non è funzione delle prime due)


# apply functions ---------------------------------------------------------

# RIA, 2nd ed. p. 101; Advanced R, p. 205.

# la funzione base 'apply': applica la funzione indicata agli indici di un'array (cioè una lista con soli valori numerici)
var.num <- c("mpg","cylinders","displacement")
out <- apply(Auto[var.num],2,"mean")  # sd, var, min, max, length, range, ecc
out
class(out);mode(out)

# 'lapply': applica una funzione ad una lista
out <- lapply(Auto[var.num],"mean") # non c'è l'indice e produce una lista (della stessa lunghezza delle colonne del dataset)
out
class(out);mode(out)

# 'sapply': è una versione user-friendly di 'lapply' che restituisce un vettore
out <- sapply(Auto[var.num],"mean")
out
class(out);mode(out)

# data cleaning -----------------------------------------------------------

# Verzani p. 20 per esempi con R base, sennò il package 'plyr'
?plyr


# formatting decimal places -----------------------------------------------

pi
round(pi,2)
options(scipen=99)
options(digits=2)

# la soluzione migliore (so question: 3443687):
format(round(pi, 2), nsmall = 2)


# functions ----------------------------------------------------------------

# sintassi: 'nome.funzione(lista argomenti)'
# oppure:   ''nome.funzione()' per funzioni che possono non avere argomenti (ad es. 'dir()' oppure 'ls()').
# nome.funzione (senza parentesi) --> il codice interno della funzione (a volte utile da esaminare)
ls

args(nome.funzione) # Displays the argument names and corresponding default values of a function or primitive
args("ls")

# quasi tutto in R è una funzione
"+"(2,2) # persino gli operatori aritmetici

# definizione della funzione
f <- function (x,y,z=1){
  result <- x + (2*y) + (3*z)
  return(result)               # il valore della funzione.
  # se 'return' non è presente, il valore della funzione è quello assegnato nell'ultimo statement.
}
class(f)
mode(f)
args(f)       # i nomi degli argomenti ed i valori di default (funzione interattiva)
formals(f)    #   "      "       "            "         "     (funzione programmatica)

x             # non riconosciuto, è locale ad f.

# argomenti passati per posizione (in ordine):
f(2,3)        #     "        "     "      "          (e default per z)
f(x=2,y=3)    #     "        "     "  nome-argomento (e default per z)
f(x=2,y=3,z=3)#     "        "     "  nome-argomento (z valorizato)
f(z=3,y=3,2)  # gli argomenti z ed y passati per nome, e R assume che il primo argomento non specificato (3) sia x.
              # gli argomenti passati per nome possono essere in qualsiasi ordine.
              # ciò vale per TUTTE le funzioni R, anche quelle standard (non generate dall'utente).
              mean(na.rm="True",x=sleep$NonD)  # 8.67 come sopra

f(3,3,2)      # 15 non 17!
              
# attenzione: gli argomenti sono sempre passati per valore, non per referenza (puntatore). dunque R ne crea una copia (problema con big data).

# debug: breakpoint su 'result' --> pointing f(2,3,4) a seguire per i 4 casi.
# alternativa: 'cat' dentro la funzione f? non funziona!

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
browseURL(url, browser = getOption("browser"))

# R on Windows vs R on Mac ------------------------------------------------

# RISORSE:
# shortcut: https://libguides.libraries.claremont.edu/c.php?g=480755&p=3350989
# shortcut: Verzani, p. 33 e 64/65.


# debugging ---------------------------------------------------------------
# (anche da ch. 9 in Hadley Wickham)

# si voglia fare il debug della seguente funzione f prima definita e qui sotto nuovamente:

f <- function (x,y,z=1){
  result <- x + (2*y) + (3*z)
  return(result)               # il valore della funzione.
  # se 'return' non è presente, il valore della funzione è quello assegnato nell'ultimo statement.
}
f(2,3,4)

# RStudio ha un sistema di debugging migliore di quello di R
# codice da debuggare in un nuovo script --> breakpoint --> source
# - rosso pieno = breakpoint attivo
# - rosso vuoto = breakpoint presente ma disabilitato
# - freccia verde = riga corrente dove il codice è fermo in debug
# Si esce dal debug con Q

# Quando in RStudio si mette un breakpoint e poi si fa Source, RStudio non carica la funzione “così com’è”:
# la riscrive aggiungendo dietro le quinte delle istruzioni speciali (simili a browser()), in modo che l’esecuzione possa 
# fermarsi proprio al breakpoint.
# Questa versione modificata del codice è detta appunto strumentata:
# - non è la definizione originale “pulita”, ma una copia con “strumenti di debug” incorporati.

# cioè: differenza fra Source e Run (Ctrl+Enter) in RStudio
# Source (Ctrl+Shift+Enter o bottone Source):
# - RStudio manda l’intero script a R e lo interpreta con il supporto per i breakpoint.
# - I breakpoint rimangono attivi (pallino rosso pieno).
# Run (Ctrl+Enter):
# - Esegue semplicemente le righe selezionate nel Console, come se tu le avessi scritte a mano.
# - In questa modalità RStudio non collega i breakpoint alla funzione → il pallino diventa bordo rosso (disabilitato).
# 👉 In pratica: se riesegui la funzione con Run, stai sovrascrivendo la definizione “strumentata” (con supporto debug) 
# che era stata caricata da Source. La nuova definizione non ha breakpoints associati, e quindi i pallini diventano vuoti.

# --> vedi lo script ad hoc "funzione_debug.R"

# dataset -----------------------------------------------------------------

data() # quelli disponibili (coi package caricati)
library(help="carData")   # lista anche dei dataset disponibili (sotto Indice)
library(Car)
data("Duncan")  # load pacchetto (in 'Car')
Duncan          # lista righe del dataset

# utili dataset:
url <- "https://www.kaggle.com/datasets"          # kaggle
browseURL(url, browser = getOption("browser"))
url <- "http://archive.ics.uci.edu/ml/index.php"  # UCI ML repository
browseURL(url, browser = getOption("browser"))

# differenza tra script R -------------------------------------------------

# vedi so: 36327304

# 1) Meld per Windows (da: http://meldmerge.org/)
# 2) git (da RStudio con Progetti)



# Attributes --------------------------------------------------------------

# Wickham, p. 19-20

# tutti gli oggetti hanno attributi ulteriori relativi ai metadati
# sono come una lista named.
# si può accedere agli atributi singoli con 'attr', tutti insieme con 'attributes'
Y <- 1:10
Y
attr(Y,"my_attribute") <- "Questo è un vettore"
Y
attr(Y,"my_attribute")
Y
str(Y)
str(attributes(Y))


# Ordinamenti -------------------------------------------------------------

url <- "https://stackoverflow.com/questions/54017285/difference-between-sort-rank-and-order"
browseURL(url, browser = getOption("browser"))

sort(c(3, 1, 2, 5, 4),decreasing= TRUE)  # will give c(5,4,3,2,1)
sort(c(3, 1, 2, 5, 4))                   # will give c(1,2,3,4,5)  # i valori

order(c(3, 1, 2, 5, 4))                  # will give c(2,3,1,5,4)  # gli indici (le posizioni)

Credit[order(Credit$Age,Credit$Income),] # ordinamento per due colonne

# Manipolazione stringhe alfanumeriche ------------------------------------

url <- "http://www.cs.uni.edu/~jacobson/4772/week11/R_in_Action.pdf"
browseURL(url, browser = getOption("browser"))
# cercare nel pdf: "character functions" (p. 122)
