# statistica multivariata esplorativa di Vicario - slides

##########
# DATI   #
##########

X=matrix(c(20,15.7,148,17,10.2,130,19,12.5,129,16,10.8,140,20,10.5,139,19,11.5,120,17,11.8,129,17,10.8,169),nrow=8,ncol=3,byrow=TRUE)
X
class(X)

# standardizzazione di X
Z=scale(X); Z

###############
# STATISTICHE #
###############

# covarianze
S=cov(X); S

# la singola varianza ? ottenibile anche come (es. con altezza):
var(X[,1])

# matrice delle correlazioni
R=cor(data.frame(X)); R

# oppure con:
cov2cor(cov(X))

# oppure ancora con:
cov(Z) # la matrice di correlazione (di X) ? la matrice S dei dati standardizzati Z (Johnson)

# correlazioni e p-values
cor(X)         # R base
library(Hmisc) # un'alternativa
rcorr(X)

# singole correlazioni e p-values (a conferma)
cor(X[,1],X[,2]) # altezza - capacit?
cor.test(X[,1],X[,2])

cor(X[,1],X[,3]) # altezza - prezzo
cor.test(X[,1],X[,3])

cor(X[,2],X[,3]) # capacit? - prezzo
cor.test(X[,2],X[,3])

# test di slide 15 - con n e alfa differenti
cor.test(X[1:5,1],X[1:5,2],conf.level=0.95,method="pearson")
cor.test(X[1:5,1],X[1:5,2],conf.level=0.99,method="pearson")

cor.test(X[1:8,1],X[1:8,2],conf.level=0.95,method="pearson")
cor.test(X[1:8,1],X[1:8,2],conf.level=0.99,method="pearson")

# Note Maxwell:
# - verificare sia l'intensità della correlazione che il p.value - due aspetti da considerare insieme
# - la maggior parte dei tools usa Pearson per default; è ok nel vs. caso?
# - la correlazione non è influenzata dalle trasformazioni di variabili
cor(Income,Balance)
cor(2*Income,2*Balance)                            # Pearson non è sensibile alle combinazioni lineari
cor(3*Income+20,3*Balance+40)
cor(log(Income),log(Balance))                      # NaN
cor(log(Income),log(Balance),method = "spearman")  # ok, Spearman non è sensibile neanche a quelle non-lineari

# check slide 9 e 12
(t(Z)%*%Z)/(8-1)
R

# il calcolo delle tre varianze, ora:

# 1) totale (forma concisa ed estesa:
sum(diag(S)) == (var(X[,1])+var(X[,2])+var(X[,3]))

# 2) varianza generalizzata di Wilks: determinante di S
det(S)

# 3) varianza generalizzata normalizzata
det(S)/(var(X[,1])*var(X[,2])*var(X[,3]))
# oppure pi? semplicemente:
det(R)
# attenzione: VIF determina la multi-collinearit? (tra 3+ predittori). Qui sono correlazioni a coppie.


##############################
# CORRELOGRAMMI (tentativo)  #
##############################

# il plot matriciale delle correlazioni
library(corrplot)
corrplot(cov2cor(cov(X)))


library(corrgram)

# dati
corrgram(X, type="data", order=TRUE, lower.panel=panel.shade,
         upper.panel=panel.pie, text.panel=panel.txt,
         main="Dati",labels=c("Altezza","Capacit?","Prezzo"))

# correlazioni ?? - non funziona
corrgram(rcorr(X), type="corr",order=TRUE, lower.panel=panel.shade,
         upper.panel=panel.pie, text.panel=panel.txt,
         main="Correlazioni",labels=c("Altezza","Capacit?","Prezzo"))

# la correlazione dipende dalla dimensione del campione e dal livello alpha.



#######################################
# CORRELAZIONE PARZIALE (La Sapienza) #
#######################################

Z=runif(30)
hist(Z,nclass=10)
X=2*Z+rnorm(30,sd=0.2)
Y=2*Z+rnorm(30,sd=0.2)

# X e Z sono collegate tra loro indirettamente, tramite Z
plot(data.frame(X,Y,Z))
cor(data.frame(X,Y,Z))
corrplot(cor(data.frame(X,Y,Z)))
