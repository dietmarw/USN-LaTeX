# USN-LaTeX file repository
This repository is used for the development of *L<sup>A</sup>T<sub>E</sub>X* templates for the use at the
[University of South-Eastern Norway - USN](http://www.usn.no)

## Installation and usage of the project template
All current templates now **need** to be processed using either [LuaLaTeX](https://en.wikipedia.org/wiki/LuaTeX) or [XeLaTeX](https://en.wikipedia.org/wiki/XeTeX) engines.
Processing with the deprecated `latex` or `pdflatex` commands will not work.
Both, *XeLaTeX* and *LuaLaTeX*, are shipped with all major LaTeX distributions (e.g., MiKTeX, MacTeX, TeXLive) and you just need to configure your system  to use one of them.

### Theses templates:

The files can be found under the [`Theses`](Theses) directory.

#### `BScThesis`
A template for BSc project reports and theses. It consists of:
  * [`BScThesis.pdf`](https://github.com/dietmarw/USN-LaTeX/raw/master/Theses/BScThesis.pdf): Example PDF file created using `BScThesis.tex`.
  * [`BScThesis.tex`](Theses/BScThesis.tex): Example LaTeX file for editing
  * [`thesis.bib`](Theses/thesis.bib): Example BibTeX file used by `BScThesis.tex`
  * [`USN-BSc.cls`](Theses/USN-BSc.cls): Special LaTeX class file used by `BScThesis.tex` (**Do not edit!**)
  * [`USN-base.cls`](Theses/USN-base.cls): Special LaTeX base class file used by `USN-BSc.cls` (**Do not edit!**)

#### `MScThesis`
A template for MSc project reports and theses. It consists of:
  * [`MScThesis.pdf`](https://github.com/dietmarw/USN-LaTeX/raw/master/Theses/MScThesis.pdf): Example PDF file created using `MScThesis.tex`.
  * [`MScThesis.tex`](Theses/MScThesis.tex): Example LaTeX file for editing
  * [`thesis.bib`](Theses/thesis.bib): Example BibTeX file used by `MScThesis.tex`
  * [`USN-MSc.cls`](Theses/USN-MSc.cls): Special LaTeX class file used by `MScThesis.tex` (**Do not edit!**)
  * [`USN-base.cls`](Theses/USN-base.cls): Special LaTeX base class file used by `USN-MSc.cls` (**Do not edit!**)

#### `PhDThesis`
A current template for PhD theses. It consists of:
  * [`PhDThesis.pdf`](https://github.com/dietmarw/USN-LaTeX/raw/master/Theses/PhDThesis.pdf): Example PDF file created using `PhDThesis.tex`.
  * [`PhDThesis.tex`](Theses/PhDThesis.tex): Example LaTeX file for editing
  * [`thesis.bib`](Theses/thesis.bib): Example BibTeX file used by `PhDThesis.tex`
  * [`USN-PhD.cls`](Theses/USN-PhD.cls): Special LaTeX class file used by `PhDThesis.tex` (**Do not edit!**)
  * [`USN-base.cls`](Theses/USN-base.cls): Special LaTeX base class file used by `USN-PhD.cls` (**Do not edit!**)

#### Older project files
  * [`oldPhDThesis`](Theses/oldPhDThesis): Working but outdated PhDThesis template.
  * [`oldBScExample`](Theses/oldBScExample): is kept for historical references. It's an example report done by students and parts were used for the new *BScThesis* template

### Logos:

A repository of the offical USN logos in proper vector formats can.
  * [`logos`](logos)

## License

&copy; Dietmar Winkler

This work may be distributed and/or modified under the
conditions of the [LaTeX Project Public License](LICENSE), either version 1.3
of this license or (at your option) any later version.
The latest version of this license is in
http://www.latex-project.org/lppl.txt
and version 1.3 or later is part of all distributions of LaTeX
version 2005/12/01 or later.

## Development and contribution
The templates are developed by [@dietmarw](https://github.com/dietmarw)

You may report any issues with using the [Issues](../../issues) button.

Contributions in shape of [Pull Requests](../../pulls) are always welcome.
