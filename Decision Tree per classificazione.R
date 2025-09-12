###--------------------------###
###    LAB 8 (15/12/2017)   ###
###--------------------------###


###  Tree-based Methods ###
## Classification Trees  ##

# ANTONIO: review rate: D (as to parts 1 and 3) - part 2 not done in class.
# A: integrated with prof. Secchi's and Anna's comments done in class;
# B: A and integrated with info form the R help and other sites (eg, Cross-Validated);
# C: B and integrated with code/comments from Hastie & Tibshirani's ISL.
# D: C and printed / statically reviewed.

# 3 parts: 1 and 3 done in-class, 2 not done due lack of time. However, I printed the plots for all 3.
# H&T's ISL Lab 8.3.1. reports just part 1 (and not 2 and 3).

#### Packages ####

library(glmnet)
library(tree)
library(ISLR)
library(mvtnorm)

##### Classification Trees: Carseats dataset ####
attach(Carseats)

help(Carseats)
dim(Carseats)
names(Carseats)
str(Carseats)
head(Carseats)
Carseats$High <- NULL  # ANTONIO: if yet present in the dataset from previous runs.

# ANTONIO: a look at the data
x11()
hist(Sales)
abline(v=8,lwd=3,col='red')

# let's build a classification tree for 'Sales'.
# we need a categorical variable from a numeric variable, ie, a discretized (binary) variable (high or not).
High <- ifelse(Sales<=8,"No","Yes")
table(High)
# No  if less or equal than 8000 units sold per location;
# Yes if more than 8000 units.

# a new dataframe to merge 'high' with the rest of the 'Carseats' data set.
Carseats <- data.frame(Carseats,High)

set.seed(02091991) # ANTONIO: nothing magic in this seed, just Anna's birthdate. However, it's not
# required here (the book does not use it here...)

# From H&T's ISL: we now use the 'tree' function to fit a classification tree in order to predict 
# 'High' using ALL variables BUT 'Sales' (as 'High' is based just on Sales). The syntax of the 
# 'tree' function is quite similar to 'lm'. It's the same function we used for regression trees in
# the last lesson. Default splitting method for class trees: gini index.

Carseats$High <- factor(Carseats$High)
tree.carseats <- tree(High~.-Sales,Carseats) # fit
summary(tree.carseats)

# [This summary looks like 'lm's.]
# H&T's ISL: For classification trees, the deviance reported in the output of summary() is given by 
# the formula reported on page 325 top.
# A small deviance indicates a tree that provides a good fit to the (training) data. The residual mean 
# deviance reported is simply the deviance divided by n - |T0|. 
# The deviance is binomial in this case, as the response is binary.
# As management engineers might know, location in supermarket seems to be the feature most impacting 
# to sales.

x11()
plot(tree.carseats)          # the tree structure
text(tree.carseats,pretty=0) # the node labels; pretty=0 includes the category names (rather than
# simply a position letter).

# here's the corresponding logical structure:
tree.carseats

# now, let's split the training and the test set (the latter to estimate the test error)
set.seed(2) # a good habit is changing the seed every so often, id est not always the same for 
#             methods and problems (H&T's video).
train <- sample(1:nrow(Carseats), 200)
Carseats.test <- Carseats[-train,] # required later as 'predict' doesn't have the argument 'subset', unlike 'tree' (ANTONIO)
High.test <- High[-train]          # the vector of test responses, again for later use (ANTONIO).

# let's build the FULL tree, as usual, on JUST the training set.
tree.carseats <- tree(High~.-Sales,Carseats,subset=train)
summary(tree.carseats)

x11()
plot(tree.carseats)
text(tree.carseats,pretty=0)

# here's the corresponding logical structure:
tree.carseats

# again quite a complex tree (20 rather than 27 terminal nodes), also if the dataset was different (a subset).

# and let's now PREDICT the performance on the test set (ie, on another subset)
tree.pred <- predict(tree.carseats,Carseats.test,type="class") 
# the 'type="class"' argument tells R to return a class prediction - it's for classification 
# problems (H&T's video). ANTONIO: type="vector" gives probabilities rather than labels (R help).
tree.pred # ANTONIO: the list of predicted labels

# the misclassification table, aka 'confusion matrix' (see H&T's ISL, page 158):
table(tree.pred,High.test)
# right predictions:
(100+52)/200 # on the diagonal (H&T's video)
# wrong predictions:
(28+20)/200 # on the off-diagonal (H&T's video)

# Here's the simplest classifier (for comparison): the random guessing (ie, always predicting the most likely class - ANTONIO)
table(High[train])
120/200 # 0.6
  
