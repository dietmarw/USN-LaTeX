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