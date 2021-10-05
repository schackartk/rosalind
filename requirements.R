#!/usr/bin/env Rscript

# Requirements for this repository

if (!require("pacman")) install.packages("pacman")
pacman::p_load("argparse",
               "fs",
               "lintr",
               "stringr",
               "readr",
               "testthat")