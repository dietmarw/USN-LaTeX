%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  LaTeX-class for writing theses  %%
%%                                  %%
%%  (c) Dietmar Winkler             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ---Identification----
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{USN-BSc}[2016/08/01 Template class for Bachelor reports and thesis]

% --- definitions of options ---

% index-option
\newcommand{\RequireIndex}{}
\newif\if@index
\@indexfalse
\DeclareOption{index} {%
  \@indextrue%
  \renewcommand{\RequireIndex}{\RequirePackage{makeidx}\makeindex}%
}%

% All other options are passed on to the book class
\DeclareOption*{%
    \typeout{Option \CurrentOption\space is passed to package book!}
    \PassOptionsToClass{\CurrentOption}{book}
}%

% --- execution of options ---
\ProcessOptions\relax
\LoadClass[12pt, openright, a4paper]{book}

% --- package loading ---
\RequirePackage[utf8]{inputenc}   %% allow direct input of utf8 chars
\RequirePackage{lmodern}          %% use vector fonts
\RequirePackage[T1]{fontenc}      %% recommended for real glyphs in PDF
\RequirePackage{amsmath,mathptmx} %% we need lots of math features
\RequirePackage{ifthen}           %% provides simple if-then functionality
\RequirePackage{url}              %% helps displaying URLs
\RequirePackage{longtable}        %% for long tables that might break over pages
\RequirePackage{caption}          %% advanced caption options
\RequirePackage{graphicx}         %% needed for inclusion of graphics
  \graphicspath{{fig/}}           %% this is were the images reside
\RequirePackage[hidelinks=true]{hyperref} %% generate links in the PDF (but no boxes around them)
\RequirePackage{pdfpages}         %% for inclusion of PDF documents
\RequirePackage{parskip}          %% no indent but line skip between paragrahps
\RequirePackage{sectsty}          %% for setting some headings
  \allsectionsfont{\sffamily}       %% --> set all headings to san-serif fonts

% --- header and footer setup ---
\RequirePackage{fancyhdr}
  \pagestyle{fancy}
  \fancyhead{} % clear all header fields
  \fancyhead[C]{\bfseries \leftmark}
  \fancyfoot{} % clear all footer fields
  \fancyfoot[C]{\thepage}
  \renewcommand{\headrulewidth}{0pt} %% no head rule
  \renewcommand{\footrulewidth}{0pt} %% no foot rule
  \renewcommand{\chaptermark}[1]{%
    \markboth{\chaptername\ \thechapter.\ #1}{}}
\RequirePackage{emptypage}         %% removes headers and footers on empty pages


%Redefinitionen---------------------------------
%Literaturverzeichnis statt nur Literatur
%\renewcommand{\refname}{Literaturverzeichnis}
%\if@english \else \AtBeginDocument{\renewcommand*\figurename{Bild}}\fi

% %Umgebungen------------------------------------
% \newcommand{\includeBild}[3]%
% {\ifthenelse%
%         {\equal{#1}{}}%
%         {\mbox{\parbox[b][5cm][c]{0.7\textwidth}{\begin{center}no picture\end{center}}}}%
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
%     \captionsetup{indent=0pt,width=.9\textwidth}%
%     \caption{#2}%
%           \ifthenelse%
%         {\equal{#1}{}}%
%         {}%
%         {\label{fig:#1}}%
% }

% \newcommand{\bild}[4][htb]{%
% \begin{figure}[#1]%
%     \centering%
%     \includeBild{#2}{#3}{#4}
% \end{figure}%
% }

% \newcommand{\bildhier}[3]{%
% \begin{figure}[!ht]%
%     \centering%
%     \includeBild{#1}{#2}{#3}
% \end{figure}%
% }


% \newcommand{\doppelbild}[7][htb]{%
% \begin{figure}[#1]%
% \begin{minipage}[t]{.45\textwidth}%
% \centering%
%   \includeBild{#2}{#3}{#4}%
% \end{minipage}%
% ~\hfill~%
% \begin{minipage}[t]{.45\textwidth}%
%   \includeBild{#5}{#6}{#7}%
% \end{minipage}%
% \end{figure}%
% }

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
