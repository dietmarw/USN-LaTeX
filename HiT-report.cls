%%****************************************
%%*                                      *
%%* TU Berlin                            *
%%* MDT                                  *
%%*                                      *
%%****************************************
%% LaTeX-class for writing theses
%%**************************************************************
%% Version: filename    rev date       time     last modified by
%%     $Id$
%%**************************************************************
%% (The "Id" tag above is updated automatically if
%% 	svn propset svn:keywords "Id" <filename>
%% was set.)
%%*******************************************
% -------------------------------Identification------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{MDT-SADA}[2007/01/31 Vorlage fuer TU Berlin MDT Studien- und Diplomarbeiten]

% Workaround for MiKTeX 2.5 \ifpdfoutput handling
\let\doifdefined\relax

% --------------------------- declaration of options ------------------------------------
% nologo-option
\newif\if@nologo
\@nologofalse
\DeclareOption{nologo} {%
  \@nologotrue%
  \renewcommand{\MDTlogo}{}%
  \renewcommand{\TUlogo}{}%
}%

% english-option Umschaltung auf Englisch (genauer britisches Englisch)
\newif\if@english
\@englishfalse
\DeclareOption{english} {%
  \@englishtrue%
  \PassOptionsToClass{british}{scrbook}
}%

% onlytoc-option
\newif\if@onlytoc
\@onlytocfalse
\DeclareOption{onlytoc}{\@onlytoctrue}

