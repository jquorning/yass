YASS - Yet Another Static Site (Generator)

As name says, it is static site generator written in Ada. It is *headless*
application (no UI yet). At this moment documentation is under
construction.

## Features

* Support almost infinite amount of custom tags in HTML templates (depends
  on available RAM)

* Separated tags for whole site and each page

* Fast

* Freshly created, unpolished, have a few bugs :D

## Build from sources

To build you need:

* compiler - GCC with enabled Ada support or (best option) GNAT from:

  https://www.adacore.com/download/

* gprbuild - it is included in GNAT and should be available in most Linux
  distributions too.

* libcmark - should be available in every Linux distribution, if not, you
  can download source code from:

  https://github.com/commonmark/cmark

* Ada Web Server (AWS) - if you use GNAT from AdaCore it is included in
  package. In other situations, you may need to download it from:

  https://www.adacore.com/download/more

  or

  https://github.com/AdaCore/aws

Navigate to the main directory(where this file is) to compile:

* Easiest way to compile program is use Gnat Programming Studio included in
  GNAT. Just run GPS, select *yass.gpr* as a project file and select option
  `Build All`.

* If you prefer using console: in main source code directory type `gprbuild`
  for debug mode build or for release mode: `gprbuild -XMode=release`.

## Running program

### Linux (probably MacOS too)

To see all available options, type in console `./yass help` in directory where
binary file is.

## Roadmap

### 0.3

- Optimize site regeneration
- Arrays of tags

### 0.4

- Server setting (port, file check interval)
- Scripting with Lua (or Python, or Common Lisp)

### Later

- GUI
- Your proposition(s)

Bartek thindil Jasicki
