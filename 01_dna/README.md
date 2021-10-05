# Couting tetranucleotide frequency

http://rosalind.info/problems/dna/

Create a program called `dna.R` that will accept a sequence of DNA as a single positional argument. The program should print a "usage" statement for `-h` or `--help` flags:

```
$ ./dna.R -h
usage: ./dna.R [-h] DNA

positional arguments:
  DNA         Input DNA sequence

optional arguments:
  -h, --help  show this help message and exit
```

The progran should print the frequencies of the bases A, C, G, and T.

```
$ ./dna.R AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
20 12 17 21
```

The porogram should also accept files that contain DNA sequences as input

```
$ ./dna.R tests/inputs/input1.txt
1 2 3 4
```