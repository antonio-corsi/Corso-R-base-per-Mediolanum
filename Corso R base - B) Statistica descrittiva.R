
# statistica descrittiva (analisi esplorativa dei dati) --------------------------------------------------

# la parte del corso più importante: prima di PREVEDERE occorre CAPIRE i propri dati.
# grande quantità di statistiche disponibili in R (base o contributed).

library(ISLR)
X <- Credit$Income   # variabile numerica continua (reale)

# misure di CENTRATURA: mean, median

mean(X)                    # --> 45.22 (sensibile agli outlier)
sum(X)/400                 # stesso risultato

vet.es1 <- c(1,2,3,4,5)
vet.es2 <- c(1,2,3,4,100)
mean(vet.es1)
mean(vet.es2)

median(vet.es1)
median(vet.es2)
vet.es3 <- c(1,2,3,4)
median(vet.es3)            # 2 posizioni centrali uguali ("tie": legami) --> la loro media

median(X)                  # più "robusta" (è una metrica posizionale)
X

# misure di variabilità
sd(X)                      # la deviazione standard --> 35.24
sd(vet.es1)
sd(vet.es2)                # perchè influenzata dall'outlier 100

var(X)
sd(X)^2
sqrt(var(X))               # la varianza è semplicemente il quadrato della sd, ovvero, la sd è la radice quadrata POSITIVA
                           # della varianza.
                           # la varianza NON è espressa nella unità di misura dei dati, e ciò è spesso un problema.

mad(X)                     # median absolute deviation (più robusta agli outlier).
mad(vet.es1)
mad(vet.es2)
                           # bottom-line: 'mad' è l'equivalente per le metriche di variabilità della 'mediana' nelle metriche
                           # di centratura

# esempio di radici:
sqrt(9)                    # --> fornisce la "principal square root" (vedi help R), cioè la sola radice quadrata positiva.

sd(X)/mean(X)              # CV (Coefficiente di variazione) --> tra 0 e 1 --> qui molto alto.
                           # in generale, è possibile calcolare il CV perchè la 'sd' ha la stessa unità di misura dei dati!
x11()
hist(X,breaks = 20)        # alta variabilità (qui rilevata tramite un istogramma, cioè un grafico delle frequenze).
                           # 'breaks' è il numero di BIN, R di default ne sceglie uno adatto al dataset.
                           # Regole pratiche di scelta numero 'breaks' ottimale:
                           # - la radice quadrata di n (il numero di osservazioni, cioè di righe) --> maggiore del default;
                           #   sqrt(length(X))=20 (il valore usato qui da me, infatti);
                           #   vedi ad esempio: "https://www.statsandr.com/blog/outliers-detection-in-r/"
                           # - prof.ssa Vicario: 1 + (10/3) * log10(n), dove log10 è il logaritmo in base 10 [in R usare la
                           #   funzione 'log10()'] ed n è il numero di osservazioni (Vicario, p. 105); QUELLO di 'hist'?!
                           # - prof. Brandimarte: min. 5 - max. 20, mai classi vuote;

                           # l'argomento 'freq' di 'hist' è importante:
                           # TRUE (il default) visualizza in ordinata le frequenze ASSOLUTE (il loro conteggio);
                           # FALSE visualizza in ordinata le frequenze RELATIVE, ovvero la base per stimare le probabilità
                           # (in modo frequentista), in modo tale che l'intera area dell'istogramma ha somma 1.


bin.vicario <- round(1 + (10/3 * log10(length(X))),0);bin.vicario # [la funzione 'round(X,0)' arrotonda all'intero più vicino]
hist(X,bin.vicario)        # lo stesso numero di 'hist'?!

hist(X,freq=F,breaks = 20) # osservate come l'asse delle X riporti solo alcuni valori di riferimento (50,100,150) --> R infatti è
                           # minimalista, mostra sempre il minimo delle informazioni, le altre, un'infinità volendo, si ottengono specificando
                           # esplicitamente alcuni argomenti. Nel prossimo corso vedremo diversi altri esempi di questo minimalismo di R.

# 2 tipi di istogramma, come detto prima:
hist(X)                    # in ordinata ci sono le frequenze assolute
hist(X,freq=F)             # in ordinata ci sono le frequenze relative (cioè le frequenze assolute divise per la dimensione
                           # del campione, qui 'length(X)'), che costituiscono una stima (frequentista) delle probabilità.

# sovrapposizione all'istogramma di una curva "LISCIA" (smooth): è una "stima kernel" della PDF, non-parametrica (RIA, 2nd ed, p. 127).
lines(density(X),col="red",lwd=3) # le densità sono la stima della probabilità di X (Income) calcolata in base alle frequenze RELATIVE.
plot(density(X))                  # le densità sono calcolabili a prescindere dall'istogramma (discreto, strutturato bins) e quindi plottabili
                                  # indipendentemente.
                                  # però, se voglio plottare le densità SOPRA l'istogramma, esso deve essere stato creato con freq=F.


# --> sezione finale su "variabilità" (dimensione del campione)

# funzione di sintesi:
sum(X)
min(X)
max(X)
range(X)         # min e max
summary(X)       # già vista

