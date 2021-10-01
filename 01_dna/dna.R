#!/usr/bin/env Rscript

# Author : Kenneth Schackart <schackartk1@gmail.com>
# Date   : 2021-09-30
# Purpose: Do some stuff

# Library Calls  ------------------------------------------------------------

library(argparse)


# Argument Parsing ----------------------------------------------------------

parser <- ArgumentParser()

parser$add_argument("-v",
                    "--verbose",
                    action="store_true",
                    help="Print extras")

args <- parser$parse_args()


# Main ----------------------------------------------------------------------
if ( args$verbose ) {
    print("verbose activated")
}

