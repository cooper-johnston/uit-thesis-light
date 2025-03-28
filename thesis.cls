\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[Thesis Class]

% Base class and options
% =============================================================================

% Base class
\newcommand{\th@baseclass}{book}

% Default paper size and margins (A4)
\newlength{\th@paperwidth}
\setlength{\th@paperwidth}{210mm}
\newlength{\th@paperheight}
\setlength{\th@paperheight}{297mm}
\newlength{\th@vmargin}
\setlength{\th@vmargin}{96pt}
\newlength{\th@leftmargin}
\setlength{\th@leftmargin}{96pt}
\newlength{\th@textwidth}
\setlength{\th@textwidth}{360pt}

% Default font size
\newcommand{\th@fontsize}{11pt}

% Thesis type options
\DeclareOption{master}{} % default
\DeclareOption{phd}{ % 17x24 paper
    \setlength{\th@paperwidth}{170mm}
    \setlength{\th@paperheight}{240mm}
    \setlength{\th@vmargin}{69.35pt}
    \setlength{\th@leftmargin}{69.35pt} % for equal left and right margins
    \setlength{\th@textwidth}{345pt}
    \renewcommand{\th@fontsize}{10pt}
}

% Suppress remaining book class options
\DeclareOption*{\OptionNotUsed}

\ProcessOptions\relax
\LoadClass[\th@fontsize]{\th@baseclass}

% Packages
% =============================================================================

\RequirePackage{geometry}
\RequirePackage{emptypage}
\RequirePackage{microtype}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage{tikz}
\RequirePackage{csquotes}
\RequirePackage{eso-pic}
\RequirePackage{graphicx}
\RequirePackage[USenglish]{babel}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage[defaultsans,scale=0.92]{opensans}
    % scaled for more compatible x-height with most serif body text fonts

% Page geometry
% =============================================================================

\geometry{
    paperwidth=\th@paperwidth,
    paperheight=\th@paperheight,
    vmargin=\th@vmargin,
    left=\th@leftmargin,
    textwidth=\th@textwidth
}

% Colors
% =============================================================================

\definecolor{uitblue2}{cmyk}{0.99,0.03,0.16,0.19}
\definecolor{hfcolor}{gray}{0.4}

% Title page
% =============================================================================

\newlength{\bleed}
\setlength{\bleed}{3mm}

\newlength{\bleedoffset}
\setlength{\bleedoffset}{0mm}

\newlength{\bkgoffset}
\setlength{\bkgoffset}{-\bleed}

\newlength{\bkgwidth}
\setlength{\bkgwidth}{213mm}

\newlength{\bkgheight}
\setlength{\bkgheight}{300mm}

\newcommand{\UseBleed}{
    \setlength{\bleedoffset}{\bleed}
    \setlength{\bkgoffset}{0mm}
    % \geometry{
    %     paperwidth=\bkgwidth,
    %     paperheight=\bkgheight,
    %     layout=a4paper,
    %     layoutoffset=\bleedoffset
    % }
}

\newcommand{\TitleBkg}{\put(0,0){%
    \parbox[b][\paperheight]{\paperwidth}{%
        \vspace*{\bkgoffset}%
        \hspace*{\bkgoffset}%
        \includegraphics[width=\bkgwidth,height=\bkgheight]
            {titlepage/titlepage_blank.pdf}%
        \vfill%
    }%
}}

\newcommand{\thesisFaculty}[1]{\gdef\@faculty{#1}}
\newcommand{\thesisDepartment}[1]{\gdef\@department{#1}}
\newcommand{\thesisSubtitle}[1]{\gdef\@subtitle{#1}}
\newcommand{\thesisCourse}[1]{\gdef\@course{#1}}

\renewcommand{\maketitle}{%
    \newgeometry{
        layout=a4paper,
        layoutoffset=\bleedoffset,
        ignorehead,
        ignorefoot,
        top=0mm,
        left=27mm,
        right=12mm
    }%
    \AddToShipoutPicture*{\TitleBkg}%
    \begin{titlepage}%
        \setlength{\parindent}{0pt}%
        \setlength{\parskip}{0pt}%
        \begin{minipage}[b][89.5mm]{\textwidth}%
            \raggedright\opensans%
            {\fontseries{l}\fontsize{13pt}{18.2pt}\selectfont%
                \@faculty\\
                \ifdefined\@department\@department\fi\par}%
            \vspace{12pt}%
            {\fontseries{sb}\fontsize{16pt}{19.2pt}\selectfont\@title\par}%
            \vspace{8pt}%
            \ifdefined\@subtitle%
                {\fontseries{m}\fontsize{14pt}{16.8pt}\selectfont%
                    \@subtitle\par}%
            \fi%
            \vspace{8pt}%
            {\fontseries{l}\fontsize{11pt}{15.4pt}\selectfont%
                \@author\\
                \@course, \@date\par}%
        \end{minipage}%
    \end{titlepage}
    \restoregeometry
    \cleardoublepage
}

% Headers and footers
% =============================================================================

\newcommand{\th@hffont}{\opensans\small\fontseries{l}\selectfont}
\newcommand{\th@hfformat}[1]{\th@hffont\textcolor{hfcolor}{#1}}

% Chapter and section labels in header
\renewcommand{\sectionmark}[1]{\markright{%
    \thesection\hspace{1ex}\uitslash[0.25]\hspace{1ex}%
    \MakeUppercase{#1}%
}}
\renewcommand{\chaptermark}[1]{\markboth{%
    \if@mainmatter%
        \MakeUppercase{\@chapapp}\ \thechapter%
        \hspace{1ex}\uitslash[0.25]\hspace{1ex}%
    \fi%
    \MakeUppercase{#1}%
}{}}

\fancypagestyle{plain}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyfoot[C]{\th@hfformat{\thepage}}
}

\fancypagestyle{standard}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead[LO]{\th@hfformat{\lsstyle\rightmark}}
    \fancyhead[RE]{\th@hfformat{\lsstyle\leftmark}}
    \fancyhead[LE,RO]{\th@hfformat{\thepage}}
}
\pagestyle{standard}

% Headings
% =============================================================================

\newcommand{\th@headingfont}{\opensans}

\titleformat{\chapter}[display]
    {\normalfont\th@headingfont\huge\bfseries}
    {\fontsize{56pt}{56pt}\selectfont\raisebox{-12pt}{\uitslash[3]}\thechapter}
    {20pt}{\raggedright\Huge}
\titleformat{\section}
    {\normalfont\th@headingfont\Large\bfseries}{\thesection}{1em}{}
\titleformat{\subsection}
    {\normalfont\th@headingfont\large\bfseries}{\thesubsection}{1em}{}
\titleformat{\subsubsection}
    {\normalfont\th@headingfont\normalsize\bfseries}{\thesubsubsection}{1em}{}
\titleformat{\paragraph}[runin]
    {\normalfont\th@headingfont\normalsize\bfseries}{\theparagraph}{1em}{}
\titleformat{\subparagraph}[runin]
    {\normalfont\th@headingfont\normalsize\bfseries}{\thesubparagraph}{1em}{}

% Miscellaneous
% =============================================================================

% Abstract
\newenvironment{abstract}{\chapter*{\abstractname}}{}

% UiT diagonal element at 20 degrees
\newcommand{\uitslash}[1][1]{\begin{tikzpicture}[scale=#1]
    \fill[uitblue2] (0, 0) -- (0.35657, 1) -- (0.45657, 1) -- (0.1, 0) -- cycle;
\end{tikzpicture}}

\frenchspacing % one space after period between sentences

\raggedbottom