# R base NON fornisce le funzioni: MODA (valore più probabile) e le due misure di SHAPE (skewness e curtosi)
# opzione a): si possono creare (vedi fondo - sezione apposita)
url <- "https://codeburst.io/2-important-statistics-terms-you-need-to-know-in-data-science-skewness-and-kurtosis-388fef94eeaa"
browseURL(url, browser = getOption("browser"))

mean(X)
median(X)
Mode(X)  # definita nella sezione 'statistiche mancanti in R base'

url <-  "https://www.excelr.com/skewness-and-kurtosis"
browseURL(url, browser = getOption("browser"))

my.vars <- c("Income","Age","Balance")
round(sapply(Credit[my.vars],mystats),3)   # la funzione 'mystats' è definita nella sezione 'statistiche mancanti in R base'.
                                           # --> le ultime due righe dell'output riportano skewness e kurtosis:
                                           #     a) le tre distribuzioni (delle tre variabili) sono skewed (assimetriche)
                                           #     verso dx (valori positivi della skewness), in particolare 'Income' e 'Balance'
                                           #     come si può vedere dai rispettivi istogrammi. 'A ge' lo è pochissimo.
                                           #     b) 'Income' ha un picco (curtosi) più alto della gassiana (perchè valore positivo),
                                           #     le altre due variabili sono un pò più piatte della gaussiana (perchè valore negativo).

                                           #     Quest'ultima cosa si può vedere così (per 'Income'):

X<-Credit$Income
hist(X,freq = FALSE,breaks=30)
xfit <- seq(min(X),max(X),length=40)       # la griglia di valutazione
yfit <- dnorm(xfit,mean=mean(X),sd=sd(X))  # le densità gaussiane corrispondenti alla griglia (con quei parametri)
lines(density(X),col="blue")               # la linea "smooth" sovraimposta
lines(xfit,yfit,col="red")                 # la gaussiana sovraimposta (più bassa, in effetti)

# opzione b) usare qualche pacchetto:
library(psych)   # un package con molte funzioni utili
describe(X)      # contiene anche skewness e curtosi [vedi libro su R nel Marketing]

# [funzioni matematiche (funzionamento vettoriale)]:
sqrt(X)   # radice quadrata
X^2       # elevamento a potenza
log(X)    # logaritmo
url <- "https://towardsdatascience.com/overview-of-40-mathematical-functions-in-r-4b4e138685ff"
browseURL(url, browser = getOption("browser"))
# ecc --> vedi anche qualche cheatsheets su google]

range(X)
summary(X)
quantile(X)       # come 'summary'
                  # ci sono molti modi di calcolarli (vedi help R), leggermente differenti (vedi argomento 'type')
                  # european quantile: Pr[X <= q]; american quantile: Pr[X > q]

q.40 <- quantile(X,0.4)   # il "quantile", a volte anche detto "percentile" (so 156778), è UN VALORE SPECIFICO della X (è un income);
q.40                      # --> cioè, il 40% delle osservazioni ha valore di Income <= 27.81
                          #     e quindi il restante 60% delle osservazioni ha valore di Income > 27.81

hist(X,breaks = 30)
abline(v=q.40,col="Red",lty=2,lwd=3)   # funziona SOLO sopra un grafico già prodotto

fivenum(X)        # "returns Tukey's five number summary (minimum, lower-hinge, median, upper-hinge, maximum)"

plot(ecdf(X))     # la CDF empirica --> conferma graficamente che un valore di Income intorno a 27.81 lascia alla sua sx il 40% delle obs.
                  # In generale, la CDF (Cumulative Distribution Function) riporta in ordinata la Prob(X<=X.k), dove X.k è un valore dato
                  # in ascissa.

# funzioni grafiche di una variabile numerica:
par(mfrow=c(1,2)) # divide la finestra in due
boxplot(X,outline = T)        # --> la distribuzione campionaria, con varie evidenze.

url <- "https://quantgirl.blog/anatomy-of-a-box-plot/"
browseURL(url, browser = getOption("browser"))   # l'utilità del boxplot e come interpretarlo

# uno dei vari scopi del boxplot è di vedere gli outlier;
# cos'è un outlier? varie definizioni: in statistica descrittiva è un'osservazione ai limiti del range di valori;
# ad esempio:
c(quantile(X,0.25)-1.5*IQR(X),quantile(X,0.75)+1.5*IQR(X)) # un outlier è oltre Q1-1.5*IQR e Q3+1.5*IQR
c(mean(X)-3*sd(X),mean(X)+3*sd(X))                         # un outlier è oltre -3sigma e + 3sigma (più conservativo)

hist(X)           # distribuzione assimmetrica (non gaussiana)
par(mfrow=c(1,1)) # restore del layout grafico UNICO
# --> presenza di outlier (confermati) e non-gaussianità IMPEDISCONO l'applicazione di diversi metodi di Machine Learning.
# [more on outlier è nel corso R avanzato]

# Income è gaussiana?
shapiro.test(X)   # test di gaussianità --> no, X NON è gaussiana (perchè p.value < 0.05)
                  # 2.2 * 10^-16 = 0 del computer a doppia precisione

par(mfrow=c(1,2))
hist(X,breaks = 30)
# come gaussianizzare X?
X.log <- log(X)               # compatta il range e rende la distribuzione più simmetrica
hist(X.log,breaks = 30)       # molto più simmetrica!
shapiro.test(X.log)           # il test è molto sensibile, rifiuta perchè X NON è proprio gaussiana

