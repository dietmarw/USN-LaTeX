%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  USN-PhD.cls                     %%
%%  LaTeX-class for writing theses  %%
%%                                  %%
%%  (c) Dietmar Winkler (me.dwe.no) %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ---Identification----
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{USN-PhD}[2016/08/05 Template class for PhD theses]

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
\newcommand{\mysubject}{Process, Energy and Automation Engineering}

\newcommand{\USNtitlepage}[5]{%
% #1 optional figure
% #2 date
% #3 confidential
% #4 Project partner
% #5 summary
  \subject{\mysubject}
  \title{\mytitle}
  \subtitle{\normalsize\mysubtitle}
  \author{\myauthor}
  \date{}
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
}
