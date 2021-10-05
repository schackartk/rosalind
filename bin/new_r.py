#!/usr/bin/env python3
"""
Author : Kenneth Schackart <schackartk1@gmail.com>
Purpose: Python program to create new R files
"""

import argparse
import os
import platform
import re
import subprocess
import sys
from datetime import date
from pathlib import Path

from typing import NamedTuple, Optional, TextIO


class Args(NamedTuple):
    """ Command-line arguments """
    program: str
    name: str
    email: str
    purpose: str
    overwrite: bool


# --------------------------------------------------
def get_args() -> Args:
    """ Get arguments """

    parser = argparse.ArgumentParser(
        prog='new_r.py',
        description='Create a new R file',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    rc_file = os.path.join(str(Path.home()), '.new_r.py')
    defaults = get_defaults(open(rc_file) if os.path.isfile(rc_file) else None)
    username = os.getenv('USER') or 'Anonymous'
    hostname = os.getenv('HOSTNAME') or 'localhost'

    parser.add_argument('program', help='New R file name', type=str)

    parser.add_argument('-n',
                        '--name',
                        type=str,
                        default=defaults.get('name', username),
                        help='Name for docstring')

    parser.add_argument('-e',
                        '--email',
                        type=str,
                        default=defaults.get('email',
                                             f'{username}@{hostname}'),
                        help='Email address')

    parser.add_argument('-p',
                        '--purpose',
                        type=str,
                        default=defaults.get('purpose', 'Do some stuff'),
                        help='Purpose for docstring')

    parser.add_argument('-f',
                        '--force',
                        help='Overwrite existing',
                        action='store_true')

    args = parser.parse_args()

    args.program = args.program.strip().replace('-', '_')

    if not args.program:
        parser.error(f'Not a usable filename "{args.program}"')

    return Args(program=args.program,
                name=args.name,
                email=args.email,
                purpose=args.purpose,
                overwrite=args.force)


# --------------------------------------------------
def main() -> None:
    """ The good stuff """

    args = get_args()
    program = args.program

    if os.path.isfile(program) and not args.overwrite:
        answer = input(f'"{program}" exists.  Overwrite? [yN] ')
        if not answer.lower().startswith('y'):
            sys.exit('Will not overwrite. Bye!')

    print(get_script(args), file=open(program, 'wt'), end='')

    if platform.system() != 'Windows':
        subprocess.run(['chmod', '+x', program], check=True)

    print(f'Done, see new script "{program}".')


# --------------------------------------------------
def get_script(args: Args) -> str:
    """ R script template """

    return f"""#!/usr/bin/env Rscript

# Author : {args.name}{' <' + args.email + '>' if args.email else ''}
# Date   : {str(date.today())}
# Purpose: {args.purpose}

# Imports -------------------------------------------------------------------

## Library calls ------------------------------------------------------------

library(magrittr)

# Argument Parsing ----------------------------------------------------------

#' Parse Arguments
#'
#' Parse command line arguments using argparse.
#'
#' @return args
get_args <- function() {{
    parser <- argparse::ArgumentParser()

    parser$add_argument("positional",
                         help = "A positional argument",
                         metavar = "STR")
    parser$add_argument("-o",
                        "--on",
                        help = "A boolean flag",
                        action = "store_true"
                        )
    parser$add_argument("-i",
                        "--int",
                        help = "A named numerical argument",
                        metavar = "INT",
                        type = "integer",
                        default = 0
                        )
    parser$add_argument("-s",
                        "--str",
                        help = "A named string argument",
                        metavar = "STR",
                        type = "character",
                        default = ""
                        )

    args <- parser$parse_args()

    return(args)

}}

# Main ----------------------------------------------------------------------

#' Main Function
#'
#' @return
main <- function() {{

    args <- get_args()

    print(args$positional)
    print(args$on)
    print(args$int)
    print(args$str)
}}

# Call Main -----------------------------------------------------------------
if (!interactive()) {{
  main()
}}

"""


# --------------------------------------------------
def get_defaults(file_handle: Optional[TextIO]):
    """ Get defaults from ~/.new_r.py """

    defaults = {}
    if file_handle:
        for line in file_handle:
            match = re.match('([^=]+)=([^=]+)', line)
            if match:
                key, val = map(str.strip, match.groups())
                if key and val:
                    defaults[key] = val

    return defaults


# --------------------------------------------------
if __name__ == '__main__':
    main()
