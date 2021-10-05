#!/usr/bin/env Rscript

# Author : Kenneth Schackart <schackartk1@gmail.com>
# Date   : 2021-09-30
# Purpose: Do some stuff

# Library Calls  ------------------------------------------------------------

library(argparse)
library(stringr)


# Argument Parsing ----------------------------------------------------------

#' Parse Arguments
#'
#' Parse command line arguments using argparse.
#'
#' @return args
get_args <- function() {
  parser <- argparse::ArgumentParser()

  parser$add_argument("dna",
                      metavar = "DNA",
                      help = "Input DNA sequence",
                      type = "character")

  args <- parser$parse_args()

  if (file.exists(args$dna)) {
    args$dna <- readr::read_file(args$dna)
  }

  return(args)

}

# Main ----------------------------------------------------------------------

#' Main Function
#'
#' @return
main <- function() {

  args <- get_args()

  counts <- list()

  for (nt in c("A", "C", "G", "T")) {
    counts[nt] <- stringr::str_count(args$dna, nt)
  }

  print(stringr::str_glue("{counts$A} {counts$C} {counts$G} {counts$T}"))
}

# Call Main -----------------------------------------------------------------
if (!interactive()) {
  main()
}
