#!/usr/bin/env Rscript

# Author : Kenneth Schackart <schackartk1@gmail.com>
# Date   : 2021-09-30
# Purpose: Do some stuff

# Create parser object -------------------------------------------------------------------

parser <- ArgumentParser()

parser$add_argument("-v",
                    "--verbose",
                    action="store_true",
                    help="Print extra output")

args <- parser$parse_args()

if ( args$verbose ) {
  print("verbose")
}