# "A WEAK classifier is one whose error rate is slightly better than random guessing (ESL, p. 337)."

# H&T's video: might pruning the tree lead to improved results? A bushy (cespuglioso, ramificato)
# tree may have high variance, so we need to try to prune it.
# Pruning and Cross-Validation: let's use cross validation to optimally prune the tree. 

set.seed(3)

cv.carseats <- cv.tree(tree.carseats,FUN=prune.misclass)
# FUN = 'prune.tree' for pruning regression trees (it uses RSS-Deviance, see also ISL p. 206).
# FUN = 'prune.misclass' for pruning classifications trees (it uses the the misclassification error
#        - H&T's video).

names(cv.carseats)
cv.carseats 
# H&T's video: 
# - this plot gives some info about the PATH CV has followed. 'Dev' and 'k' are reported as function of 
# 'size'.
# H&T's ISL: 
# - the 'cv.tree()' function reports the number of terminal nodes of each tree considered (size) as 
#   well as the corresponding error rate and the value of the cost-complexity parameter used (k, which 
#   corresponds to alpha.                                                                                                                                                                                        James, Gareth; Witten, Daniela; Hastie, Trevor; Tibshirani, Robert. An Introduction to Statistical Learning: with Applications in R (Springer Texts in Statistics) (Pagina 326). Springer New York. Edizione del Kindle. 
# - note that, despite its name, 'dev' corresponds to the cross-validation error rate in this 
#   instance. The tree with 9 terminal nodes results in the lowest cross-validation error rate, with 50 
#   cross-validation errors.
# ANTONIO: k here is NOT the iteration# (k-fold CV).

# So, let's plot the cross validation error rate as a function of size tree.
x11()
plot(cv.carseats$size,cv.carseats$dev,type="b")
# plot(cv.carseats$k,cv.carseats$dev,type="b") # ANTONIO: and as a function of k? (see ISL, p. 327 top)

# or just:
x11()
plot(cv.carseats) 

# Once we have selected the best size via Cross-Validation, we can prune the classification tree
# (build on the full training set) with the best number of terminal nodes (by the 'prune.misclass'
# function, that is the equivalent of the 'prune.tree' function for regression trees - see Lab 8a).
# In our case, the best size is 9.

prune.carseats <- prune.misclass(tree.carseats,best=9) # pruning on the full training dataset

# and so, let's have a look at the CV results, ie, the best pruned tree (H&T's video)
prune.carseats
x11()
plot(prune.carseats)
text(prune.carseats,pretty=0)
# it's a smaller tree.

# How well does this pruned tree perform on the test data set? Once again, we apply the predict() function.
# It's just a repeat of the commands we had before (H&T's ISL and video).

tree.pred <- predict(prune.carseats,Carseats.test,type="class")
table(tree.pred,High.test) # the confusion matrix (ISL, p. 158)
(94+60)/200 # 0.77

# Now 77% of the test observations are correctly classified, so not only has the pruning process produced 
# a more interpretable tree, but it has also improved the classification accuracy (H&T's ISL).

# If we increase the value of best, we obtain a larger pruned tree with lower classification accuracy:
prune.carseats=prune.misclass (tree.carseats ,best=15) 
plot(prune.carseats)
text(prune.carseats,pretty =0)
tree.pred=predict(prune.carseats,Carseats.test, type="class")
table(tree.pred,High.test) 
(86+62) /200 # 0.74

detach(Carseats)

graphics.off()

##### Classification Trees: Iris dataset #####

# Goal: classify the species of a flower knowing petal and sepal length.

help(iris)
head(iris)
names(iris)

# Y:
species.name <- iris$Species
# X: (only petal measurments)
iris2 <- iris[,3:4]

i1 <- which(species.name=='setosa')
i2 <- which(species.name=='versicolor')
i3 <- which(species.name=='virginica')

n1 <- length(i1)
n2 <- length(i2)
n3 <- length(i3)
n <- n1+n2+n3


# Plot of original data
x11()
plot(iris2, main='Iris Petal', xlab='Petal.Length', ylab='Petal.Width', pch=19)
points(iris2[i1,], col='red', pch=19)
points(iris2[i2,], col='green', pch=19)
points(iris2[i3,], col='blue', pch=19)
legend("topleft", legend=levels(species.name), fill=c('red','green','blue'))

# some Jittering is useful
iris3 <- iris2 + cbind(rnorm(150, sd=0.025))    
x11()
plot(iris3, main='Iris Petal', xlab='Petal.Length', ylab='Petal.Width', pch=19)
points(iris3[i1,], col='red', pch=19)
points(iris3[i2,], col='green', pch=19)
points(iris3[i3,], col='blue', pch=19)
legend("topleft", legend=levels(species.name), fill=c('red','green','blue'))

