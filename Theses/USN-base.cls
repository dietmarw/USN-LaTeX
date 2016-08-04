%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  LaTeX-class for writing theses  %%
%%                                  %%
%%  (c) Dietmar Winkler (me.dwe.no) %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ---Identification----
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{USN-base}[2016/08/01 Template base class for reports and theses]

% --- definitions of options ---

% All other options are passed on to the book class
\DeclareOption*{%
    \typeout{Option \CurrentOption\space is passed to package scrbook!}
    \PassOptionsToClass{\CurrentOption}{scrbook}
}%

% --- execution of options ---
\ProcessOptions* % process the options in calling order
\LoadClass{scrbook}
\KOMAoptions{%
  12pt,
  openright,
  cleardoublepage=plain,
  parskip=half,
  numbers=noendperiod,
  appendixprefix=true
}

% --- package loading ---
\RequirePackage{scrlayer-scrpage} %% needed for the footer setup
\RequirePackage{geometry}         %% manual set the page size
   \geometry{margin=25mm, includeheadfoot}
\RequirePackage[\if@norsk norsk \else british\fi]{babel}  %% adapt to NO or EN
\RequirePackage[utf8]{inputenc}   %% allow direct input of utf8 chars
\RequirePackage{lmodern}          %% use vector fonts
\RequirePackage[T1]{fontenc}      %% recommended for real glyphs in PDF
\RequirePackage{amsmath,mathptmx} %% we need lots of math features
\RequirePackage{ifthen}           %% provides simple if-then functionality
\RequirePackage{url}              %% helps displaying URLs
\RequirePackage{longtable}        %% for long tables that might break over pages
\RequirePackage{graphicx}         %% needed for inclusion of graphics
  \graphicspath{{fig/}}           %% this is were the images reside
\RequirePackage[hidelinks]{hyperref} %% generate links in the PDF (but no boxes around them)
\RequirePackage{pdfpages}         %% for inclusion of PDF documents
\RequirePackage{framed}           %% provides framebox
\RequirePackage{nth}              %% Generate English ordinal numbers

% --- useful commands
\newcommand*{\USNpreface}{\if@norsk Forord\else Preface\fi}
\newcommand*{\figref}[1]{\figurename~\ref{#1}}
\newcommand*{\tabref}[1]{\tablename~\ref{#1}}


% --- title page setup
\newcommand{\USNlogo}{%            %% lang dependent logo
  \if@norsk%
    \includegraphics[height=15mm]{HSN_logo}%
  \else%
    \includegraphics[height=15mm]{HSN_logo_en}%
  \fi%
}

\newcommand{\USNtitlehead}{%        %% define the USN title head
  \begin{minipage}{.5\textwidth}%
    \USNlogo%
  \end{minipage}%
  ~
  \begin{minipage}{.49\textwidth}%
    \begin{flushright}
      \textsf{\Large Bachelor -- Master -- PhD}\\
      {\large \url{www.usn.no}}
     \end{flushright}
  \end{minipage}%
}
\titlehead{\USNtitlehead}

\publishers{\textsf{%
       \if@norsk%
         {\Large Fakultet for teknologi, naturvitenskap og maritime fag}
       \else%
         {\Large Faculty of Technology}
       \fi%
       \\{\large Campus Porsgrunn}}
    }%
