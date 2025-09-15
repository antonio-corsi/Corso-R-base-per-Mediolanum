#
# In questo script vediamo come la variabilità dei dati impatta su diversi risultati, 
# in particolare sulla correlazione e sulla regressione

# Installazione pacchetti (se non già presenti)
install.packages("ISLR")

library(ISLR)

# il dataset utlizzato
data("Credit")   # carica il dataset in memoria

str(Credit)


# A. Impatto sulla correlazione -----------------------------------------------------------------------------------------------------------------------------------------------

# Impatto della variabilità (la dev-std di una colonna) sulla correlazione campionaria tra Balance e Income
cor(Credit$Balance, Credit$Income)

# campione di 400 clienti; e gli altri ? (la popolazione)
# campionare costa; spesso le aziende dispongono di campioni e non della intera popolazione

# test di ipotesi: c'è correlazione tra Balance e Income nella popolazione?
# rho è il coefficiente di correlazione tra Balance e Income della popolazione.
# H0 (ipotesi nulla del test): rho = 0 (cioè NON c'è correlazione tra le due variabili).
# H1: ipotesi alternativa: rho <> 0.
# se il p.value del test < 0.05--> si rifiuta H0, c'è correlazione.

cor.test(Credit$Balance, Credit$Income)  # --> p.value del test << 0.05 --> H0 rifiutata--> c'ècorrelazione tra le due
                                         # variabili anche nella popolazioone.
                                         # al 95% di confidenza il rho dellas popolazione è compreso tra 0.3830176 e 0.5372821


# correlazione campionaria tra Balance e Rating:
cor(Credit$Balance, Credit$Rating)       # --> 0.86 (molto più alta)

# Cosa succede se raddoppio artirficialmente la devstd di Income? (mantenendo inalterata la media)
# Aggiungo rumore forte a Income 
set.seed(123)                            # il seme (garantisce la riproducibilità dei risultati)
Credit$Income_noisy <- Credit$Income + rnorm(nrow(Credit), 0, 100)
cor(Credit$Balance, Credit$Income_noisy)  # molto più bassa!

# Infatti, immagina di misurare reddito e saldo del cliente:
# - senza aggiunta di rumore → c’è correlazione positiva (chi guadagna di più tende ad avere più saldo).
# - se a ogni reddito aggiungo un errore enorme (es. ±100.000 € casuali), i valori diventano confusi:
#   alcune persone con basso reddito sembreranno avere valori altissimi,
#   altre con reddito alto sembreranno avere valori bassi.
# Quindi, nel grafico a dispersione, il pattern “lineare” quasi sparisce → la correlazione scende.

# Conclusione:
# - Media di income2 quasi invariata.
# - Deviazione standard molto più grande.
# - Correlazione con Balance diminuisce, perché il rumore rende Income meno informativo.

# Matrice di correlazione
cor(Credit)     # dà errore! la correlazione si può calcolare solo per coppie di variabili numeriche; 
                # le variabili 'factor' non lo sono!
var.num <- c("Income","Limit","Rating","Cards","Age","Education","Balance") # tutte e sole le variabili numeriche
                                                                            # senza i 4 fattori
Credit[var.num]
round(cor(Credit[var.num]),2)              # matrice di correlazione (difficile visivamente da controllare!)

# visualizzazione grafica della matrice di correlazione
library(corrplot)
x11()   # apre un device grafico X11 (a parte, vedi icona nella barra di Windows)
corrplot(cor(Credit[var.num]),type="upper",method="ellipse")
# la matrice di correlazione è sempre SIMMETRICA, per definizione,
# cioè se si scambiano righe e colonne si ottiene la stessa identica matrice;
# dunque è sufficiente visualizzare la matrice triangolare superiore
# (od inferiore).
# più l'ellisse è allungata maggiore è l'intensità della correlazione.

# la funzione 'corrplot' è indispensabile se le colonne (numeriche) sono molte, perchè rende la matrice di correlazione
# è più facile da esaminare


# B. Impatto sulla regressione ------------------------------------------------------------------------------------------------------------------------------------------------
# Impatto della variabilità su un modelllo di regressione OLS (univariato e multi-variato)

# La regressione è un fondamentale ed usatissimo metodo di previsione di variabili numeriche (come è Balance)

# pulizia dell'ambiente
ls()             # tutti gli oggetti del global environment
rm(list = ls())  # per sicurezza cancelliamo tutti gli oggetti del global environment

# pacchetti
library(caret)   # per la divisione del dataset
library(MASS)    # per lm se serve
library(car)     # per il VIF

data(Credit)     # da ricaricare in memoria perchè modificato al passo precedente A dello script

