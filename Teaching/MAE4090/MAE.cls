\ProvidesClass{MAE}[2021/10/01 v0.9 CEMO MAE thesis template]
\NeedsTeXFormat{LaTeX2e}

% Force master students to use 11pt font
\DeclareOption{10pt}{\ClassError{MAE}{Illegal font size}{Please use 11pt}}
\DeclareOption{12pt}{\ClassError{MAE}{Illegal font size}{Please use 11pt}}

% Set default in apa7.cls
\ProcessOptions\relax
\LoadClass[a4paper,11pt,stu,noextraspace,floatsintext,biblatex]{apa7}

% Turn off fancy header
\pagestyle{plain}

% Define empty field
\newcommand{\MAE@empty}{}

% Define \title command
\def \MAE@title {\@title}

% Define \subtitle command
\newcommand{\subtitle}[1]{\def \MAE@subtitle{#1}}
\subtitle{}
\def \MAE@subtitle {\@subtitle}

% Define candidate command
\newcommand{\candidate}[1]{\def \MAE@candidate{#1}}
\candidate{}
\def \MAE@candidate {\@author}

% Define \semester command
\newcommand{\semester}[1]{\def \MAE@semester{#1}}
\semester{}
\def \MAE@semester {\@semester}

\newcommand{\makeMAEtitle}{
    \begin{titlepage}
        \thispagestyle{empty}
        \centering
        \includegraphics[width=16cm]{banner}
        % Leave some space between the UiO banner and title

        \vspace{2\baselineskip}
        % Define font: Helvetica (phv) is always available...
        \newcommand{\MAE@font}{phv}
        % ...but use Arial if possible
        \IfFileExists{t1ua1.fd}{\renewcommand{\MAE@font}{ua1}}{}
        % Call in font for the title
        \fontfamily{\MAE@font}\fontencoding{T1}
        % Specify size for the title
        \fontsize{24}{20pt}\fontseries{sb}\selectfont
        \MAE@title\par

        % Leave some space between title and subtitle
        \vspace{1\baselineskip}
        \ifx \MAE@subtitle = \MAE@empty
            \else
                {\fontsize{20}{16pt}\fontseries{m}\fontshape{sl}\selectfont \MAE@subtitle\par}
                \vspace{2\baselineskip}
        \fi
        % Print author's name
        \fontsize{16}{12pt}\fontseries{m}\fontshape{n}\selectfont \MAE@candidate\par

        \vspace{3.75\baselineskip}
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
