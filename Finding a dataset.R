library(tidyverse)
library(stringr)
library(DT)

# Function to catch the error for data that is not exported.
unexportedData <- function (x) {
  out <- tryCatch(class(eval(parse(text = x))), error = function(e) "NOT EXPORTED")
  return(out)
}

all_ds <- data(package = .packages(all.available = TRUE)) %>%
  .$results %>%
  tibble::as_tibble() %>%
  dplyr::mutate(DataOrig = stringr::word(Item, 1)) %>%
  dplyr::mutate(pkgData = paste(Package, DataOrig, sep="::")) %>%
  dplyr::arrange(pkgData) %>%
  dplyr::mutate(Class = purrr::invoke_map(unexportedData, pkgData)) %>%
  tidyr::unnest(Class) %>%
  dplyr::filter(!str_detect(Class, "NOT EXPORTED")) %>%
  dplyr::select(pkgData, Package, DataOrig, Title, Class) %>%
  dplyr::arrange(pkgData, Class) %>%
  dplyr::mutate(Val = Class) %>%
  tidyr::spread(key = Class, value=Val, fill = "") %>%
  tidyr::unite(Classes, c(-pkgData, -Package, -DataOrig, -Title), sep= " ")

DT::datatable(all_ds)
