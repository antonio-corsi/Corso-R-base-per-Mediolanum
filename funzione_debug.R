f <- function (x,y,z=1){
  result <- x + (2*y) + (3*z)
  return(result)               # il valore della funzione.
  # se 'return' non è presente, il valore della funzione è quello assegnato nell'ultimo statement.
}
f(2,3,4)