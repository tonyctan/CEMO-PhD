\ProvidesClass{MAE}[2021/10/15 v1.0 CEMO MAE thesis template]
\NeedsTeXFormat{LaTeX2e}

% Force master students to use 11pt font
\DeclareOption{10pt}{\ClassError{MAE}{Illegal font size}{Delete `10pt' option to use the default `11pt'}}
\DeclareOption{12pt}{\ClassError{MAE}{Illegal font size}{Delete `12pt' option to use the default `11pt'}}

% Do NOT play with apa7.cls options
\DeclareOption{man}{\ClassError{MAE}{Illegal document type}{Delete `man' option to use the default `stu'}}
\DeclareOption{jou}{\ClassError{MAE}{Illegal document type}{Delete `jou' option to use the default `stu'}}
\DeclareOption{doc}{\ClassError{MAE}{Illegal document type}{Delete `doc' option to use the default `stu'}}

% Set default in apa7.cls
\ProcessOptions\relax
\LoadClass[
    a4paper, % Use A4 paper
    11pt, % APA7 Rule 2.19 10pt Computer Modern too small. Change to 11pt.
    stu, % All CEMO thesis must be compiled using student paper mode.
    donotrepeattitle, % Will generate heading in Section 1 myself.
    noextraspace, % Make section headings and text closer and nicer.
    floatsintext, % Insert tables and figures in the body of the thesis.
    biblatex, % Use BibLaTeX as the engine.
    twoside % Prepare LaTeX for open-right
]{apa7}

% Turn off fancy header. Student papers should NOT have headers.
\pagestyle{plain}

% Define empty field
\newcommand{\MAE@empty}{}

% Define \title command
\def \MAE@title {\@title}
% Save the content of title
\def\title#1{\def\@title{#1}\def\MAE@title{#1}}

% Save the content of subtitle
\def\subtitle#1{\def\@subtitle{#1}\def\MAE@subtitle{#1}}
% Default: no subtitle (empty)
\def\@subtitle{}\let\MAE@subtitle=\MAE@empty

% Define ``full title''
\renewcommand{\maketitle}{
    \begin{center}
        \bf\MAE@title
        \ifx \MAE@subtitle \MAE@empty
        \else
            : \MAE@subtitle
        \fi
    \end{center}
}

% Define candidate command
\newcommand{\candidate}[1]{\author{#1}\def\MAE@candidate{#1}}

% Define \semester command

% Capture the current month
\newcounter{MAE@cur@month}  \setcounter{MAE@cur@month}{\the\month}
% Determin whether we are in spring or autumn semester
\ifthenelse{\theMAE@cur@month<7}
    {\newcommand{\MAE@term}{Spring}}
    {\newcommand{\MAE@term}{Autumn}}
% Name the semester
\newcommand{\MAE@semester}{\MAE@term~\the\year}
% If user specifies \semester{}, show that. If not, use default.
\newcommand{\semester}[1]{\def \MAE@semester{#1}}

% Make a cover page similar to UiO's DUO forside design
\newcommand{\makeMAEtitle}{
    \begin{titlepage}
        \thispagestyle{empty} % Cover page must have no page number.
        \centering % Center everything on the cover page.
        \includegraphics[width=16cm]{banner} % Insert UiO banner

        % Leave some space between the UiO banner and title
        \vspace{1\baselineskip}
        % Define font: Helvetica (phv) is always available...
        \newcommand{\MAE@font}{phv}
        % ...but use Arial (ua1) if possible
        \IfFileExists{t1ua1.fd}{\renewcommand{\MAE@font}{ua1}}{}
        % Call in font for the title
        \fontfamily{\MAE@font}\fontencoding{T1}
        % Specify size for the title
        \fontsize{24}{20pt}\fontseries{b}\selectfont
        \MAE@title\par

        % Leave some space between title and subtitle
        \vspace{0.75\baselineskip}
        % Detect whether this thesis contains a subtitle. If yes, format it.
        \ifx \MAE@subtitle \MAE@empty
        \else{
            \fontsize{20}{16pt}\fontseries{m}\fontshape{sl}\selectfont \MAE@subtitle\par
        }
        \fi

        \vfill

        % Print author's name
        \fontsize{16}{12pt}\fontseries{m}\fontshape{n}\selectfont \MAE@candidate\par

        \vspace{5\baselineskip}
        % Print degree name
        \fontsize{16}{16pt}\fontseries{m}\fontshape{n}\selectfont Master of Science in Assessment, Measurement and Evaluation\\
        \fontsize{16}{16pt}\fontseries{m}\fontshape{n}\selectfont 30 credits

        \vspace{1.5\baselineskip}
        % Print CEMO's name
        \fontsize{16}{12pt}\fontseries{m}\fontshape{n}\selectfont Centre for Educational Measurement\\
        \fontsize{16}{12pt}\fontseries{m}\fontshape{n}\selectfont Faculty of Educational Sciences

        \vspace{1.5\baselineskip}
        \fontsize{12}{12pt}\fontseries{m}\fontshape{n}\selectfont \MAE@semester\par
        % Remove blank page
        \vspace{-1cm}
        \null
    \end{titlepage}
% Insert a blank page
    \begin{titlepage}
        \thispagestyle{empty} % Remove page number
        \mbox{} % Insert something but keep visual as blank
    \end{titlepage}
% Switch page numbering to roman for preambles
    \pagenumbering{roman}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Re-generate thesis title %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\usepackage{authoraftertitle}
\setlength\parindent{0 pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% General formatting %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Johan wants Times New Roman rather than the default LaTeX font
\usepackage{mathptmx}
%\usepackage{newtxtext}

% Inserts a blank page (so that next part starts on right)
\usepackage{emptypage}

% Prevents LaTeX stretching paragraph gaps
\raggedbottom

% Enable single spacing overwrite for computer code and tables
\usepackage{setspace}

% APA7 Rule 2.24: Indent the first line of every paragraph 0.5 in
\setlength\parindent{0.5in}

% APA7 Rule 2.24 Paragraph Indentation
% Block quotation should be indented from the left margin 0.5 in.
\usepackage{changepage}
\newenvironment{MAEquote}{
    \begin{adjustwidth*}{0.5in}{0in}
}{
    \end{adjustwidth*}
}

% Reduce gaps in enumerate and itemize environment
\usepackage{enumitem}
\setlist[enumerate]{noitemsep}
\setlist[enumerate]{nolistsep}
\setlist[itemize]{noitemsep}
\setlist[itemize]{nolistsep}

\newenvironment{MAEitemize}{
        \begin{itemize}[noitemsep,align=left,style=nextline,leftmargin=\parindent,font=\normalfont]
}{
        \end{itemize}
}

% Introduce some space between ``Figure 1'' and its caption
\DeclareCaptionLabelSeparator{apalabelsep}{\\[0.5\baselineskip]} 

%%%%%%%%%%%%%%%%%
%%%%% Maths %%%%%
%%%%%%%%%%%%%%%%%

% Since this is a quantitative paper, always call in amamath and related packages
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsthm}
%\usepackage{amsfonts} % Do not turn this on because it clashes with other packages.

% I want to change QED square from an empty square (white) to a solid square (black).
\renewcommand\qedsymbol{$\blacksquare$}

% I have been typing ``with respect to'' too many times so here is a shortcut:
\newcommand{\wrt}{with respect to\ }
% along with many other shortcuts and re-definitions
\newcommand{\abs}[1]{\left|#1\right|}
\newcommand{\erf}[1]{\mathrm{erf}\left(#1\right)}
\renewcommand{\exp}[1]{\text{\Huge\emph{e}}^{#1}}
\newcommand{\expb}[1]{\mathrm{exp}\left\{#1\right\}}
\renewcommand{\sin}[1]{\mathrm{sin}\left(#1\right)}
\renewcommand{\cos}[1]{\mathrm{cos}\left(#1\right)}
\renewcommand{\tan}[1]{\mathrm{tan}\left(#1\right)}
\renewcommand{\sinh}[1]{\mathrm{sinh}\left(#1\right)}
\renewcommand{\cosh}[1]{\mathrm{cosh}\left(#1\right)}
\renewcommand{\tanh}[1]{\mathrm{tanh}\left(#1\right)}
\renewcommand{\arcsin}[1]{\mathrm{arcsin}\left(#1\right)}
\renewcommand{\arccos}[1]{\mathrm{arccos}\left(#1\right)}
\renewcommand{\arctan}[1]{\mathrm{arctan}\left(#1\right)}

% I do not like the default $\phi$ and $\epsilon$. I am going to change them to the shapes I prefer.
\renewcommand{\epsilon}{\varepsilon}
\renewcommand{\phi}{\varphi}

% Re-define maximisation and minimisation symbols
\renewcommand{\max}[2]{\underset{#2}{\text{max}}\{#1\}}
\renewcommand{\min}[2]{\underset{#2}{\text{min}}\{#1\}}

% Make bar and hat bigger, covering the whole symbol
\newcommand{\lbar}[1]{\overline{#1}}
\newcommand{\lhat}[1]{\widehat{#1}}

% Probabilities, expected values and variances will be used very often. I also want them to be in empty blackboard font:
\newcommand{\p}[1]{\mathbb{P}\left(#1\right)}
\newcommand{\E}[1]{\mathbb{E}\left(#1\right)}
\newcommand{\V}[1]{\mathbb{V}\left(#1\right)}
\newcommand{\var}[1]{\text{var}\left(#1\right)}
\newcommand{\hvar}[1]{\lhat{\text{var}}\left(#1\right)}

% Make all vectors and matrices bold
\newcommand{\m}[1]{\boldsymbol{#1}}
% Display the dimension of a matrix
\newcommand{\md}[3]{\underset{#2 \times #3}{\boldsymbol{#1}}}

% The default bar (such as for averages) is too short. I want it to be longer.
\newcommand{\mbar}[1]{\overline{\m{#1}}}
\newcommand{\mhat}[1]{\widehat{\m{#1}}}

% Identity matrix
\newcommand{\I}{\m{I}}
\newcommand{\Id}[1]{\m{I}_{#1}}
% Zero matrix
\newcommand{\Z}{\m{O}}
\newcommand{\Zd}[1]{\m{O}_{#1}}

% Transpose symbol
\usepackage{scalerel}
%\newcommand{\T}[1]{\m{#1}\strut^\intercal}
%\newcommand{\Ts}{\strut^\intercal}
%\newcommand{\T}[1]{\m{#1}^\top}
\newcommand{\T}[1]{\m{#1}^{\raisebox{1.5\depth}{\scaleto{\intercal}{5pt}}}}
\newcommand{\Ts}{^{\raisebox{1.5\depth}{\scaleto{\intercal}{5pt}}}}

% Orthogonal symbol
\newcommand{\G}[1]{\m{#1}\strut^{\rotatebox[origin=c]{180}{$\intercal$}}}
\newcommand{\Gs}{\strut^{\rotatebox[origin=c]{180}{$\intercal$}}}
% Inverse symbol
\newcommand{\inv}[1]{\m{#1}^{-1}}

\newcommand{\tr}[1]{\text{tr}\left(#1\right)}
\renewcommand{\det}[1]{\text{det}\left(#1\right)}
\renewcommand{\vec}[1]{\text{vec}\left(\boldsymbol{#1}\right)}

% Column space of a matrix
\newcommand{\Col}[1]{\mathcal{C}\left(\boldsymbol{\mathrm{#1}}\right)}
% Null space of a matrix
\newcommand{\Nul}[1]{\mathcal{N}\left(\boldsymbol{\mathrm{#1}}\right)}

% Correct f(x)dx 's d into straight font
\newcommand{\dd}{\mathrm{d}}
\newcommand{\D}{\mathrm{D}}

% Define capital Greek letters
\newcommand{\Alpha}{\mathrm{A}}
\newcommand{\Beta}{\mathrm{B}}
\newcommand{\Epsilon}{\mathrm{E}}
\newcommand{\Zeta}{\mathrm{Z}}
\newcommand{\Eta}{\mathrm{H}}
\newcommand{\Iota}{\mathrm{I}}
\newcommand{\Kappa}{\mathrm{K}}
\newcommand{\Mu}{\mathrm{M}}
\newcommand{\Nu}{\mathrm{N}}
\newcommand{\Omicron}{\mathrm{O}}
\newcommand{\Rho}{\mathrm{P}}
\newcommand{\Tau}{\mathrm{T}}
\newcommand{\Chi}{\mathrm{X}}

\newcommand{\degree}{^\circ}

% Define theorems, corollaries and lemmas:
\newtheorem{theorem}{Theorem}[section]
\newtheorem{corollary}{Corollary}[theorem]
\newtheorem{lemma}[theorem]{Lemma}

\theoremstyle{definition}
\newtheorem{definition}{Definition}[section]

\theoremstyle{remark}
\newtheorem*{remark}{Remark}

% Reduce gap between equations and text
\abovedisplayshortskip=0pt
\belowdisplayshortskip=0pt
\abovedisplayskip=0pt
\belowdisplayskip=0pt

\newenvironment{eqn}
    {
        \vspace{-1em}
        \begin{singlespace}
        \begin{equation}
    }
    {
        \end{equation}
        \end{singlespace}
        % \vspace{-1em}
    }

%%%%%%%%%%%%%%%%%%
%%%%% Tables %%%%%
%%%%%%%%%%%%%%%%%%

% This package adds colour shading to tables
\usepackage{colortbl}

% This package allows multi-row to be produced
\usepackage{multirow}

% This package aligns numbers along decimal points
\usepackage{dcolumn}
\newcolumntype{d}[1]{D{.}{.}{#1}}

% To enable page rotation (to landscape for wide tables, for example)
\usepackage{pdflscape}

% Automate the table production process
\newcommand{\MAEptable}[4]{    %%% Portrait table WITH note
    \begin{table}[htbp]
        \begin{threeparttable}[htbp]
            \caption{#2}
            \label{#1}
                #3
            \begin{tablenotes}
                \linespread{1.75}\selectfont
                \textit{Note.} #4
            \end{tablenotes}
        \end{threeparttable}
    \end{table}
}

\newcommand{\MAEptableX}[3]{    %%% Portrait table WITHOUT note
    \begin{table}[htbp]
        \begin{threeparttable}[htbp]
            \caption{#2}
            \label{#1}
                #3
        \end{threeparttable}
    \end{table}
}

\newcommand{\MAEltable}[4]{    %%% Landscape table WITH note
    \begin{landscape}
        \begin{table}[htbp]
            \begin{threeparttable}[htbp]
                \caption{#2}
                \label{#1}
                    #3
                \begin{tablenotes}
                    \linespread{1.75}\selectfont
                    \textit{Note.} #4
                \end{tablenotes}
            \end{threeparttable}
        \end{table}
    \end{landscape}
}

\newcommand{\MAEltableX}[3]{    %%% Landscape table WITHOUT note
    \begin{landscape}
        \begin{table}[htbp]
            \begin{threeparttable}[htbp]
                \caption{#2}
                \label{#1}
                    #3
            \end{threeparttable}
        \end{table}
    \end{landscape}
}

\newcommand{\MAEptableCont}[2]{    %%% Portrait table (Continued) WITH note
    \begin{singlespace}
        \begin{table}
            \begin{threeparttable}[htbp]
%                \caption*{Continued}
                #1
            \begin{tablenotes}
                \linespread{1.75}\selectfont
                \textit{Note.} #2
            \end{tablenotes}
            \end{threeparttable}
        \end{table}
    \end{singlespace}
}

\newcommand{\MAEltableCont}[2]{    %%% Landscape table (Continued) WITH note
    \begin{singlespace}
        \begin{landscape}
            \begin{table}
                \begin{threeparttable}[htbp]
%                    \caption*{Continued}
                    #1
                \begin{tablenotes}
                    \linespread{1.75}\selectfont
                    \textit{Note.} #2
                \end{tablenotes}
                \end{threeparttable}
            \end{table}
        \end{landscape}
    \end{singlespace}
}

\newcommand{\MAEptableContX}[1]{    %%% Portrait table (Continued) WITHOUT note
    \begin{singlespace}
        \begin{table}
            \begin{threeparttable}[htbp]
%                \caption*{Continued}
                #1
            \end{threeparttable}
        \end{table}
    \end{singlespace}
}

\newcommand{\MAEltableContX}[1]{    %%% Landscape table (Continued) WITHOUT note
    \begin{singlespace}
        \begin{landscape}
            \begin{table}
                \begin{threeparttable}[htbp]
%                    \caption*{Continued}
                    #1
                \end{threeparttable}
            \end{table}
        \end{landscape}
    \end{singlespace}
}

%%%%%%%%%%%%%%%%%%%
%%%%% Figures %%%%%
%%%%%%%%%%%%%%%%%%%

% This is for inserting pictures/figures.
\usepackage{graphicx}
\graphicspath{ {./Figures/} }

% tikz

\usepackage{tikz}
\usetikzlibrary{automata,shapes,arrows,calc,positioning,decorations.pathmorphing}

\newcommand{\MAEptikz}[4]{ %%% Portrait tikz figure WITH note
    \begin{figure}[htbp]
        \caption{#2}
        \label{#1}
            #3
        \begin{tablenotes}
            \linespread{1.75}\selectfont
            \textit{Note.} #4
        \end{tablenotes}
    \end{figure}
}

\newcommand{\MAEptikzX}[3]{ %%% Portrait tikz figure WITHOUT note
    \begin{figure}[htbp]
        \caption{#2}
        \label{#1}
            #3
    \end{figure}
}

\newcommand{\MAEltikz}[4]{ %%% Landscape tikz figure WITH note
    \begin{landscape}
        \begin{figure}[htbp]
            \caption{#2}
            \label{#1}
                #3
            \begin{tablenotes}
                \linespread{1.75}\selectfont
                \textit{Note.} #4
            \end{tablenotes}
        \end{figure}
    \end{landscape}
}

\newcommand{\MAEltikzX}[3]{ %%% Landscape tikz figure WITHOUT note
    \begin{landscape}
        \begin{figure}[htbp]
            \caption{#2}
            \label{#1}
                #3
        \end{figure}
    \end{landscape}
}

% tikz diagram: model output
\newcommand{\pres}[2]{\footnotesize$\underset{(#2)}{#1}$}
\newcommand{\press}[3]{${#1}^{#2}$}
%\newcommand{\press}[3]{\footnotesize$\underset{(#3)}{#1}^{#2}$}

%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Computer code %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%

% Do NOT do \usepackage[dvipsnames]{xcolor} because apa7.cls already did.
% Put the option dvipsnames to the option section of main.tex
% Define some commonly used colours
\definecolor{forestgreen}{HTML}{228B22}

% This package breaks long lines in the verbatim environment
\usepackage{listings}
\usepackage[verbatim]{lstfiracode} %//ref https://ctan.org/pkg/lstfiracode
\lstset{
    basicstyle=\normalsize\ttfamily, % the size of the fonts that are used for the code
    style=FiraCodeStyle,            % Use predefined FiraCodeStyle
    numbers=left,                   % where to put the line-numbers
    numberstyle=\normalsize\color{gray},  % the style that is used for the line-numbers
    stepnumber=1,                   % the step between two line-numbers. If it is 1, each line will be numbered
    numbersep=5pt,                  % how far the line-numbers are from the code
    backgroundcolor=\color{white},  % choose the background color. You must add \usepackage{color}
    showspaces=false,               % show spaces adding particular underscores
    keepspaces=true,
    columns=fullflexible,
    showstringspaces=false,         % underline spaces within strings
    showtabs=false,                 % show tabs within strings adding particular underscores
    frame=single,                   % adds a frame around the code
    rulecolor=\color{black},        % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. commens (green here))
    tabsize=2,                      % sets default tabsize to 2 spaces
    %tab=\rightarrowfill,
    captionpos=b,                   % sets the caption-position to bottom
    breaklines=true,                % sets automatic line breaking
    breakatwhitespace=false,        % sets if automatic breaks should only happen at whitespace
    postbreak=\mbox{\textcolor{red}{$\hookrightarrow$}\space},
    keywordstyle=\color{blue},      % keyword style
    morekeywords={},
    deletekeywords={},
    commentstyle=\color{gray},   % comment style
    stringstyle=\color{PineGreen}      % string literal style
}
\lstdefinestyle{vscodeR}{
    language=R,
    belowcaptionskip=1\baselineskip,
    breaklines=true,
    frame=l,
    xleftmargin=\parindent,
    showstringspaces=false,
    basicstyle=\scriptsize\ttfamily,
    numbers=left,
    numberstyle=\scriptsize\color{gray},
    stepnumber=5,
    firstnumber=1,
    numberfirstline=true,
    numbersep=5pt,
    style=FiraCodeStyle,
    otherkeywords={!,!=,~,$,*,\&,\%/\%,\%*\%,\%\%,<-,<<-,/},
    alsoother={.$},
    keywordstyle=\bfseries\color{blue!60!black},
    commentstyle=\itshape\color{gray},
    identifierstyle=\color{BrickRed},
    stringstyle=\color{PineGreen}
}
\lstdefinelanguage{Mplus}{
    sensitive=true,
    % Comments
    comment=[l]!,
    % Strings
    string=[d]", % d = doubled, meaning stuff wrapped by " " is a string
    morestring=[d]',
    % Keywords
    keywords={is,are,with,by,on,pon,pwith,xwith,ind,via},
    morekeywords={},
    ndkeywords={=,;},
    % Digits and letters
    alsoletter={=,;,:},
    alsodigit={-,.},
    % Emphases
    emph={TITLE:,DATA:,VARIABLE:,DEFINE:,ANALYSIS:,MODEL:,OUTPUT:,SAVEDATA:,PLOT:,MONTECARLO:,MODEL,CONSTRAINT:,DATA,IMPUTATION:},
    moreemph={},
    % Deliminters\newcommand{\pk}[1]{\textsf{#1}}
    moredelim=[s][emphstyle]{\%}{\%}
%    moredelim=[l][emphstyle]{MODEL}{CONSTRAINT:},
%    moredelim=[l][emphstyle]{DATA}{IMPUTATION:}
}
\lstdefinestyle{vscodeMplus}{
    language=Mplus,
    belowcaptionskip=1\baselineskip,
    breaklines=true,
    frame=l,
    xleftmargin=\parindent,
    showstringspaces=false,
    basicstyle=\scriptsize\ttfamily,
    style=FiraCodeStyle,
    identifierstyle=\color{black},
    commentstyle=\itshape\color{gray},
    emphstyle=\bfseries\color{blue!60!black},
    keywordstyle=\color{blue!60!black},
    stringstyle=\color{BrickRed},
    xleftmargin=\parindent,
    belowcaptionskip=1\baselineskip,
    breaklines=true,
    frame=l,
    % Line numbers
    numbers=left,
    numberstyle=\scriptsize\color{gray},
    stepnumber=5,
    firstnumber=1,
    numberfirstline=true,
    numbersep=5pt,
    showtabs=false,
    showspaces=false,
    showstringspaces=false,
    literate=
        {0}{{\textcolor{PineGreen}{0}}}{1}%
        {1}{{\textcolor{PineGreen}{1}}}{1}%
        {2}{{\textcolor{PineGreen}{2}}}{1}%
        {3}{{\textcolor{PineGreen}{3}}}{1}%
        {4}{{\textcolor{PineGreen}{4}}}{1}%
        {5}{{\textcolor{PineGreen}{5}}}{1}%
        {6}{{\textcolor{PineGreen}{6}}}{1}%
        {7}{{\textcolor{PineGreen}{7}}}{1}%
        {8}{{\textcolor{PineGreen}{8}}}{1}%
        {9}{{\textcolor{PineGreen}{9}}}{1}%
        {.0}{{\textcolor{PineGreen}{.0}}}{2}%
        {.1}{{\textcolor{PineGreen}{.1}}}{2}%
        {.2}{{\textcolor{PineGreen}{.2}}}{2}%
        {.3}{{\textcolor{PineGreen}{.3}}}{2}%
        {.4}{{\textcolor{PineGreen}{.4}}}{2}%
        {.5}{{\textcolor{PineGreen}{.5}}}{2}%
        {.6}{{\textcolor{PineGreen}{.6}}}{2}%
        {.7}{{\textcolor{PineGreen}{.7}}}{2}%
        {.8}{{\textcolor{PineGreen}{.8}}}{2}%
        {.9}{{\textcolor{PineGreen}{.9}}}{2}%
        {-0}{{\textcolor{PineGreen}{-0}}}{2}%
        {-1}{{\textcolor{PineGreen}{-1}}}{2}%
        {-2}{{\textcolor{PineGreen}{-2}}}{2}%
        {-3}{{\textcolor{PineGreen}{-3}}}{2}%
        {-4}{{\textcolor{PineGreen}{-4}}}{2}%
        {-5}{{\textcolor{PineGreen}{-5}}}{2}%
        {-6}{{\textcolor{PineGreen}{-6}}}{2}%
        {-7}{{\textcolor{PineGreen}{-7}}}{2}%
        {-8}{{\textcolor{PineGreen}{-8}}}{2}%
        {-9}{{\textcolor{PineGreen}{-9}}}{2}%
        {0\%}{{\textcolor{PineGreen}{0\%}}}{2}%
        {1\%}{{\textcolor{PineGreen}{1\%}}}{2}%
        {2\%}{{\textcolor{PineGreen}{2\%}}}{2}%
        {3\%}{{\textcolor{PineGreen}{3\%}}}{2}%
        {4\%}{{\textcolor{PineGreen}{4\%}}}{2}%
        {5\%}{{\textcolor{PineGreen}{5\%}}}{2}%
        {6\%}{{\textcolor{PineGreen}{6\%}}}{2}%
        {7\%}{{\textcolor{PineGreen}{7\%}}}{2}%
        {8\%}{{\textcolor{PineGreen}{8\%}}}{2}%
        {9\%}{{\textcolor{PineGreen}{9\%}}}{2}%
        {.0\%}{{\textcolor{PineGreen}{.0\%}}}{3}%
        {.1\%}{{\textcolor{PineGreen}{.1\%}}}{3}%
        {.2\%}{{\textcolor{PineGreen}{.2\%}}}{3}%
        {.3\%}{{\textcolor{PineGreen}{.3\%}}}{3}%
        {.4\%}{{\textcolor{PineGreen}{.4\%}}}{3}%
        {.5\%}{{\textcolor{PineGreen}{.5\%}}}{3}%
        {.6\%}{{\textcolor{PineGreen}{.6\%}}}{3}%
        {.7\%}{{\textcolor{PineGreen}{.7\%}}}{3}%
        {.8\%}{{\textcolor{PineGreen}{.8\%}}}{3}%
        {.9\%}{{\textcolor{PineGreen}{.9\%}}}{3}%
        {infinity}{{\textcolor{PineGreen}{infinity}}}{8}
}
\lstdefinelanguage{Mplus_out}{
    sensitive=true,
    % Comments
    comment=[l]!,
    % Strings
    string=[d]", % d = doubled, meaning stuff wrapped by " " is a string
    morestring=[d]',
    % Keywords
    keywords={Within,Between,Level},
    morekeywords={Means,Variances},
    ndkeywords={=,;},
    % Digits and letters
    alsoletter={=,;},
    alsodigit={-,.},
    % Emphases
    emph={MODEL,FIT,INFORMATION,RESULTS},
    moreemph={},
    % Deliminters
    moredelim=[s][emphstyle]{\%}{\%}
%    moredelim=[l][emphstyle]{MODEL}{CONSTRAINT:},
%    moredelim=[l][emphstyle]{DATA}{IMPUTATION:}
}
\lstdefinestyle{vscodeMplus_out}{
    language=Mplus_out,
    belowcaptionskip=1\baselineskip,
    breaklines=true,
    frame=l,
    xleftmargin=\parindent,
    showstringspaces=false,
    basicstyle=\scriptsize\ttfamily,
    style=FiraCodeStyle,
    identifierstyle=\color{black},
    commentstyle=\itshape\color{gray},
    emphstyle=\bfseries\color{blue!60!black},
    keywordstyle=\color{blue!60!black},
    stringstyle=\color{BrickRed},
    xleftmargin=\parindent,
    belowcaptionskip=1\baselineskip,
    breaklines=true,
    frame=l,
    % Line numbers
    numbers=left,
    numberstyle=\scriptsize\color{gray},
    stepnumber=5,
    firstnumber=1,
    numberfirstline=true,
    numbersep=5pt,
    showtabs=false,
    showspaces=false,
    showstringspaces=false,
    literate=
        {0}{{\textcolor{PineGreen}{0}}}{1}%
        {1}{{\textcolor{PineGreen}{1}}}{1}%
        {2}{{\textcolor{PineGreen}{2}}}{1}%
        {3}{{\textcolor{PineGreen}{3}}}{1}%
        {4}{{\textcolor{PineGreen}{4}}}{1}%
        {5}{{\textcolor{PineGreen}{5}}}{1}%
        {6}{{\textcolor{PineGreen}{6}}}{1}%
        {7}{{\textcolor{PineGreen}{7}}}{1}%
        {8}{{\textcolor{PineGreen}{8}}}{1}%
        {9}{{\textcolor{PineGreen}{9}}}{1}%
        {.0}{{\textcolor{PineGreen}{.0}}}{2}%
        {.1}{{\textcolor{PineGreen}{.1}}}{2}%
        {.2}{{\textcolor{PineGreen}{.2}}}{2}%
        {.3}{{\textcolor{PineGreen}{.3}}}{2}%
        {.4}{{\textcolor{PineGreen}{.4}}}{2}%
        {.5}{{\textcolor{PineGreen}{.5}}}{2}%
        {.6}{{\textcolor{PineGreen}{.6}}}{2}%
        {.7}{{\textcolor{PineGreen}{.7}}}{2}%
        {.8}{{\textcolor{PineGreen}{.8}}}{2}%
        {.9}{{\textcolor{PineGreen}{.9}}}{2}%
        {-0}{{\textcolor{PineGreen}{-0}}}{2}%
        {-1}{{\textcolor{PineGreen}{-1}}}{2}%
        {-2}{{\textcolor{PineGreen}{-2}}}{2}%
        {-3}{{\textcolor{PineGreen}{-3}}}{2}%
        {-4}{{\textcolor{PineGreen}{-4}}}{2}%
        {-5}{{\textcolor{PineGreen}{-5}}}{2}%
        {-6}{{\textcolor{PineGreen}{-6}}}{2}%
        {-7}{{\textcolor{PineGreen}{-7}}}{2}%
        {-8}{{\textcolor{PineGreen}{-8}}}{2}%
        {-9}{{\textcolor{PineGreen}{-9}}}{2}%
        {0\%}{{\textcolor{PineGreen}{0\%}}}{2}%
        {1\%}{{\textcolor{PineGreen}{1\%}}}{2}%
        {2\%}{{\textcolor{PineGreen}{2\%}}}{2}%
        {3\%}{{\textcolor{PineGreen}{3\%}}}{2}%
        {4\%}{{\textcolor{PineGreen}{4\%}}}{2}%
        {5\%}{{\textcolor{PineGreen}{5\%}}}{2}%
        {6\%}{{\textcolor{PineGreen}{6\%}}}{2}%
        {7\%}{{\textcolor{PineGreen}{7\%}}}{2}%
        {8\%}{{\textcolor{PineGreen}{8\%}}}{2}%
        {9\%}{{\textcolor{PineGreen}{9\%}}}{2}%
        {.0\%}{{\textcolor{PineGreen}{.0\%}}}{3}%
        {.1\%}{{\textcolor{PineGreen}{.1\%}}}{3}%
        {.2\%}{{\textcolor{PineGreen}{.2\%}}}{3}%
        {.3\%}{{\textcolor{PineGreen}{.3\%}}}{3}%
        {.4\%}{{\textcolor{PineGreen}{.4\%}}}{3}%
        {.5\%}{{\textcolor{PineGreen}{.5\%}}}{3}%
        {.6\%}{{\textcolor{PineGreen}{.6\%}}}{3}%
        {.7\%}{{\textcolor{PineGreen}{.7\%}}}{3}%
        {.8\%}{{\textcolor{PineGreen}{.8\%}}}{3}%
        {.9\%}{{\textcolor{PineGreen}{.9\%}}}{3}%
        {infinity}{{\textcolor{PineGreen}{infinity}}}{8}
}

% Eliminate the extra space before each code block
\newenvironment{MAEcode}{
        \vspace{-1em}
        \begin{singlespacing}
}{
        \end{singlespacing}
}

%%%%%%%%%%%%%%%%%%%%%%
%%%%% References %%%%%
%%%%%%%%%%%%%%%%%%%%%%

% Package biblatex has already been loaded by apa7.
% Only need to specify the bib library
\addbibresource{Main.bib}

% Possesive cite:
\newcommand{\poscite}[1]{\citeauthor{#1}'s (\citeyear{#1})}


%%%%%%%%%%%%%%%%%%%%%%
%%%%% Appendices %%%%%
%%%%%%%%%%%%%%%%%%%%%%

% Change Appendix A B C to I II III because Johan said so
\renewcommand{\theappendix}{\Roman{appendix}}

%% Include PDF pages in the current file
\usepackage{pdfpages} %//tip Must load this package AFTER xcolor

% For some reason, first paragraphs in appendices refuse to indent.
% Force indentation in first paragraph.
\newcommand{\MAEindent}{
    \hspace{0.5in} % Create a phantom paragraph
    \vspace{-1\baselineskip} % Bring the next line up by one line
}

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Final packages %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

% \usepackage[%
%     colorlinks=true,          % I want to colour all my links
%     linkcolor=red,            % I want cross-references to be in red
%     anchorcolor=black,        % Keep anchors black
%     citecolor=blue,           % In-text-referencing is in blue
%     urlcolor=blue,            % DOIs and URLs are in blue
%     bookmarks=true,           % Generate bookmarks for PDF readers
%     bookmarksopen=false,      % Expand all bookmarks as default
%     bookmarksnumbered=true    % Keep section number in bookmarks
% ]{hyperref}

% Always load cleveref package last.
\usepackage[nameinlink,noabbrev,capitalise]{cleveref}