ls()             # --> c'è 'Credit'

# costruiamo un modello di regressione UNIVARIATA, cioè con 1 solo predittore - vari passi

# per prima cosa vediamo lo scatterplot tra le due variabili
x11()
plot(Credit$Rating,Credit$Balance)     # scatterplot statico (per primo il predittore, poi la risposta)
identify(Credit$Rating,Credit$Balance) # scatterplot interattivo (click sul punto --> ALLA FINE li visualizza - si esce con ESC)

# eseguiamo ora i seguenti step:

# 0. suddivisione tra training e test (70% training, 30% test)
set.seed(123)  # per riproducibilità
train_index <- createDataPartition(Credit$Balance, p = 0.7, list = FALSE)
train_data <- Credit[train_index,]
test_data  <- Credit[-train_index,]

# esistono altri modi per suddividere il dataset in 2 parti (training e test)
# un altro modo è il seguente (50%,50%)
# set.seed(1)
# train_data = sample (1:nrow(Credit),nrow(Credit)/2)
# test_data = (-train_data)  # prende tutte le righe del dataframe che NON sono in training

dim(train_data)
dim(test_data)
head(train_data)

head(test_data)

# 1. fit del modello di regressione: Balance ~ Rating, cioè possiamo"spiegare" Balance con Rating?
# il fit (l'adattamento) è fatto sui dati di training

fit <- lm(Balance ~ Rating, data = train_data)   # fit: nome del modello di regressione (una scelta!)
                                                 # ATTENZIONE: nella formula non scrivere 'Credit$Balance' e 'Credit$Rating'
                                                 # altrimenti la funzione 'lm' non prende le colonne da 'train_data' ma da Credit!!
fit                                              # il modello fittato (in sintesi)

# la retta di regresione è definita da due coefficienti: intercetta e coefficiente angolare

# 2. sommario con coefficienti e p-value
summary_fit <- summary(fit)
summary_fit
# cosa guardare in questo sommario?
# - il p.value del  test F dell'ultima riga dev'essere < 0.05, altrimenti il modello è inutile. qui è quasi 0, ok!
# - l'R2 aggiustato è una misura tra 0 e 1 che dice quanto il modello spiega. Più è vicino a 1, meglio è. qui è 0.19 (basso)
# - gli asterischi dei due coefficienti della retta sono 3 stelle, cioè i p.value dei due coefficienti sono tra 0 e 0.001,
#   dunque << 0.05. Ok, la retta è significativa.

# RSE = stima della dev std del termine d’errore, espresso nella scala della risposta

# la regressione univariata costruisce (fitta sui dati) una RETTA di regressione, che vogliamo visualizzare sovraimposta al dataset 
plot(Credit$Rating,Credit$Balance)     # scatterplot statico (per primo il predittore, poi la risposta)
abline(fit,col="red")                  # sovrascrive allo scatterplot la retta di regressione

# parentesi: la scatterplot matrix: lo scatterplot di TUTTE le coppie di variabili
pairs(Credit)

# 3. estrazione dei coefficienti con p-value
summary_fit$coefficients
coef(summary_fit)          # gli stessi dati (ma un modo per estrarli dal modello più corretto)

# 4. Intervalli di confidenza al 95% dei coefficienti stimati
conf_intervals <- confint(fit, level = 0.95)
conf_intervals

# 5. analisi dei residui 
par(mfrow = c(2,2))   # layout 2x2
plot(fit)

# 6. predizioni sul test dataset, con la funzione 'predict'
pred <- predict(fit, newdata = test_data)

# 7. calcolo RMSE (vedi la voce Wikipedia EN "RMSD")

rmse <- sqrt(mean((test_data$Balance - pred)^2))
rmse

# Ora fittiamo un modello di regressione multi-variata: Balance ~ . 
# Cioè utilizziamo tutte le variabili di Credit per stimare/prevedere Balance
# Ripetiamo tutti i passi precedenti, ma con una nuova formula di fit

fit.MV <- lm(Balance ~ ., data = train_data)   # fit.MV: nome del nuovo modello di regressione

vif(fit.MV)                                    # VIF di Limit e Rating > 100 --> Limit e Rating sonoi correlati 
                                               # bisogna togliere uno dei due dal modello.

summary.fit.MV <- summary(fit.MV)
summary.fit.MV                                 # R2 aggiustato è salito al 94%!!

# molti predittori hanno pvalue > 0.05 e dunque sono inutili.
# togliamo progressivamente i predittori con il pvalue più alto, uno per volta
fit.MV.red1 <- lm(Balance ~ . -Education, data = train_data)
summary(fit.MV.red1)

