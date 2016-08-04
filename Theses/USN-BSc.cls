%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  LaTeX-class for writing theses  %%
%%                                  %%
%%  (c) Dietmar Winkler             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ---Identification----
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{USN-BSc}[2016/08/01 Template class for reports and theses]

% --- definitions of options ---

% norsk option
\newif\if@norsk
\@norskfalse
\DeclareOption{norsk}{\@norsktrue}
\PassOptionsToClass{\if@norsk norsk \else english\fi}{scrbook}

% All other options are passed on to the book class
\DeclareOption*{%
    \typeout{Option \CurrentOption\space is passed to package scrbook!}
    \PassOptionsToClass{\CurrentOption}{scrbook}
}%

% --- execution of options ---
\ProcessOptions\relax
\LoadClass[12pt, openright]{scrbook}
\KOMAoptions{%
  cleardoublepage=plain,
  parskip=half,
  numbers=noendperiod,
  appendixprefix=true
}

% --- package loading ---
\RequirePackage{scrlayer-scrpage}
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

%--- special footer setup
% norsk:
\newpagestyle{sammendrag}{}{
 \cfoot{\begin{center}%
     Høgskolen i Sørøst-Norge tar ikke ansvar for denne studentrapportens resultater og konklusjoner.
   \end{center}}
}
% english
\newpagestyle{summary}{}{
 \cfoot{\begin{center}%
     The University College of Southeast Norway takes no responsibility for the results and conclusions in this student report.
   \end{center}}
}

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
    \USNlogo
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

\newcommand{\mysubject}[1]{%
  \if@norsk%
  {Rapport fra #1. semesters <Bachelorprosjekt> \the\year}
  \else%
  {Report from \nth{#1} semester Bachelor project \the\year}
  \fi%
}

\newcommand{\USNtitlepage}[8]{%
% #1 subject
% #2 optional figure
% #3 date
% #4 authors
% #5 confidential
% #6 Project partner
% #7 Norwegian Summary
% #8 English Summary
  \subject{\large \mysubject{#1}}
  \title{\mytitle}
  \subtitle{\mysubtitle\\#2}
  \author{\large \myauthor}
  \date{#3}
% --- pdf document settings ---
  \hypersetup{%
    pdftitle = {\mytitle},%
    pdfsubject = {\mysubject{#1}},%
    pdfauthor = {#4}
  }%
\pdfbookmark[0]{\@title}{title}    %% set the correct PDF bookmark
\maketitle%
%
\cleardoubleemptypage              %% fillpage without page number
%
\if@norsk%           %% only display Norwegian summary page for norsk
{% --- norwegian summary page ---
\thispagestyle{sammendrag}
\label{Sammendrag}\pdfbookmark[1]{Sammendrag}{Sammendrag}
\USNtitlehead%
\par\bigskip
{\large \textbf{\mysubject{#1}}}

\begin{tabbing}
    \textbf{Emne:~}   \= \textit{\mysubtitle} \\
    \textbf{Tittel:~} \> \textit{\mytitle}
\end{tabbing}

Rapporten utgjør en del av vurderingsgrunnlaget i emnet.

\textbf{Prosjektgruppe:~} \textit{\myauthor}
\hfill \textbf{Tilgjengelighet:~}
\textit{\ifthenelse{\equal{#5}{yes}}{Fortrolig}{Åpen}}

\begin{tabbing}
  \textbf{Gruppedeltakere:~}  \=
  \begin{minipage}[t]{0.5\textwidth}
    \textit{#4}
  \end{minipage}\\
  ~\\
  \textbf{Veileder:~} \> \textit{\supervisor} \\
  \textbf{Sensor:~}   \> \textit{\examiner}\\
  \textbf{Prosjektpartner:~} \>\textit{#6}
\end{tabbing}
~\\
\textbf{Godkjent for arkivering: }\hrulefill
\vfill
\begin{framed}
\textbf{Sammendrag:}\\
{\small #7}
\end{framed}
%
\cleardoubleemptypage              %% fillpage without page number
}
\else%
{}
\fi%
% --- english abstract page ---
\thispagestyle{summary}
\label{Summary}\pdfbookmark[1]{Summary}{Summary}
\USNtitlehead
\par\bigskip
\if@norsk{%
  \@norskfalse  % make sure to use the english versions
  {\large \textbf{\mysubject{#1}}}
  \@norsktrue  % back to norsk
}
\else%
{\large \textbf{\mysubject{#1}}}
\fi%

\begin{tabbing}
  \textbf{Course:~}   \= \textit{\mysubtitle} \\
  \textbf{Titel:~} \> \textit{\mytitle}
\end{tabbing}

This report forms part of the basis for assessing the student's performance on the course.

\textbf{Projekt group:} \textit{\myauthor}
\hfill \textbf{Availability:~}
\textit{\ifthenelse{\equal{#5}{yes}}{Confidential}{Open}}

\begin{tabbing}
  \textbf{Group participants:~}  \=
  \begin{minipage}[t]{0.5\textwidth}
    \textit{#4}
  \end{minipage}\\
  ~\\
  \textbf{Supervisor:~} \> \textit{\supervisor} \\
  \textbf{Examiner:~}   \> \textit{\examiner}\\
  \textbf{Project partner:~} \> \textit{#6}
\end{tabbing}
~\\
\textbf{Approved for archiving: }\hrulefill
\vfill
\begin{framed}
  \textbf{Summary:}\\
  {\small #8}
\end{framed}
%
\cleardoubleemptypage              %% fillpage without page number
}
