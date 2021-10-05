#!/usr/bin/env Rscript

# Author : Kenneth Schackart <schackartk1@gmail.com>
# Date   : 2021-09-30
# Purpose: Do some stuff

# Library Calls  ------------------------------------------------------------

library(argparse)
library(stringr)


# Argument Parsing ----------------------------------------------------------

parser <- ArgumentParser()

parser$add_argument("dna",
                    metavar = "DNA",
                    help = "Input DNA sequence",
                    type = "character")

args <- parser$parse_args()

if (file.exists(args$dna)) {
  args$dna <- readr::read_file(args$dna)
}


# Main ----------------------------------------------------------------------

counts <- list()

for (nt in c("A", "C", "G", "T")) {
  counts[nt] = str_count(args$dna, nt)
}

print(str_glue("{counts$A} {counts$C} {counts$G} {counts$T}"))
