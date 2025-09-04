# Copyright 2021 Antonio Michele Piemontese

###########################################

# grafica -----------------------------------------------------------------

# "A picture REALLY can be worth a thousand words".
# "Modern data analysis increasingly relies on graphical presentations to uncover meaning and convey results."
# "The attractive graphical results/reports can be distributed to stakeholders and the public.

# R offre la grafica di più alta qualità sul mercato (insieme Python).
# Molti dei grafici statistici che vediamo sui giornali sono fatti con R.
# esempio del NYT:
url <- "https://blog.revolutionanalytics.com/2011/03/how-the-new-york-times-uses-r-for-data-visualization.html"
browseURL(url, browser = getOption("browser"))

# alcune demos (focus del mouse sulla consolle):
demo(persp)
demo(image)
# google in "ggplot2" --> tantissimi esempi di grafic ottenibili con ggplot2 (il libro di riferimento è quello di Hadley Wickham)

# alcuni motori grafici di R:
# - base: per grafici statistici, facile da usare; offre grafici predefiniti ed anche custom.
# - package 'lattice': ottimo per dati multivariati; offre grafici predefiniti ed anche custom.
# - package 'ggplot2' (implementa "The Grammar of Graphics" di Wilkinson, scritto da H. Wickham): offre in più grafici attraenti;
#   non è immediato da usare (c'è una grammatica da imparare).

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

n <- 3 # the maximum number of points to locate. Valid values start at 1.
plot(Income,Balance); locator(n,type="p")  # locator is only supported on screen devices such as X11

# - B) 'identity' reads the position of the graphics pointer when the (first) mouse button is pressed. It then searches the coordinates
#   given in x and y for the point closest to the pointer. If this point is close enough to the pointer, its index will be returned as
#   part of the value of the call".

x11()
plot(Income,Balance); identify(Income,Balance)    # --> visualizza label SUBITO
# selezionando l'outlier più a destra e più in alto, cioè quello con il max Income ed anche il max Balance --> riga 324
Credit[324,c("Income","Balance")]
# oppure (senza x11() aperto):
plot(Income,Balance); identify(Income,Balance)    # --> visualizza label a fine processo (escape)

#######################################################################################################################
# attenzione: a volte, se non ben terminati, i grafici interattivi lasciano le finestre x11() aperte, e non si riesce #
# a chiuderle a mano, e nemmeno con dev.off. si deve chiudere RStudio.                                                #
#######################################################################################################################

# pdf() - "it starts the graphics device driver for producing PDF graphics (R help):
pdf("nome.file.pdf")
plot(Income,Balance);
dev.off()

jpeg("nome.file.jpg")
plot(Income,Balance);
dev.off()

plot(Income,Balance);  # --> se tutti i device sono stati chiui correttamente con il comando 'dev.off' l'output
# è ora re-indirizzato sullo standard output (la finestra a dx di RStudio)

# c'è anche 'bmp', 'png', ecc (sono tutti device grafici)
?Devices    # la lista dei device grafici disponibili in R

# grafici 3D: vari modi:

library(scatterplot3d)
scatterplot3d(Income,Age,Balance)    # 3d prospettico
scatterplot3d(Income,Age,Balance,highlight.3d = T,type="h")    # con questi 2 argomenti addizionali si
                                                               # ha un miglior effetto prospettico.

# --> STATIC plots (like the above one) are convenient if one need to compare (and save) many plots.
x11()
par(mfrow=c(2,2))                    # numero di porzioni del device grafico
scatterplot3d(Income,Age,Balance)
scatterplot3d(Income,Age,Rating)
scatterplot3d(Limit,Age,Balance)
scatterplot3d(Income,Education,Balance)
dev.off()
par(mfrow=c(1,1))

library(rgl)
plot3d(Income,Age,Balance)           # vero 3d, interattivo

# --> drawback: when you save it, you cannot set orientation.

# grafici parametrici, cioè con "Gui controls" che permettono di manipolare il grafico (Verzani, pp. 46 / 47):
# si possono fare con il package 'manipulate'.
# quello che segue è un esempio del POTENZIALE del package 'manipulate' (non importa qui capire esattamente il significato
# di tutti i controlli grafici).
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
rgb()   # funzione del package base 'grDevices'

# argomento 'col' = indice (intero), nome, RGB o HSV
plot(Income,Balance,col="brown");
plot(Income,Balance,col=32)                  # non c'è match tra numero e colore!
scatterplot3d(Income,Age,Balance,color = "brown")
scatterplot3d(Income,Age,Balance,color = 32) # non c'è match tra numero e colore!

# indice è utile per plot di sottopolazioni,
# col=as.integer(class-type), dove class-type è il fattore target della classe, che internamente
# da R è sempre memorizzato come intero, anche se i suoi livelli (levels(factor)) sono alfanumerici.

# esempio con iris (celeberrimo dataset usato per la prima volta da sir Fisher - vedi Help)
iris
str(iris)
attach(iris)
levels(Species)
plot(Sepal.Length,Sepal.Width,col=as.integer(Species),pch=16,cex=1.3,main="sottopolazioni di iris")
# # help 'par' --> help 'points' --> 'pch values'

# contour plot e heatmap (ISLR, p. 46-47) - utili in ambiti specifici (e non con con i tradizionali dataset multivariati.)
x=seq(1,10,by=2)  # piccolo excursus sulle sequenze:
x
x=1:10
x
x=seq(-pi,pi,length=50)
y=x
plot(x,y)

f=outer(x,y,function(x,y)x^2+y^2)         # per ogni punto della griglia (X,Y) questa funzione calcola X^2+Y^2
# su una terza dimensione.
# f=outer(x,y,function(x,y)sin(x)*cos(y)) # per ogni punto della griglia (X,Y) questa funzione calcola sin(x) * cos(y))
# su una terza dimensione.

persp(x,y,f)                              # ecco la funzione (convessa)
x11()
persp3d(x,y,f)
dev.off()

contour(x,y,f)                            # ed ecco le sue curve di livello (come nelle cartine topografiche);
                                          # i valori più bassi di f sono al centro (funzione convessa)
contour(x,y,f,nlevels=45,add=T)
image(x,y,f)                              # 'image' è come 'contour', ma a colori (heatmap); spesso usata per
                                          # plottare le temperature nelle previsioni del tempo

# attenzione:
contour(Income,Balance,Age)               # --> non ha senso (la terza dimensione NON è è funzione delle prime due,
                                          #     cioè è INDIPENDENTE da esse)


library(GGally)
ggpairs(data=Credit)

class(Credit)
mode(Credit)

str(Credit)
tail(Credit,20)

View(Credit[1:100,c("Income","Balance")])

View(Credit[,c])
fix(Credit)
Credit
data(Credit)