par(mfrow=c(1,2))
hist(X,main = "istogramma",breaks = 50)     # frequenze (RILEVATE dal campione)
d <- density(X)                             # la forma
plot(d,main="stima kernel della distribuzione di income")  # a sx del min(income) STIMA la forma della funzione
polygon(d,col="red",border="blue") # sovrascrive
rug(X,col="brown")                 # sovrascrive
par(mfrow=c(1,1))


# nota su standardizzazione ---------------------------------------------------------------------------------------------------------------------------------------------------

# molto usata nella Data Science con R
data(Credit)
X <- Credit$Income
Y <- Credit$Age

(X.std <- scale(X,center=T,scale=T))  # standardizazione, cioè: centratura e rescaling (ovvero diviso per la dev. std);
                                      # i due attributi riportati in coda sono media e varianza originali;
                                      # gli attributi sono anche visibili con 'attributes(object.name)'.

hist(X.std)
mean(X.std)                           # 0 (-2.9142e-18 = -291.42e-16)
sd(X.std)                             # 1 (è sempre lo scaling DOPO la centratura - vedi help R)

# diverse tecniche di ML richiedono che i dati siano standardizzati:
# - l'inferenza (altro corso)
# - quando si calcolano "distanze" (ad es. KNN, PCA, clustering, FA, ecc)
# - ecc

# uno dei grandi vantaggi della 'standardizzazione' è di poter CONFRONTARE distribuzioni differenti; esempio:
par(mfrow=c(1,2))
hist(Credit$Income)
hist(Credit$Age)
par(mfrow=c(1,1))
par(mfrow=c(1,2))
hist(scale(Credit$Income))
hist(scale(Credit$Age))
par(mfrow=c(1,1))
# --> vediamo qui chiaramente che la variabilità di 'Income' è di -1sd / +4sd, molto maggiore di quella di 'Age',
# che è di -2sd / + 2sd.
# Un'informazione SIMILE la posso ottenere con 'range'.


# attenzione: spesso si usa (impropriamente) il termine 'normalizzazione', che invece è la
# la trasformazione dei dati in gaussiani.

# centratura:
X.std <- scale(X,center=T,scale=F) # solo centratura (cioè uno shift)
mean(X.std)                        # --> e-16 è 0 al computer
sd(X.std)                          # quella originale
scale(X,center=T,scale=F)          # riporta in coda solo il centro originale! (la sd non è cambiata)

# rescaling (caso articolare):
X.resc <- scale(X,center=F,scale=T) # solo rescaling
mean(X.resc)                        # 0.78
sd(X.resc)                          # 0.61

x11()
par(mfrow=c(2,2))
hist(X)
hist(Y)
hist(scale(X,scale=T))              # 'hist' dei dati riscalati (cioè divisi per la sd)
hist(scale(Y,scale=T))

# "When data is rescaled the median, mean(μ), and standard deviation(σ) are all rescaled by the same constant."
# https://www.statisticshowto.com/what-is-rescaling-data/

# "The root-mean-square for a (possibly centered) column is defined as sqrt(sum(x^2)/(n-1)), where x
# is a vector of the non-missing values and n is the number of non-missing values. In the case center = TRUE,
# this is the same as the standard deviation, but in general it is not. (To scale by the standard deviations
# without centering, use scale(x, center = FALSE, scale = apply(x, 2, sd, na.rm = TRUE)).)

# destandardizzazione (anch'essa vettoriale):
X.destd <- (X.std * sd(X)) + mean(X)
# verifica:
head(X.destd,10)
head(X,10)
# fine NOTA su standardizzazione]


Y <- Credit$Gender   # una variabile categorica
class(Y)
levels(Y)
table(Y)
summary(Y)           # uguale a 'table(Y)'

# statistiche su DUE variabili numeriche:

X.1 <- Credit$Income
X.2 <- Credit$Age

cov(X.1,X.2)         # valore assoluto, non diviso per le sd delle due variabili;

cor(X.1,X.2)         # in genere più utile della covarianza, perchè confrontabile tra variabili;
                     # per default, il comando 'cor' usa il metodo di Pearson;
                     # la correlazione è semplicemente la covarianza standardizzata --> un numero tra -1 e 1,
                     # dove 0 --> non-correlazione, +1/-1 --> massima correlazione (l'intensità correlazione);
                     # |cor| > 0.5: interessante; |cor| > 0.7: alta (dipende dal dominio: nel "socio-demografico
                     # correlazioni in genere più basse; nei domini scientifici-ingegneristici correlazioni più alte,
                     # mondo finance: via di mezzo);
                     # correlazione positiva (>0) --> le due variabili crescono OPPURE diminuiscono INSIEME;
                     # correlazione negativa (<0) --> al crescere di una variabile, l'altra decresce, o viceversa;
                     # metodi di calcolo della correlazione (argomento 'method'): Pearson (default), Spearman (più "robusta"
                     # perchè usa le posizioni (ranking) anzichè i valori, ed in grado di misurare anche le relazioni non-lineari);
                     # la correlazione INDICA ASSOCIAZIONE tra le due variabili, NON CAUSA-EFFETTO!
                     # --> Vedi il libro "How to lie with statistics" di Darrell Huff (1954).
                     # la regressione si fa, poi, quando c'è causa-effetto! [Vicario].
                     # nella esplorazione dei dati la correlazione si misura su una COPPIA di variabili (numeriche). Nella
                     # regressione, che è una tecnica di previsione che vedremo nel prossimo corso, si misura anche la
                     # possibile correlazione tra molte variabili, che prende il nome di "multi-collinearità".

