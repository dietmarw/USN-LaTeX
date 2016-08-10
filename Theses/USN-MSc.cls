%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  USN-MSc.cls                     %%
%%  LaTeX-class for writing theses  %%
%%                                  %%
%%  (c) Dietmar Winkler (me.dwe.no) %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ---Identification----
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{USN-MSc}[2016/08/04 Template class MSc reports and theses]

% --- definitions of options ---

% All other options are passed on to the book class
\DeclareOption*{%
    \typeout{Option \CurrentOption\space is passed to package USN-base!}
    \PassOptionsToClass{\CurrentOption}{USN-base}
}%

% --- execution of options ---
\ProcessOptions*      %% process the options in calling order

% --- load other classes
\LoadClass{USN-base}  %% we reuse the USN-base class

% --- useful commands
\newcommand{\USNtitlepage}[5]{%
% #1 optional figure
% #2 date
% #3 confidential
% #4 Project partner
% #5 summary
  \subject{\mysubject\\\mysubtitle}
  \title{\mytitle}
  \subtitle{#1}
  \author{\myauthor}
  \date{\large #2}
% --- pdf document settings ---
  \hypersetup{%
    pdftitle = {\mytitle},%
    pdfsubject = {\mysubject},%
    pdfauthor = {\myauthor}
  }%
\pdfbookmark[0]{\@title}{title}    %% set the correct PDF bookmark
\maketitle%
%
\cleardoubleemptypage              %% fillpage without page number
%

% % --- english summary page ---
\thispagestyle{summary}
\label{Summary}\pdfbookmark[1]{Summary}{Summary}
\USNtitlehead%
\par\bigskip
{\large \textbf{\mysubject, \mysubtitle}}

\begin{tabbing}
  \textbf{Course Code:~} \= \textit{FMH606}\\
  \textbf{Titel:~}     \> \textit{\mytitle}\\
  \textbf{Pages:~}     \> \textit{\pageref{LastPage}}\\
  \textbf{Keywords:~}  \> \textit{\mykeywords}\\
  \textbf{Student:~}   \> \textit{\myauthor}
\end{tabbing}
%
\textbf{Date, Signature:~}~\hrulefill
%
\begin{tabbing}
  \textbf{Supervisor:~~~~~~~~~} \= \textit{\supervisor}\\
%  \textbf{Examiner:~}          \> \textit{\examiner}\\
  \textbf{External partner:~}   \> \textit{#4}\\
  \textbf{Availability:~}       \> \textit{
    \ifthenelse{\equal{3}{yes}}{\textbf{Confidential}}{Open}}
\end{tabbing}

\begin{tabular}{lp{20em}}
\textbf{Approved for archiving: } & \hrulefill\\
                                  & (\supervisor)
\end{tabular}

\begin{framed}
  \textbf{Summary:}\\
   {\small #5}
\end{framed}
%
\cleardoubleemptypage              %% fillpage without page number
}