# i coefficienti ora sono molti, perchè l'equazione di regressione è di un iperpiano (su n dimensioni)
coef(fit.MV)

fit.MV.red2 <- lm(Balance ~ . -Education -Gender, data = train_data)
summary(fit.MV.red2)

fit.MV.red3 <- lm(Balance ~ . -Education -Gender -Ethnicity, data = train_data)
summary(fit.MV.red3)

fit.MV.red4 <- lm(Balance ~ . -Education -Gender -Ethnicity -Married, data = train_data)
summary(fit.MV.red4)

fit.MV.red5 <- lm(Balance ~ . -Education -Gender-Ethnicity -Married -Rating, data = train_data)
summary(fit.MV.red5)

fit.MV.red6 <- lm(Balance ~ . -Education -Gender -Ethnicity -Married -Rating -Age, data = train_data)
summary(fit.MV.red6)

fit.MV.red7 <- lm(Balance ~ . -Education -Gender -Ethnicity -Married -Rating -Age -ID, data = train_data)
summary(fit.MV.red7)

# I restanti 4 predittori (più l'intercetta) hanno tutti p.value < 0.05, cioè spiegano la risposta Balance
# R2 è rimasto invariato!

# in generale, non vogliamo costruire modelli inutilmnete complessi, se possiamo eliminare predittori inutili ben venga

# i predittori rimasti nel modello (senza l'intercetta):
names(coef(fit.MV.red7))[-1]

# ATTENZIONE: a volte l'esclusione dal modello di una variabile NON funziona bene.
# Fittiamo un modello per inclusione, non per esclusione, con i predittori rimasti:
fit.final <- lm(Balance ~ Income + Limit + Cards + Student, data = train_data)
summary(fit.final)


# le previsioni sui dati di test con l'ultimo modello
pred <- predict(fit.final, newdata = test_data)

# calcolo RMSE (Rooted Mean Square Error --> vedi formula sulla voce Wikipedia EN "RMSD"): 
rmse <- sqrt(mean((test_data$Balance - pred)^2))
rmse # l'errore di previsione medio (sceso molto rispetto alla regressione univariata)

# NON confondere R2 e pvalue (vedi il summary del modello), calcolati sul training set, con RMSE, calcolato sul test set

# previsioni su NUOVI dati
# creiamo un dataframe con 3 nuovi clienti, quindi stessa lunghezza per tutte le colonne
# vogliamo prevedere i 3 Balance

lv <- levels(train_data$Student)
new_clients <- data.frame(
  Income  = c(50, 80, 120),
  Limit   = c(5000, 8000, 12000),
  Cards   = c(2, 3, 4),
  Student = factor(c("Yes", "No", "No"), levels = lv)
)

new_clients

pred <- predict(fit.final, newdata = new_clients)  # la novità di questa istruzione è 'new_data' su new_clients
                                                   # e non 'test_data' (come fatto prima)
pred


# predittori correlati con la risposta: bene! (spiegano la risposta)
# predittori correlati tra loro: male! (il modello non è stabile)

# la correlazione a coppie si calcola con la matrice di correlazione, come visto prima.
# ma i predittori possono essere multi-correlati; ad esempio le vendite totali = somma delle vendite mensili

# la multi-correlazione dei predittori tra loro si calcola con il VIF (dopo il fit del modello) 
# VIF (Variance Inflation Factor)
vif(fit.final)

# oppure in modo equivalente (se ci fossero funzioni con lo stesso nome appartenenti a package differenti)
car::vif(fit.final)   # cioè premettendo al nome della funzione il package a cui essa appartiene

# linea-guida
# ognuno dei VIF forniti (uno per predittore) devono essere < 10 (meglio) ma assolutamente < 100.

# model.matrix
model.matrix(fit.MV.red7)

# ora finalmente modifichiamo il dataset Credit, o meglio la matrice di disegno
# es. 1 - la media di Balance resta uguale ma la sua devstd raddoppia, tutte le altre colonne invariate
# es. 2 - aumento spread X-i con chatGPT B--> impatto

# es. 1
# controlliamo media e devstd attuali
mean(Credit$Balance)
sd(Credit$Balance)

# Vogliamo stessa media, ma devstd raddoppiata
mu <- mean(Credit$Balance)
sigma <- sd(Credit$Balance)
target_sigma <- 2 * sigma

# Trasformazione lineare: (X - mu) * (target_sigma/sigma) + mu
Credit$Balance <- (Credit$Balance - mu) * (target_sigma/sigma) + mu

# Controllo nuova media e devstd
mean(Credit$Balance)   # deve essere ~520
sd(Credit$Balance)     # deve essere ~920


# rifare regressione --> risultati differenti da prima



