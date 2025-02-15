#!/usr/bin/env python
#===- gen_std.py -  ------------------------------------------*- python -*--===#
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===------------------------------------------------------------------------===#

"""gen_std.py is a tool to generate a lookup table (from qualified names to
include headers) for C/C++ Standard Library symbols by parsing archived HTML
files from cppreference.

The generated files are located in clang/include/Tooling/Inclusions.

Caveats and FIXMEs:
  - only symbols directly in "std" namespace are added, we should also add std's
    subnamespace symbols (e.g. chrono).
  - symbols with multiple variants or defined in multiple headers aren't added,
    e.g. std::move, std::swap

Usage:
  1. Install BeautifulSoup dependency, see instruction:
       https://www.crummy.com/software/BeautifulSoup/bs4/doc/#installing-beautiful-soup
  2. Download cppreference offline HTML files (html_book_20220730.zip in Unofficial Release) at
       https://en.cppreference.com/w/Cppreference:Archives
  3. Unzip the zip file from step 2 (e.g., to a "cppreference" directory). You should
     get a "cppreference/reference" directory.
  4. Run the command:
       // Generate C++ symbols
       python3 gen_std.py -cppreference cppreference/reference -symbols=cpp > StdSymbolMap.inc
       // Generate C symbols
       python3 gen_std.py -cppreference cppreference/reference -symbols=c > CSymbolMap.inc
"""


import cppreference_parser
import argparse
import datetime
import os
import sys


CODE_PREFIX = """\
//===-- gen_std.py generated file -------------------------------*- C++ -*-===//
//
// Used to build a lookup table (qualified names => include headers) for %s
// Standard Library symbols.
//
// This file was generated automatically by
// clang/tools/include-mapping/gen_std.py, DO NOT EDIT!
//
// Generated from cppreference offline HTML book (modified on %s).
//===----------------------------------------------------------------------===//
"""

def ParseArg():
  parser = argparse.ArgumentParser(description='Generate StdGen file')
  parser.add_argument('-cppreference', metavar='PATH',
                      default='',
                      help='path to the cppreference offline HTML directory',
                      required=True
                     )
  parser.add_argument('-symbols',
                      default='cpp',
                      help='Generate c or cpp (removed) symbols. One of {cpp, c, cpp_removed}.',
                      required=True) 
  return parser.parse_args()

def AdditionalHeadersForIOSymbols(symbol):
  # IO-related symbols declared in the <iosfwd> header, per C++
  # [iosfwd.syn 31.3.1]:
  iosfwd_symbols = [
      'basic_ios',
      'basic_streambuf',
      'basic_istream',
      'basic_ostream',
      'basic_iostream',

      'basic_stringbuf',
      'basic_istringstream',
      'basic_ostringstream',
      'basic_stringstream',

      'basic_spanbuf',
      'basic_ispanstream',
      'basic_ospanstream',
      'basic_spanstream',

      'basic_filebuf',
      'basic_ifstream',
      'basic_ofstream',
      'basic_fstream',

      'basic_syncbuf',
      'basic_osyncstream',

      'istreambuf_iterator',
      'ostreambuf_iterator',

      'ios',
      'wios',

      'streambuf',
      'istream',
      'ostream',
      'iostream',

      'stringbuf',
      'istringstream',
      'ostringstream',
      'stringstream',

      'spanbuf',
      'ispanstream',
      'ospanstream',
      'spanstream',

      'filebuf',
      'ifstream',
      'ofstream',
      'fstream',

      'syncbuf',
      'osyncstream',

      'wstreambuf',
      'wistream',
      'wostream',
      'wiostream',

      'wstringbuf',
      'wistringstream',
      'wostringstream',
      'wstringstream',

      'wspanbuf',
      'wispanstream',
      'wospanstream',
      'wspanstream',

      'wfilebuf',
      'wifstream',
      'wofstream',
      'wfstream',

      'wsyncbuf',
      'wosyncstream',

      'fpos',
      'streampos',
      'wstreampos',
      'u8streampos',
      'u16streampos',
      'u32streampos',
  ]
  assert(len(symbol.headers) == 1)
  sym_header = symbol.headers[0]
  headers = []
  # <iostream> is preferred than <iosfwd>

  # <iostream> is an alternative of <streambuf>, <istream>, <ostream>, <ios>.
  # per C++ [iostream.syn 31.4.1]
  if sym_header in ["<ios>", "<istream>", "<ostream>", "<streambuf>"]:
    headers.append("<iostream>")

  if symbol.name in iosfwd_symbols:
    headers.append("<iosfwd>")

  return headers


def main():
  args = ParseArg()
  if args.symbols == 'cpp':
    page_root = os.path.join(args.cppreference, "en", "cpp")
    symbol_index_root = os.path.join(page_root, "symbol_index")
    parse_pages =  [
      (page_root, "symbol_index.html", "std::"),
      # std sub-namespace symbols have separated pages.
      # We don't index std literal operators (e.g.
      # std::literals::chrono_literals::operator""d), these symbols can't be
      # accessed by std::<symbol_name>.
      # FIXME: index std::placeholders symbols, placeholders.html page is
      # different (which contains one entry for _1, _2, ..., _N), we need special
      # handling.
      (symbol_index_root, "chrono.html", "std::chrono::"),
      (symbol_index_root, "filesystem.html", "std::filesystem::"),
      (symbol_index_root, "pmr.html", "std::pmr::"),
      (symbol_index_root, "regex_constants.html", "std::regex_constants::"),
      (symbol_index_root, "this_thread.html", "std::this_thread::"),
      # Zombie symbols that were available from the Standard Library, but are
      # removed in the following standards.
      (symbol_index_root, "zombie_names.html", "std::"),
    ]
  elif args.symbols == 'c':
    page_root = os.path.join(args.cppreference, "en", "c")
    symbol_index_root = page_root
    parse_pages = [(page_root, "index.html", None)]  
    
  if not os.path.exists(symbol_index_root):
    exit("Path %s doesn't exist!" % symbol_index_root)

  symbols = cppreference_parser.GetSymbols(parse_pages)
  
  # We don't have version information from the unzipped offline HTML files.
  # so we use the modified time of the symbol_index.html as the version.
  index_page_path = os.path.join(page_root, "index.html")
  cppreference_modified_date = datetime.datetime.fromtimestamp(
    os.stat(index_page_path).st_mtime).strftime('%Y-%m-%d')
  print(CODE_PREFIX % (args.symbols.upper(), cppreference_modified_date))
  for symbol in symbols:
    if len(symbol.headers) == 1:
      # SYMBOL(unqualified_name, namespace, header)
      symbol.headers.extend(AdditionalHeadersForIOSymbols(symbol))
      for header in symbol.headers:
        print("SYMBOL(%s, %s, %s)" % (symbol.name, symbol.namespace,
                                      header))
    elif len(symbol.headers) == 0:
      sys.stderr.write("No header found for symbol %s\n" % symbol.name)
    else:
      # FIXME: support symbols with multiple headers (e.g. std::move).
      sys.stderr.write("Ambiguous header for symbol %s: %s\n" % (
          symbol.name, ', '.join(symbol.headers)))


if __name__ == '__main__':
  main()
