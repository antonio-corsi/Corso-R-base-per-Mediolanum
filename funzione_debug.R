f <- function (x,y,z=1){
  result <- x + (2*y) + (3*z)
  return(result)               # il valore della funzione.
  # se 'return' non è presente, il valore della funzione è quello assegnato nell'ultimo statement.
}

# f(2,3,4)   # PRIMA fare source

# - rosso pieno = breakpoint attivo
# - rosso vuoto = breakpoint presente ma disabilitato
# - freccia verde = riga corrente dove il codice è fermo in debug

# Si esce dal debug con Q