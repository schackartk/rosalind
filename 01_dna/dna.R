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


# Main ----------------------------------------------------------------------

in_dna <- args$dna

counts <- list(
    "A" = str_count(in_dna, "A"),
    "C" = str_count(in_dna, "C"),
    "T" = str_count(in_dna, "T"),
    "G" = str_count(in_dna, "G")
)

print(str_glue("{counts$A} {counts$C} {counts$G} {counts$T}"))