# Initialize the dataframe:
iris.df <- data.frame(iris2,species.name)

# Training and Test Set
set.seed(02091991)
train <- sample(1:nrow(iris.df), 100)
iris.test <- iris.df[-train,]

# Classification Tree on Species
tree.iris <- tree(species.name ~., iris.df[train,])
summary(tree.iris)

# Plot of the result
x11()
plot(tree.iris)
text(tree.iris,pretty=0)

# Cross-validation
set.seed(3)

cv.iris <- cv.tree(tree.iris,FUN=prune.misclass)

names(cv.iris)
cv.iris

# Plot of the misclassification error as a function of size
x11()
plot(cv.iris$size,cv.iris$dev,type="b")

# Best size seems to be 4, so we prune the tree until we get best 4 terminal nodes tree
prune.iris <- prune.misclass(tree.iris,best=4)

x11()
plot(prune.iris)
text(prune.iris,pretty=0)

# Logical structure
prune.iris
summary(prune.iris)

# Let's plot the regions on the X space
x11()
plot(iris2, main='Iris Petal', xlab='Petal.Length', ylab='Petal.Width', pch=19)
points(iris2[i1,], col='red', pch=19)
points(iris2[i2,], col='green', pch=19)
points(iris2[i3,], col='blue', pch=19)
legend("topleft", legend=levels(species.name), fill=c('red','green','blue'))
abline(v=2.47339)
x <- c(2.47339,8)
points(x, rep(1.69941,length(x)), type='l')
y <- c(-1,1.69941)
points(rep(5.03084,length(y)), y, type='l')

# Prediction:
tree.pred <- predict(prune.iris,iris.test,type="class")
table(tree.pred,iris.test$species.name)
errort <- (tree.pred != iris.test$species.name)
errort

APERt   <- sum(errort)/length(iris.test$species.name)
APERt


# Comparison with qda (have a look at LAB 4 B to refresh)
# Create same training and test as before
iris.train<-iris.df[train,1:2]
species.train<-iris.df[train,3]
iris.test<-iris.df[-train,1:2]
species.test<-iris.df[-train,3]

# QDA model
qda.iris <- qda(iris.train,species.train)
qda.iris
# prediction of iris2
Qda.iris <- predict(qda.iris, iris.test)
Qda.iris$class
species.name
table(True=species.test, Estimated=Qda.iris$class)

erroriq <- (Qda.iris$class != species.test)
erroriq

APERq   <- sum(erroriq)/length(species.test)
APERq

APERt

# Principal components and trees
pc.iris <- princomp(iris2, scores=T)
names(pc.iris)

x11()
par(mfrow = c(2,1))
for(i in 1:2) barplot(pc.iris$loadings[,i], ylim = c(-1, 1))

#x11()
#biplot(pc.iris, scale=0)


# Create a new dataframe with observation projected along pcs
iris.pc <- data.frame(PC1=pc.iris$scores[,1],PC2=pc.iris$scores[,2],species.name=species.name)

# Run tree on PC1 and 2
tree.iris.pc <- tree(species.name ~PC1+PC2, iris.pc)
summary(tree.iris.pc)

# Plot
x11()
plot(tree.iris.pc)
text(tree.iris.pc,pretty=0)
# The first split is for setosa again: small petal length, 
# i.e. high value of PC1

set.seed(3)

cv.iris.pc <- cv.tree(tree.iris.pc,FUN=prune.misclass)

# Plot size vs misclassification
x11()
plot(cv.iris.pc$size,cv.iris.pc$dev,type="b")

# Pruning with best  size
prune.iris.pc <- prune.misclass(tree.iris.pc,best=3)

x11()
plot(prune.iris.pc)
text(prune.iris.pc,pretty=0)

prune.iris.pc
summary(prune.iris.pc)

# Plot of the regions on the PC1,PC2 space
x11()
plot(iris.pc[,1:2], main='Iris Petal', pch=19)
points(iris.pc[i1,1:2], col='red', pch=19)
points(iris.pc[i2,1:2], col='green', pch=19)
points(iris.pc[i3,1:2], col='blue', pch=19)
legend("topright", legend=levels(species.name), fill=c('red','green','blue'))
abline(v=1.37387)
abline(v=-1.1813)

graphics.off()

#### Simulated data: Variables Selection ####

# Idea: generating two variables correlated with the response but uncorrelated btw them 
# and then testing the pruning power of the tree algorithm against Ridge and Lasso.