cor(X.1,X.2,method = "spearman")  # la correlazione calcolata in modo "robusto agli outlier", cioè con le posizioni anzichè i valori;
                                  # inoltre, individua anche relazioni non-lineari.
x11()
plot(X.1,X.2,col="black")  # si chiama 'scatterplot'
X.1.jit <- jitter(X.1)     # "add a small amount of noise to a numeric vector." Evita (l'eventuale, non qui) overlap dei punti
X.2.jit <- jitter(X.2)
points(X.1.jit,X.2.jit,col="red") # 'points' stampa SOPRA un plot già aperto (altre funzioni così, es. 'lines')

# un grafico interattivo (vedi altri in seguito):
x11()                             # eseguire l'intero blocco di istruzioni - X11 toglie il focus all'editor!
                                  # x11 crea un nuove device grafico, dimensionabile con gli argomenti 'width' e 'height'
plot(X.1,X.2);identify(X.1,X.2)   # individuazione punti,
                                  # si esce dal plot con escape.
                                  # si ferma l'identificazione punti con il bottone 'stop'
dev.off()                         # chiude la finestra

?Devices()           # lista dei devici grafici disponibili - ne abbiamo già visti alcuni

var.num <- c("Income","Limit","Rating","Cards","Age","Education","Balance")
cor(Credit[var.num])              # matrice di correlazione (difficile visivamente da controllare!)

library(corrplot)
corrplot(cor(Credit[var.num]),type="upper",method="ellipse")
                                             # la matrice di correlazione è sempre SIMMETRICA, per definizione,
                                             # cioè se si scambiano righe e colonne si ottiene la stessa identica matrice;
                                             # dunque è sufficiente visualizzare la matrice triangolare superiore
                                             # (od inferiore).
                                             # più l'ellisse è allungata maggiore è l'intensità della correlazione.
# si vede una fortissima correlazione tra 'Limit' e 'Rating' ed una forte tra 'Balance' e 'Limit'
cor(Credit$Limit,Credit$Rating)   # 0.99!
cor(Credit$Limit,Credit$Balance)  # 0.86

# tre errori tipici:
# 1) x11 è rimasto aperto (cioè non avete fatto 'dev.off()') --> il nuovo grafico è visualizzato nel device grafico x11

# 2)
corrplot(Credit)           # la correlazione tra 2 variabili categoriche (o tra una variabile categorica ed una numerica) non ha senso.

# 3)
corrplot(
  Credit[var.num])
# si deve applicare la funzione 'corrplot' alla matrice delle correlazioni, non al dataframe originale!

# un'alternativa al "correlation plot" è il "correlation gram" (stesso scopo):
library(corrgram)
corrgram(Credit[var.num],order=T,lower.panel=panel.shade,upper.panel=panel.pie,main="Correlation gram di Credit")
                   # la parte bassa si interpreta così:
                   # - una cella blu con diagonali dal basso all'alto indica correlazione positiva;
                   # - una cella rossa con diagonali dall'alto al basso indica correlazione negativa;
                   # - l'intensità del colore (rosso o ble) indica l'intensità della correlazione (da 0 a 1, oppure da 0 a -1);
                   #   la parte alta si interpreta così:
                   # - l'intensità della correlazione è data sia dal colore che dalla dimensione della fetta colorata

# esempio APPLICATIVO (finanziario) dell'utilità delle correlazioni 
# (dal libro "Statistic@online" di Bollani e Bottacin, p. 206)

library("openxlsx") # fornisce la funzione 'read.xlsx' (non disponibile in R base)
# per la lettura in R di file excel vedi:
url <- "https://www.r-bloggers.com/2021/06/reading-data-from-excel-files-xlsxlsxcsv-into-r-quick-guide/"
browseURL(url, browser = getOption("browser"))

data <- read.xlsx(xlsxFile = "C:/Users/Utente/Desktop/salvataggi/SALVATAGGIO DATI/Documents/Seminari/Data Science (corsi)/Corso R base (iCubed - Banca di Asti, RMA)/Correlazione.xlsx")
# i dati sui REATI di riciclaggio scoperti e denunciati nel 2016 sono forniti dall'ISTAT.
# i dati degli SPORTELLI nel 2016 sono forniti da Banca d'Italia,
# i dati sul numero di segnalazioni di operazioni sospette (SOS) nel 2016 sono forniti dalla UIF (Unità di Informazione
# Finanziaria)
# X = reati / sportello: numero medio per sportello di reati di riciclaggio denunciati nel 2016
# Y = SOS / sportello: numero medio per sportello di SOS nel 2016

dim(data)
str(data)
View(data)

cor(data$X,data$Y) # --> 0.68
                   #     cioè nel 2016 c'è stata una correlazione positiva tra reati denunciati (per sportello)
                   #     e SOS (per sportello); ciò conferma che, se la correlazione è confermata negli anni
                   #     successivi, le SOS sono uno strumento efficace nell'anti-riciclaggio.


