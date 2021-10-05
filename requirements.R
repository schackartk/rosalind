#!/usr/bin/env Rscript

# Requirements for this repository

if (!require("pacman")) install.packages("pacman")
pacman::p_load("argparse",
               "lintr",
               "stringr",
               "readr",
               "testthat")