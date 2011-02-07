%%****************************************
%%*                                      *
%%* Telemark University College                            *
%%* EIK                                  *
%%*                                      *
%%****************************************
%% LaTeX-class for writing project reports
% -------------------------------Identification------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{HiT-report}[2011/01/31 Template for writing reports at Telemark University]

% % TODO: Probably not needed anymore.
% % Workaround for MiKTeX 2.5 \ifpdfoutput handling
% \let\doifdefined\relax

% --------------------------- declaration of options ------------------------------------
% % nologo-option (not used since we alway want to have the logo)
% \newif\if@nologo
% \@nologofalse
% \DeclareOption{nologo} {%
%   \@nologotrue%
%   \renewcommand{\MDTlogo}{}%
%   \renewcommand{\TUlogo}{}%
% }%

% norwegian-option: switches to Norwegian ((British) English is the default)
\newif\if@norsk
\@norskfalse
\DeclareOption{norsk} {%
  \@norsktrue%
  \PassOptionsToClass{norsk}{report}
}%

% onlytoc-option
\newif\if@onlytoc
\@onlytocfalse
\DeclareOption{onlytoc}{\@onlytoctrue}

\newcommand{\extraBookmark}[2]{\pdfbookmark[1]{#1}{#2}}
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
  \@indextrue%
  \renewcommand{\RequireIndex}{\RequirePackage{makeidx}\makeindex}%
}%

% utf8-option TODO: document this new option
\newif\if@utf
\@utffalse
\DeclareOption{utf}{\@onlytoctrue}



% TODO used book instead of report for now
% All remaining options are passed to the 'report' package
\DeclareOption*{%
    \typeout{Option \CurrentOption\space is passed to package report!}
    \PassOptionsToClass{\CurrentOption}{book}
}%

% --------------------------- execution of options ------------------------------------
\ProcessOptions\relax
\LoadClass[a4paper]{book}

% ----------------------------- package loading ---------------------------------------

%% pdf-options
\RequirePackage{graphicx}
\graphicspath{{logos/}{bilder/}}
\newcommand{\TFlogo}{\includegraphics[height=2cm]{TF-logo}}
\newcommand{\HiTlogo}{\includegraphics[height=2cm]{HiT-logo}}
  \if@print
  \RequirePackage[pdftex,plainpages=false,pdfpagelabels,pdfborder={0 0 0},hyperfootnotes=false]{hyperref}
  \renewcommand{\HiTlogo}{\includegraphics[height=2cm]{HiT-logo_bw}}
  \else
  \RequirePackage[pdftex,colorlinks=true,linkcolor=blue,urlcolor=blue,plainpages=false,pdfpagelabels,hyperfootnotes=false]{hyperref}
  \fi

\RequirePackage{lmodern}
\RequirePackage[T1]{fontenc}
\RequirePackage{mathptmx}
\RequirePackage[\if@utf utf8 \else latin1\fi]{inputenc}
\RequirePackage{ifthen}
\RequirePackage{url}
\RequirePackage[automark]{scrpage2}
\RequirePackage[\if@norsk norsk\else british\fi]{babel}
%\RequirePackage{lastpage}
%\RequirePackage[ngerman,num]{isodate}
\RequirePackage{longtable}
\RequirePackage{caption} % for more Caption options
\RequirePackage{setspace} % for setting the line spacsing
\RequireIndex

\addtolength{\voffset}{0.7cm}

%Redefinitionen---------------------------------
% %Literaturverzeichnis statt nur Literatur
% %\renewcommand{\refname}{Literaturverzeichnis}
% \if@english \else \AtBeginDocument{\renewcommand*\figurename{Bild}}\fi

%Umgebungen------------------------------------
\newcommand{\includeBild}[3]%
{\ifthenelse%
        {\equal{#1}{}}%
        {\mbox{\parbox[b][5cm][c]{0.7\textwidth}{\begin{center}no picture\end{center}}}}%
        {\mbox{\includegraphics[#3]{#1}}}%
%         {\ifpdfoutput%
%             {\mbox{\includegraphics[#3]{#1}}}%
%             {\IfFileExists%
%                 {bilder/#1.eps}%
%                 {\mbox{\includegraphics[#3]{#1}}}%
%                 {\fbox{\parbox[b][5cm][c]{0.7\textwidth}{%
%                     \begin{center}%
%                         \path{#1.eps} nicht gefunden,\bigskip\\
%                         {\footnotesize\path{#1.{pdf,png,jpg}}\\
%                         (\ldots wird nicht in \jobname.dvi angezeigt!)}%
%                     \end{center}%
%                         }%
%                 }%
%             }%
%         }%
% }%
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
        \TFlogo\hfill\HiTlogo\\%
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
            \if@norsk Supervisor\else Betreuer\fi:~%
        \end{minipage}%
        \vspace{0pt}~%
        \begin{minipage}[t]{0.45\textwidth}%
            \flushleft\Large%
            #6%
        \end{minipage}%
                \vfill%
                    {\Large%
                    \if @norsk
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
    \extraBookmark{\if @norsk Contents\else Inhaltsverzeichnis\fi}{tocanc}%
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
    % \deftripstyle{myChapterStyle}{}{}{}{#1}{}{\pagemark}
    % \renewcommand*{\chapterpagestyle}{myChapterStyle}
}

% \newcommand{\clearmydoublepage}{\newpage{\pagestyle{myChapterStyle}\cleardoublepage}}

\newlength{\FormelTabellenWeite}
\newenvironment{formelzeichen}[1][0.1]
{%
    \@openrightfalse%
    \setlength{\FormelTabellenWeite}{\textwidth}%
    \addtolength{\FormelTabellenWeite}{-#1\textwidth}%
   % \addchap*{\if@norsk Symbols\else Formelzeichen\fi}%
    \extraBookmark{\if@norsk Symbols\else Formelzeichen\fi}{formulaanc}%
    \begin{longtable}{p{#1\textwidth}p{\FormelTabellenWeite}}
}{%
    \end{longtable}%
    \@openrighttrue%
%    \clearmydoublepage
}%

\newenvironment{abkuerzungen}[1][0.2]
{%
    \@openrightfalse%
    \setlength{\FormelTabellenWeite}{\textwidth}%
    \addtolength{\FormelTabellenWeite}{-#1\textwidth}%
   % \addchap*{\if @norsk Glossary\else Glossar\fi}%
    \extraBookmark{\if @norsk Glossary\else Glossar\fi}{abranc}%
    \begin{longtable}{p{#1\textwidth}p{\FormelTabellenWeite}}
}{%
    \end{longtable}%
    \@openrighttrue%
  %  \clearmydoublepage
}%

\newenvironment{literaturverzeichnis}
{\begin{thebibliography}{99}%
    \addcontentsline{toc}{chapter}{\if @norsk Bibliography\else Literatur\fi}%
%	\extraBookmark{\if @norsk Bibliography\else Literatur\fi}{litanc}
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