\newcommand{\extraBookmark}[2]{\ifpdfoutput{\pdfbookmark[1]{#1}{#2}}{}}
\newif\if@print
\@printfalse
\DeclareOption{print}{%
    \@printtrue%
%	\renewcommand{\extraBookmark}[2]{}% deactivated since we have references to some bookmarks!
}%

% index-option
\newcommand{\RequireIndex}{}
\newif\if@index
\@indexfalse
\DeclareOption{index} {%
  \@nologotrue%
  \renewcommand{\RequireIndex}{\RequirePackage{makeidx}\makeindex}%
}%

% Alle uebrigen Optionen werden an scrbook weitergereicht
\DeclareOption*{%
    \typeout{Option \CurrentOption\space is passed to package scrbook!}
    \PassOptionsToClass{\CurrentOption}{scrbook}
}%

% --------------------------- execution of options ------------------------------------
\ProcessOptions\relax
\LoadClass[halfparskip,DIV13,BCOR2cm]{scrbook}

% ----------------------------- package loading ---------------------------------------

%%Behandlung der pdf-Option. Dies wird eingefuehrt, um Uebersetzungszeit
%% zu sparen, wenn nur ein .ps erzeugt werden soll.
\ifpdfoutput{
    \RequirePackage[pdftex]{graphicx}
}{%\else
    \RequirePackage[dvips]{graphicx}
}%\fi
\graphicspath{{logos/}{bilder/}}
\newcommand{\MDTlogo}{\includegraphics[height=2cm]{MDT-logo}}
\newcommand{\TUlogo}{\includegraphics[height=2cm]{TU-logo_gruen}}
\ifpdfoutput{
    \if@print
        \RequirePackage[pdftex,plainpages=false,pdfpagelabels,pdfborder={0 0 0},hyperfootnotes=false]{hyperref}
        \renewcommand{\TUlogo}{\includegraphics[height=2cm]{TU-logo_sw}}
    \else
        \RequirePackage[pdftex,colorlinks=true,linkcolor=blue,urlcolor=blue,plainpages=false,pdfpagelabels,hyperfootnotes=false]{hyperref}
    \fi
}{%\else
    \RequirePackage[dvips]{hyperref}
    \if@print\renewcommand{\TUlogo}{\includegraphics[height=2cm]{TU-logo_sw}}\else\fi
}%\fi
\ifpdfoutput{}{%
    \IfFileExists{logos/MDT-logo.eps}%
        {}%
        {\renewcommand{\MDTlogo}{\fbox{\parbox[b][2cm][c]{2cm}{Logo\\MDT}}}}%
    \IfFileExists{logos/TU-logo_gruen.eps}%
        {}%
        {\renewcommand{\TUlogo}{\fbox{\parbox[b][2cm][c]{2cm}{Logo\\TU Berlin}}}}%
}%
\RequirePackage{lmodern}
\RequirePackage[T1]{fontenc}
\RequirePackage{mathptmx}
\RequirePackage[latin1]{inputenc}
\RequirePackage{ifthen}
\RequirePackage{url}
\RequirePackage[automark]{scrpage2}
\RequirePackage[\if@english british\else ngerman\fi]{babel}
%\RequirePackage{lastpage}
%\RequirePackage[ngerman,num]{isodate}
\RequirePackage{longtable}
\RequirePackage{caption} % fuer mehr Caption-Optionen
\RequirePackage{setspace} % fuer Zeilenabstandsanpassung
%Umbruch auch an Unterstrichen
%\lccode`\_=`\_
\RequireIndex

\addtolength{\voffset}{0.7cm}

%Redefinitionen---------------------------------
%Literaturverzeichnis statt nur Literatur
%\renewcommand{\refname}{Literaturverzeichnis}
\if@english \else \AtBeginDocument{\renewcommand*\figurename{Bild}}\fi

%Umgebungen------------------------------------
\newcommand{\includeBild}[3]%
{\ifthenelse%
        {\equal{#1}{}}%
        {\mbox{\parbox[b][5cm][c]{0.7\textwidth}{\begin{center}no picture\end{center}}}}%
        {\ifpdfoutput%
            {\mbox{\includegraphics[#3]{#1}}}%
            {\IfFileExists%
                {bilder/#1.eps}%
                {\mbox{\includegraphics[#3]{#1}}}%
                {\fbox{\parbox[b][5cm][c]{0.7\textwidth}{%
                    \begin{center}%
                        \path{#1.eps} nicht gefunden,\bigskip\\
                        {\footnotesize\path{#1.{pdf,png,jpg}}\\
                        (\ldots wird nicht in \jobname.dvi angezeigt!)}%
                    \end{center}%
                        }%
                }%
            }%
        }%
}%
    \captionsetup{indent=0pt,width=.9\textwidth}%
    \caption{#2}%
          \ifthenelse%
        {\equal{#1}{}}%
        {}%
        {\label{fig:#1}}%
}

\newcommand{\bild}[4][htb]{%
\begin{figure}[#1]%
    \centering%
    \includeBild{#2}{#3}{#4}
\end{figure}%
}

\newcommand{\bildhier}[3]{%
\begin{figure}[!ht]%
    \centering%
    \includeBild{#1}{#2}{#3}
\end{figure}%
}


\newcommand{\doppelbild}[7][htb]{%
\begin{figure}[#1]%
\begin{minipage}[t]{.45\textwidth}%
\centering%
  \includeBild{#2}{#3}{#4}%
\end{minipage}%
~\hfill~%
\begin{minipage}[t]{.45\textwidth}%
  \includeBild{#5}{#6}{#7}%
\end{minipage}%
\end{figure}%
}

%\newcommand{\maxHight}{0.925\textheight}
%\newcommand{\maxWidth}{0.5\textheight}

%\newcommand{\var}[1]{'\texttt{#1}'}
%\newcommand{\myitem}[1]{\item \textbf{#1}}

% Zähler für Zeilennnummerierungen in Tablellen
\newcounter{internal_tbl_cnt}[table]
\newcommand{\tblrow}{\refstepcounter{internal_tbl_cnt}\arabic{internal_tbl_cnt}.}

% #1 Autor
% #2 Matrikelnummer
% #3 Titel
% #4 Untertitel
% #5 Abgabedatum
% #6 Betreuer
\newcommand{\titelseite}[6]{%
% pdf document settings:
      \hypersetup{%
        pdftitle = {#3},%
        pdfsubject = {#4},%
        pdfauthor = {#1},%
        pdfcreator = {\LaTeX\ with package \flqq hyperref\frqq}%
    }%
    \extraBookmark{Titelseite}{titleanc}%
    \thispagestyle{empty}%
    \begin{titlepage}%
        \MDTlogo\hfill\TUlogo\\%
    \vfill%
    \begin{center}%
      %Titel und Untertitel%
     \begin{spacing}{2.5}
         {\textbf{{\Huge #3}\ifthenelse{\equal{#4}{}}{}{\\{\vspace*{3ex}\LARGE #4}}}}%
         \\[6ex]%
     \end{spacing}%
         {\Large #1\\ \# #2}\\%
        \vfill%
        \vfill%
            {\LARGE #5}\\%
        \vfill%
        \begin{minipage}[t]{0.25\textwidth}%
            \flushright\Large%
            \if@english Supervisor\else Betreuer\fi:~%
        \end{minipage}%
        \vspace{0pt}~%
        \begin{minipage}[t]{0.45\textwidth}%
            \flushleft\Large%
            #6%
        \end{minipage}%
                \vfill%
                    {\Large%
                    \if@english
                        Technische Universität Berlin\\%
                        School of Electrical Engineering and Computer Science\\%
                        Department of Energy and Automation Technology\\%
                        Chair of Electronic Measurement and Diagnostic Technology%
                    \else
                        Technische Universität Berlin\\%
                        Fakultät IV -- Elektrotechnik und Informatik\\%
                        Institut für Energie- und Automatisierungstechnik\\%
                        Fachgebiet Elektronische Mess- und Diagnosetechnik\\%
                    \fi%
                    }%
        \end{center}%
%
        \end{titlepage}%
    \cleardoublepage
    \makeHead{#1, \#\,#2}%
}

% Eidesstattliche Erklärung
\newcommand{\eidesstatt}[1][Berlin, den \today]
{%
    ~
    \vspace{.3\textheight}
    \begin{center}
    \section*{Eidesstattliche Erklärung}
    \end{center}
    Die selbständige und eigenhändige Anfertigung versichere ich an Eides Statt.\\

    \bigskip
    #1
}

% Inhaltsverzeichnis
\newcommand{\inhaltsverzeichnis}
{%
    \tableofcontents%
    \extraBookmark{\if@english Contents\else Inhaltsverzeichnis\fi}{tocanc}%
    \if@onlytoc\clearmydoublepage\else\fi%
}

\newcommand{\makeHead}[1]
{%
    \clearscrheadfoot%
    %\renewcommand{\headfont}{\normalfont\sffamily\bfseries}%
    \lehead{\leftmark}%
        \rohead{\rightmark}%
        \ifoot{#1}
    \ofoot{\pagemark}%
    %\setheadsepline{.4pt}%
    %\automark{subsection}%
    \pagestyle{scrheadings}%
    \deftripstyle{myChapterStyle}{}{}{}{#1}{}{\pagemark}
    \renewcommand*{\chapterpagestyle}{myChapterStyle}
}

\newcommand{\clearmydoublepage}{\newpage{\pagestyle{myChapterStyle}\cleardoublepage}}

\newlength{\FormelTabellenWeite}
\newenvironment{formelzeichen}[1][0.1]
{%
    \@openrightfalse%
    \setlength{\FormelTabellenWeite}{\textwidth}%
    \addtolength{\FormelTabellenWeite}{-#1\textwidth}%
    \addchap*{\if@english Symbols\else Formelzeichen\fi}%
    \extraBookmark{\if@english Symbols\else Formelzeichen\fi}{formulaanc}%
    \begin{longtable}{p{#1\textwidth}p{\FormelTabellenWeite}}
}{%
    \end{longtable}%
    \@openrighttrue%
    \clearmydoublepage
}%

\newenvironment{abkuerzungen}[1][0.2]
{%
    \@openrightfalse%
    \setlength{\FormelTabellenWeite}{\textwidth}%
    \addtolength{\FormelTabellenWeite}{-#1\textwidth}%
    \addchap*{\if@english Glossary\else Glossar\fi}%
    \extraBookmark{\if@english Glossary\else Glossar\fi}{abranc}%
    \begin{longtable}{p{#1\textwidth}p{\FormelTabellenWeite}}
}{%
    \end{longtable}%
    \@openrighttrue%
    \clearmydoublepage
}%

\newenvironment{literaturverzeichnis}
{\begin{thebibliography}{99}%
    \addcontentsline{toc}{chapter}{\if@english Bibliography\else Literatur\fi}%
%	\extraBookmark{\if@english Bibliography\else Literatur\fi}{litanc}
}
{\end{thebibliography}}

\newcommand{\indexverzeichnis}{%
    %\ifthenelse{\equal{\RequireIndex}{}}
        %{Fehler erzeugen, oder nix}
        %{untenstehende Befehle}
    \cleardoublepage%
    \phantomsection%
    \addcontentsline{toc}{chapter}{Index}%
    \printindex%
}

% Abstand der Paragraphen
\setlength{\parindent}{0pt}
\setlength{\parskip}{1.5mm }

%erste Version (abgeleitet von wise/ TU Dresden).
%