# statistiche/funzioni su due variabili categoriche:
X <- Credit$Gender
Y <- Credit$Student
cov(X,Y)             # --> NO!
table(X,Y,useNA = "ifany")           # tabella a doppia entrata (two-way table);
                                     # è una tabella di contingenza a 4 valori (aka, tetracorica - Wikipedia)
                                     # ['useNA = "ifany"' rimuove eventuali MV]
addmargins(table(X,Y))
addmargins(table(X,Y),FUN="min")    # la colonna margine può riportare varie funzioni (vedi help)

plot(X,Y)

# il test chi-quadrato di Pearson
# [MATH. se due eventi sono indipendenti, la loro frequenza CONGIUNTA è il prodotto delle frequenze MARGINALI]
chisq.test(X,Y)       # H0: indipendenza;
                      # accetto, sono indipendenti (p.val alto per qualsiasi alpha);
                      # non dà l'intensità della eventuale dipendenza, come invece fa la correlazione
                      # (servono altre tecniche, come gli "odds ratio")

# --> sul test chi-quadrato vedi le slide apposite nel corso OEC016

# un'alternativa alla correlazione per le variabili categoriche è la cross-tabulazione (Jank):
library(gmodels)
CrossTable(X,Y)                      # cell contents in alto:
                                     # N: frequenza congiunta assoluta
                                     # N/Table Total: frequenza congiunta relativa
                                     # "chi-square distribution" è il contributo di quella cella al valore della statistica chi-square.
                                     # N/Row Total e N/Col Total sono le frequenze condizionate; non confonderle con le
                                     # frequenze marginali (riportate sui totali di colonna e di riga):

url <- "http://progettomatematica.dm.unibo.it/StatisticaDescrittiva/StatisticaDescrittiva/cap5.html"
browseURL(url, browser = getOption("browser"))

library(vcd)
assocstats(table(X,Y))               # l'intensità della dipendenza, misurata con 3 differenti "indici di connessione";
                                     # qui indici bassi.
                                     # il termine "indice di connessione" è dello statistico italiano Corrado Gini.
                                     # la connessione è concetto ampio, adattabile anche a due variabili numeriche;
                                     # poichè tuttavia le variabili numeriche possono essere ordinate, si può
                                     # calcolarne media e deviazioni, ecc, si preferisce calcolarne la correlazione
                                     # (anzichè appunto la connessione).
                                     # per il calcolo degli indici di connessione (ad es. il chi-quadro) --> vedi prossimo corso

# statistiche  su due variabili (una numerica ed una categorica):
X <- Credit$Income   # variabile numerica continua
Y <- Credit$Student
cov(X,Y)             # --> NO!
cor(X,Y)

plot(X,Y)

# --> boxplot appaiati ed ANOVA (prof. Tardella, La Sapienza, 2-a giornata)

# funzioni su tre variabili categoriche:
X <- Credit$Gender
Y <- Credit$Student
Z <- Credit$Married
table(X,Y,Z)                         # frequenze congiunte


# funzioni sinottiche (agiscono su ALCUNE/TUTTE le colonne)
my.vars <- c("Income","Age","Education","Balance")
colMeans(Credit[my.vars])
x11()
par(mfrow=c(2,2))
boxplot(Credit[my.vars])         # sd troppo diverse tra loro:
apply(Credit[my.vars],2,sd)
boxplot(scale(Credit[my.vars]))  # sd ora confrontabili, perchè dati riscalati

library(GGally)
ggpairs(Credit[my.vars]) # output molto informativo
library(Hmisc)
describe(Credit[my.vars])

# esame delle relazioni tra 3+ variabili categoriche (RIA, 2nd ed., p. 276-278)
library(vcd)
my.var <- c("Education","Gender","Student")
ftable(Credit[my.var])  # --> l'output è ordinato secondo il vettore di variabili fornito

mosaic(~Education+Gender+Student,data=Credit,shade=T,legend=T)

# prima di interpretare questo grafico estremamente informativo, ne esaminiamo uno analogo, dal famoso dataset 'Titanic':

str(Titanic)   # --> fornisce il numero di passeggeri sovravvissuti o morti, cross-classificati per Classe (1-a, 2-a, 3-a,
               #     equipaggio), sesso (uomo, donna), età (adulto, bambino).

mosaic(Titanic,shade = T)
               # deduzioni dal grafico (si devono considerare le altezze RELATIVE a sx, a dx, in basso ed in alto):
               # - l'equipaggio era il più numeroso, seguito dalla terza classe; la prima classe era la meno numerosa;
               # - l'equipaggio era composto in grande maggioranza da uomini e praticamente tutto da adulti (tranne poce eccezioni);
               #   le classi con più bambini erano la terza e la seconda, quella con più donne la prima;
               # - la maggior quantità di deceduti si è avuta tra l'equipaggio, che si è evidentemente molto sacrificato, ed a
               #   decrescere in base alla classe: i più ricchi si sono salvati in maggior numero;
               # - donne e bambini si sono salvati molto più degli uomini, como noto dalle cronache, ma comunque di più nelle classi
               #   alte (prima e seconda)
               # --> il colore BLU indica che quella cross-classificazione è risultata più numerosa di quello che ci si sarebbe
               #   potuto attendere se le variabili fossero indipendenti; il colore ROSSO, all'oppopsto, indica che quella
               #   cross-classificazione è risultata meno numerosa di quello che ci si sarebbe potuto attendere se le variabili
               #   fossero indipendenti.