set.seed(123)
# 100 observations and p variables
n <- 100
p <- 50

covariates <- array(0, dim=c(n,p)) # initialization

# let's generate 3 variables, where the second and third are correlated with the first (the 
# response), ie, no collinearity btw regressors
# here 's the correlation matrix (to show it):
matrix(data=c(1,0.7,0.7,0.7,1,0,0.7,0,1),nrow = 3,ncol = 3)

temp <- rmvnorm(n, mean = rep(0, 3), sigma = matrix(data=c(1,0.7,0.7,0.7,1,0,0.7,0,1),nrow = 3,ncol = 3))
cor(temp[,1],temp[,2])
cor(temp[,1],temp[,3])
cor(temp[,2],temp[,3])

# 1st is response
resp <- temp[,1]
# 2nd and 3rd covariates
covariates[,1] <- temp[,2]
covariates[,2] <- temp[,3]

# and now let's generate the other p independent covariates:
for(i in 3:p)
  covariates[,i] <- rnorm(n)

# scatterplots (covariate, response) for each of the first 9 covariates:
x11()
par(mfrow=c(3,3))
for(i in 1:9)
  plot(covariates[,i],resp, pch=19)

correlations <- NULL # ANTONIO: a loop requires initialization

# plot of all the correlations btw each regressor amd response at-a-time:
for(i in 1:p)
  correlations <- c(correlations,cor(resp,covariates[,i]))
x11()
plot(1:p,correlations, pch=19) # ANTONIO: con ,ylim=c(-1,1) plot pi? onesto?

data <- data.frame(cbind(resp,covariates))

# variables renaming
names(data)
for(i in 1:p)
  names(data)[i+1] <- paste('V',i,sep='')
names(data)

# and now let's build the Tree: 

tree.complete <- tree(resp ~., data) # 'data' is the dataframe built above
summary(tree.complete)

x11()
plot(tree.complete)
text(tree.complete,pretty=0)

# The variables most impacting on response are V1,V2.

# Let's run CV to select the best number of terminal nodes
set.seed(3)
cv <- cv.tree(tree.complete) # CV applied to the full tree (built on the full training dataset)
names(cv)
cv # 'cv.tree' uses the deviance rather than MSE

x11()
plot(cv$size,cv$dev,type="b")

# and now the pruning with the best size:
prune <- prune.tree(tree.complete,best=6)

x11()
plot(prune)
text(prune,pretty=0)
# As expected only 1st and 2nd covariate are selected

# the same now with Ridge and Lasso.

# Let's define the model matrix (see H&T's ISL, pages 248 and 251, and Lab13 in 2nd semester, too)
x <- model.matrix(resp~.,data)[,-1] # design matrix

# Antonio (from R help): "model.matrix creates a design (or model) matrix, e.g., by expanding 
# factors to a set of dummary variables (depending on the contrasts) and expanding interactions 
# similarly (ANTONIO: IF PROVIDED to R?!)". ANTONIO: moreover, it turns the df into a matrix.

y <- data$resp # response

# grid of parameters lambda
grid <- 10^seq(5,-3,length=100)

# Ridge
ridge.mod <- glmnet(x,y,alpha=0,lambda=grid)

x11()
plot(ridge.mod,xvar='lambda',label=TRUE)

cv.out <- cv.glmnet(x,y,alpha=0,lambda=grid) # default: 10-fold cross validation
x11()
plot(cv.out)

# Select best lambda
bestlam <- cv.out$lambda.min
bestlam
log(bestlam)

x11()
plot(ridge.mod,xvar='lambda',label=TRUE)
abline(v=log(bestlam))

# Lasso
lasso.mod <- glmnet(x,y,alpha=1,lambda=grid)

x11()
plot(lasso.mod,xvar='lambda',label=TRUE)

cv.out <- cv.glmnet(x,y,alpha=1,lambda=grid) # default: 10-fold cross validation
x11()
plot(cv.out)

bestlam <- cv.out$lambda.1se
bestlam
log(bestlam)

x11()
plot(lasso.mod,xvar='lambda',label=TRUE)
abline(v=log(bestlam))

predict(lasso.mod,s=bestlam,type="coefficients")

# Even with Lasso, more than two coefficients are different from zero.

# Note: there are several packages and algorithms to build classification and regression trees, 
# such as 'rpart':
set.seed(02091991)
library(rpart)
tree.carseats_rpart <- rpart(High~.-Sales,Carseats)
x11()
par(mar=c(0,0,0,0))
plot(tree.carseats_rpart)
text(tree.carseats_rpart,pretty=0,use.n=TRUE)
