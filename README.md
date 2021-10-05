# Rosalind in R

This repository will go through the problems in [Mastering Python for Bioinformatics](https://github.com/kyclark/biofx_python), but in R. This will include using testing to ensure that the programs work as expected.

## Getting Started

### Clone this repository

```
git clone git@github.com:schackartk/rosalind.git
```

### Configure git to correct line endings

When moving between OSs for collaboration, the line endings may change. To keep the R code compatible, configure git to change line endings to whichever system it is pulling to.

**Mac OS & Linux**

```
git config --global core.autocrlf input
```

**Windows**

```
git config --global core.autocrlf true
```

### Install Dependencies

If you are on a unix system, you can run

```
make install
```

Otherwise, you can run the following from the top level directory

```
Rscript requirements.R
```

## How this works

The tasks in this repository may be quite different than you may be used to addressing in R. The way I approach these problems is how I learned to in Python, but even then you may not be used to doing it this way in Python

### Command-line executable scripts

All of the challenges will result in scripts that are executable *from the command line*. This has many advantages, such as removing hard-coded paths, making programs modular, and allowing them to be integrated into pipelines.

To accomplish this, we will use the package `argparse` which is modeled after the Python package of the same name. This allows programs to take arguments that affect their behavior (again, instead of hard-coded inflexible code).

To allow you to focus on writing code and not retyping boiler-plate stuff, I have provided a template generating script located at [bin/new.R](bin/new.R). This will create a script template that uses argparse.

### Testing

Additionally, all programs will be evaluated using automated testing (via the package `testthat`). Testing is crucial to software development, and is often overlooked by typical useRs.

## The Routine

### Program description

Each program directory (e.g. `01_dna`) will contain a README.md describing what your program should do. Read that to get started.

### Write code

Based on the description, write a command-line executable R program to meet the specifications in the README.

### Test your code

Run the following from each program directory:

*On Unix*
```
make test
```
*On Windows*
```
Rscript -e 'testthat::test_dir("tests/testthat")'
```

### Repeat

Keep modifying your code until all tests pass.