example(mosaic)  # vari possibili layout con differenti dataset


# ora, esaminiamo nuovamente il grafico mosaic per i dati categorici di 'Credit':
mosaic(~Education+Gender+Student,data=Credit,shade=T,legend=T)
               # --> l'assenza di colori ci testimonia che le frequenze osservate sono abbastanza vicine a quelle che avremmo
               #     con variabili indipendenti. Confermato dalle altezze relative.

# funzioni di gruppo (RIA, 2nd ed. pp. 142+)
# - aggregate
# - by (simile al comando SQL 'group by')
# --> agiscono sui gruppi di righe aggregate (anzichè sulle righe singole)

# variabilità -------------------------------------------------------------

library(ISLR)

X <- Credit$Income
sd(X)   # con 400 osservazioni!

# NB. la standard deviation è sempre > 0! (in particolare, non è MAI negativa).
# La sd PUO' essere uguale a zero SOLO SE il campione estratto è costante.

# Il termine "standard deviation" è stato introdotto in statistica da Pearson nel 1894 assieme alla lettera greca sigma
# che lo rappresenta.

# sd calcolata dalla funzione R e, per confronto, manualmente (a passi) con la formula (Wikipedia IT)
sd(X)                         # --> 35.24
scarti <- X-mean(X)           # --> il vettore degli scarti (nella formula: Xi - X-bar)
scarti.quad <- scarti^2       # --> il vettore deglli scarti al quadrato (nella formula l'apice 2) 
ssr <- sum(scarti.quad)       # --> il numeratore della formula (in gergo statistico SSR = Sum of squared Residual) 
(X.var <- ssr/(length(X)-1)) 
(X.std <- sqrt(X.var))        # --> 35.24

# la funzione 'sd' divide per n-1 gradi di libertà:
sqrt(sum(scale(X,center=T,scale=F)^2)/(length(X)-1)) # formula della deviazione standard (vedi Wikipedia):
# la radice quadrata della somma degli scarti al quadrato divisi per n-1.
# n-1 è un aggiustamento numerico (perchè la media della popolazione è stata stimata con la media campionaria,
# e quindi si è perso un grado di liberta - i gdl sono le osservazioni).
# attenzione nei piccoli campioni! --> /n oppure /n-1 è ben diverso!

# 'scale(X,center=T,scale=F)' equivale a 'X-mean(X)'.
# NB. il suriportato comando illustra il funzionamento VETTORIALE di R.

# la standard deviation è una misura di VARIABILITA' dei dati (come var e mad).
# la variabilità si riduce al crescere del numero di osservazioni (le righe del df).
# [pensiamo alle proiezioni delle elezioni: la forchetta di variabilità della percentuale ottenuta da un certo partito
# si riduce mano a mano che i seggi sono scrutinati].
# perchè ciò? se la dimensione del campione è bassa, la presenza di uno o pochi OUTLIER può influenzare molto la media
# (la deviazione standard è infatti una MEDIA, per questo è anche detta "scarto quadratico medio").

# verifichiamo questo fenomeno:
m <- dim(Credit)[1]
n <- dim(Credit)[2]
m;n                     # m,n è notazione di algebra lineare.
                        # nel machine learning si usa in genere n,p (ad es. nel licorrelazione ISLR)

sd.set <- double(m)                   # inizializzazione a zero del vettore (più veloce)

for (i in 1:m) {
  # X <- Credit$Income[1:i]                     # dati estratti SEQUENZIALMENTE (i precedenti outlier continuano ad influenzare!)
  # X <- sort(Credit$Income[1:i])               # dati estratti in ORDINE (c'è comunque un BIAS nei dati, cioè una deformazione
                                                # introdotta dall'ordinamento)
  X <- sample(Credit$Income,i,replace=FALSE)    # dati estratti CASUALMENTE (meglio, diversi)
  sd.set[i] <- sd(X)
}

plot(sd.set,xlab="Dimensione del campione",ylab="Valore della deviazione standard")
# --> dopo 50 osservazioni circa la deviazione standard si stabilizza (intorno a 35)

# nota sul campionamento (sampling):
set.seed(1)                           # per la riproducibilità dei risultati (random seed)
sample(1:10,3,replace=FALSE)          # non c'è MAI due volte lo stesso elemento (dentro la tripletta estratta)!
                                      # verificarlo selezionando il comando e ripetendo 'Run' diverse volte.
sample(1:10,3,replace=TRUE)           # lo steso elemento può così invece ricomparire nella tripletta estratta.

# debug del ciclo (utile ad esempio per vedere variabili LOCALI ad un ciclo):
# - breakpoint e poi 'Source' (e non 'Run')
# - la prima sd è 'NA' perchè non c'è variabilità con una sola osservazione
sd(Credit$Income[1:1])   # --> NA
sd(Credit$Income[1:2])   # --> ok

# SE LA VARIABILITA' DEL FENOMENO/CAMPIONE SOTTO STUDIO E' BASSA, LE PREVISIONI SONO PIU' AFFIDABILI.
# qual è dunque la dimensione minima (ottimale) del campione? campionare COSTA!
# se la variabile è solo una, servono almeno 30-50 osservazioni (la causa è "il teorema del limite centrale");
# se le variabili sono parecchie, come spesso accade, servono almeno:
# - 10 osservazioni per ogni variabile  # p=3 --> versione lasca: almeno n = 30 oss (per ridurre la sd);
#                                                 versione conservativa: 10 per la prima var, altre 10 per ognuna dei valori
#                                                 della prima var, etc --> 10^3=1000
# - oppure: n > 5(p+2); p=3 --> 5(3+2) = 25 (simile alla prima regola lasca)
# attenzione: sono "regole del pollice"!

