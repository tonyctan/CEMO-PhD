\ProvidesClass{MAE}[2021/10/01 v0.9 CEMO MAE thesis template]
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
\def\title#1{\gdef\@title{#1}\gdef\MAEtitle{#1}}

% Define \subtitle command
\newcommand{\subtitle}[1]{\def \MAE@subtitle{#1}}
\subtitle{}
\def \MAE@subtitle {\@subtitle}
% Save the content of subtitle
\def\subtitle#1{\gdef\@subtitle{#1}\gdef\MAEsubtitle{#1}}

% Define candidate command
\newcommand{\candidate}[1]{\def \MAE@candidate{#1}}
\candidate{}
\def \MAE@candidate {\@author}

% Define \semester command
\newcommand{\semester}[1]{\def \MAE@semester{#1}}
\semester{}
\def \MAE@semester {\@semester}

% Make a cover page similar to UiO's DUO forside design
\newcommand{\makeMAEtitle}{
    \begin{titlepage}
        \thispagestyle{empty} % Cover page must have no page number.
        \centering % Center everything on the cover page.
        \includegraphics[width=16cm]{banner} % Insert UiO banner

        % Leave some space between the UiO banner and title
        \vspace{2\baselineskip}
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
        \ifx \MAE@subtitle = \MAE@empty
        \else{
            \fontsize{20}{16pt}\fontseries{m}\fontshape{sl}\selectfont \MAE@subtitle\par
            \vspace{2\baselineskip}
        }
        \fi
        % Print author's name
        \fontsize{16}{12pt}\fontseries{m}\fontshape{n}\selectfont \MAE@candidate\par

        \vspace{5\baselineskip}
        % Print degree name
        \fontsize{16}{12pt}\fontseries{m}\fontshape{n}\selectfont Master of Science in Assessment, Measurement and Evaluation\\
        \fontsize{16}{12pt}\fontseries{m}\fontshape{n}\selectfont 30 credits

        \vspace{2\baselineskip}
        % Print CEMO's name
        \fontsize{16}{12pt}\fontseries{m}\fontshape{n}\selectfont Centre for Educational Measurement\\
        \fontsize{16}{12pt}\fontseries{m}\fontshape{n}\selectfont Faculty of Educational Sciences

        \vspace{2\baselineskip}
        \fontsize{12}{12pt}\fontseries{m}\fontshape{n}\selectfont \MAE@semester\par
        % Remove blank page
        \vspace{-2cm}
        \null
    \end{titlepage}
}