# per una trattazione più teorica (matematica) di questo tema (la dimensione del campione), vedi il PDF
# allegato, con tre pagine estratte da un libro del prof. Brandimarte di qualche anno fa. [scusate le note
# mie a mano!]


# funzionamento vettoriale di R -------------------------------------------
# ["Advanced R" di Hadley Wickham - p. 359 e pp. 366+]
# Esempio:
# - si voglia calcolare la somma di tutte le colonne numeriche di Credit;
# - si deve fare un ciclo for oppure un elenco di 'sum(colonna)'
sum(Credit$Limit)
sum(Credit$Rating)

# R e Python lavorano in modo vettoriale, cioè parallelizzando le operazioni sui vettori colona o riga
var.num <- c("Income","Limit","Rating","Cards","Age","Education","Balance")

colSums(Credit[,var.num])                    # l'operazione di somma colonna in modo vettoriale

# due vantaggi:
# - si scrive meno codice
# - èpiù veloce

system.time(colSums(Credit[,var.num]))       # funzionamento vettoriale
system.time(apply(Credit[,var.num],2,sum))   # funzionamento non vettoriale (più lento)

# bottom-line
# - se potete scrivere una istruzione R vettoriale anzichè un ciclo for od un elenco di istruzioni è meglio
# - alcune funzioni di base fornite da R funzionano in modo vettoriale, altre no. E' bene sapere quali (help, chatGPT)

# statistiche mancanti in R base ------------------------------------------

# MODA (da Università La Sapienza):

# per variabili numeriche.

Mode=function(x,tie.choice=c("all","first","random"),message=F) {

  if(!(is.vector(x)|is.factor(x))) stop("x is neither a vector nor a factor!!")

  ux=unique(x)
  tab=tabulate(match(x, ux))
  out.complete=ux[which(tab==max(tab))]
  out = switch(tie.choice[1],
               all = out.complete,
               first = sort(out.complete)[1],
               random = sample(out.complete)[1]
  )
  if(message==T){
    attr(out,"uniqueness")="yes"
    if(length(out.complete)>1){
      attr(out,"uniqueness")="no"
    }
  }
  return(out)
}

# SKEWNESS e KURTOSIS (da RIA, 2nd ed. pp. 139-140):

mystats <- function(x,na.omit=FALSE) {
  if(na.omit)
    x <- x[!is.na(x)]
  m <- mean(x)
  n <- length(x)
  s <- sd(x)
  skew <- sum((x-m)^3/s^3)/n
  kurt <- sum((x-m)^4/s^4)/n - 3
  return(c(n=n,mean=m,sd=s,skew=skew,kurtosis=kurt))
}

# Missing Values (MV) management --------------------------------------------------

# MV è una cella (all'incrocio riga X con colonna Y) mancante (non valorizzata)
# --> in R chiamati NA (Not Available)

# il dataset Credit è stato realizzato ad hoc (non è reale) --> non ha MV/NA
# per imparare a gestire i MV usiamo qui un altron dataset (che ha MV)

# VIM è un package per la gestione dei MV
data(package="VIM")       # la lista dei dataset SOLO del package indicato (VIM)
data(sleep,package="VIM") # il caricamento in memoria del dataset 'sleep'

# carica in memoria uno specifico dataset
# <Promise object> ? (vedi pane Environment): click sopra.
dim(sleep)                # 'sleep' ha 62 righe e 10 colonne
View(sleep)

# è molto scomodo o persino impossibile rilevare i MV con View su grandi dataset

# serve un rilevamento MV automatico - in gergo si chiama MV detection (so: 24027605):
# si vogliano individuare i MV della colonna Sleep del dataset sleep
# facciamo allora un check booleano sulla colonna con la funzione 'is.na

is.na(sleep$Sleep)                # -->  vettore di booleani 

# funzionamenmto vettoriale di R: 1 comando applicato a tutti gli elementi del vettore;
# --> True significa NA.

# poichè nei linguaggi di programmazione TRUE è memorizzato in memoria come 1 (e FALSE come 0)
sum(is.na(sleep$Sleep))                  # per singola colonna (ma sono tante!)
sum(is.na(sleep))                        # in totale sull'intero dataframe (ma in quali righe?)
apply(sleep,2,function(x) sum(is.na(x))) # sinossi utile (per colonna)
apply(sleep,1,function(x) sum(is.na(x))) # sinossi utile (per riga)

sapply(sleep, function(x) sum(is.na(x))) # sinossi utile (lo stesso, con la funzione sapply che restituisce un vettore)

# sinora abbiamo contato i MV (per colonna, per riga o in totale)

# la seguente funzione individua le righe (cases) complete (senza MV in nessuna colonna)
complete.cases(sleep)                     # un vettore di booleani che indicano, per ogni riga, 
                                          # se essa NON ha MV (cioè è completa) oppure no;

# come suggerisce il nome della funzione ('complete.cases'), TRUE qui significa assenza di MV
sum(complete.cases(sleep))                # the number of rows that do NOT have ANY missing values (ie, complete): 42.
# cioè, per complemento a 62 (il numero totale di righe), ci sono 20 righe con MV.
sum(!complete.cases(sleep))               # il complemento (l'operatore '!' inverte il booleano)

# ricordandoci che un df può essere subsettato (per riga) anche con un vettore di booleani (ogni booleano dice ad R se "quella"
# determinata riga dev'essere estratta oppure no.
sleep[complete.cases(sleep),]             # la lista delle righe complete.
sleep[complete.cases(sleep),][,c("NonD")] # subsetting a cascata: i valori della colonna 'NonD' nelle righe complete.
sleep[c(3,4),]                            # due righe non complete: infatti hanno NA
sleep[c(19,20,21),]                       # idem

sum(!complete.cases(sleep))               # the number of rows that DO have missing values (at least 1): 20
sleep[!complete.cases(sleep),]            # la lista delle righe non complete: ognuna ha almeno un NA

library(mice)
md.pattern(sleep,plot=TRUE) # molte combinazioni
# prima colonna: numero righe con quel pattern; ultima colonna: numero variabili con MV (in quel pattern).
# ogni riga rappresenta un possibile pattern di 'missingness': 0 significa MV per quella colonna, 1 significa non-MV.
# La prima riga descrive il pattern "no MV" (tutti gli elementi sono 1).
# La seconda riga descrive il pattern "no MV eccetto che per le colonne 'Dream' e 'NonD'.
# La prima colonna indica il numero di righe in ogni pattern, l'ultima colonna indica il numero di variabili con MV.
# Riga totale: numero di MV per ogni colonna.

library(VIM)                 # VIM è un package per la gestione dei MV

aggr(sleep,prop=F,numbers=T,bars=F,cex.axis=0.6) # grafico
# il secondo plot è la versione grafica della funzione 'md.pattern'

# molte funzioni R hanno l'argomento 'na.rm=T/F';
# usiamo una colonna di 'sleep' che abbia MV, ad es. 'NonD':
sum(sleep$NonD)            # --> la funzione 'sum' è NA (Not Applicable) perchè ci sono dei MV
sum(sleep$NonD,na.rm=T)    # ok! (la somma sui 62-14 valori di 'NonD' presenti)

# omit NAs sul dataset PIENO
sleep_red = na.omit(sleep)  # toglie le righe con MV
View(sleep_red) # ??
dim(sleep_red)

# e nei nostri dataset?
md.pattern(Credit,plot=FALSE)   # no MV
md.pattern(Auto,plot=FALSE)     # no MV
md.pattern(Carseats,plot=FALSE) # no MV
md.pattern(Adv,plot=FALSE)      # no MV
md.pattern(Boston,plot=FALSE)   # no MV

# mappa visiva dei NA, ora:
library(Amelia)
data(sleep,package="VIM") # VIM è un package per la gestione dei MV
dim(sleep)
missmap(sleep)                  # dim(sleep) --> 62 x 10 --> 620 scalari (singole celle).
# 38 MV in totale (da output di 'md.pattern') --> 6%
missmap(Credit)

# sino a qui abbiamo INDIVIDUATO (RILEVATO) i MV: quanti? dove?
# ora dobbiamo GESTIRLI: ci sono 3+1 strategie di gestione dei MV
# - cercare di recuperare da altre fonti i valori mancanti
# - togliere dal dataset tutte le righe che hanno almeno 1 MV: approccio pulito ma drastico, posso perdere molte righe
# - imputare i MV con la mediana di colonna
# - la strategia migliore: fittiamo un modello di regressione con risposta la colonna con MV e predittori le altre colonne

# vediamo la TERZA strategia sul dataset sleep
train.sleep = sleep[complete.cases(sleep),]        # un subset BOOLEANO di riga (tutte le colonne)
                                                   # le sole righe complete, senza MV (42)
head(train.sleep)
dim(train.sleep)

# su questo dataset facciamo il fit di un modello di regressione (per la colonna 'NonD')
mod.MV = lm(NonD ~ ., data=train.sleep)
summary(mod.MV)   # --> dà errore! (R2 aggiustato = 1)

# l'errore è spiegato da chatGPT 5 a questa url: probabili multi-collinearità tra i predittori
url <- "https://chatgpt.com/share/68c3e244-94f4-8012-a249-416ec196042c"
browseURL(url, browser = getOption("browser"))

# 2 modi, tra i molti, per verificare la (multi)collinearità tra i predittori
round(cor(train.sleep),2)   # --> correlazioni elevate (vicine a 1)
library(car)
vif(mod.MV)                 # --> VIF elevati (>>10)

# conclusione: effettivamente alcuni predittori sono molto correlati
# quali togliere? è una scelta di business --> scegliamo BodyWgt

mod.MV = lm(NonD ~ .-BodyWgt, data=train.sleep)
summary(mod.MV)             # come prima

vif(mod.MV)                 # VIF di danger molto alto

mod.MV = lm(NonD ~ .-BodyWgt-Danger, data=train.sleep)
summary(mod.MV)             # come prima

vif(mod.MV)                 # VIF di danger molto alto


# bottom-line
# - troviamo il modello affidabile (non con R2 aggiustato=1)
# - facciamo la predict di NonD con il modello fittato applicato alle righe di sleep nelle quali NonD è MV