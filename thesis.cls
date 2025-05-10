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
\newlength{\th@textwidth}
\setlength{\th@textwidth}{360pt}
\newcommand{\th@hmarginratio}{2:3}

% Default sizes for title page; see title page section further down
\newlength{\th@titleElementWidth}
\setlength{\th@titleElementWidth}{216mm}
\newlength{\th@titleElementHeight}
\setlength{\th@titleElementHeight}{180mm}
\newcommand{\th@titleElementScale}{1}
\newlength{\th@titleElementUnscaledHeight}
\setlength{\th@titleElementUnscaledHeight}{\th@titleElementHeight}
\newlength{\th@titleElementBelow}
\setlength{\th@titleElementBelow}{12mm}
\newlength{\th@titleLogoBelow}
\setlength{\th@titleLogoBelow}{272.8mm} % =297-(12+12.2)
\newlength{\th@titleTextBottom}
\setlength{\th@titleTextBottom}{89.5mm}

% Default font size
\newcommand{\th@fontsize}{11pt}

% Thesis type options
\DeclareOption{master}{} % default
\DeclareOption{phd}{ % 17x24 paper
    \setlength{\th@paperwidth}{170mm}
    \setlength{\th@paperheight}{240mm}
    \setlength{\th@textwidth}{345pt}
    \renewcommand{\th@hmarginratio}{1:1}
    \setlength{\th@titleElementWidth}{176mm}
    \setlength{\th@titleElementHeight}{135mm}
    \renewcommand{\th@titleElementScale}{0.8148}
    \setlength{\th@titleElementUnscaledHeight}{1.227\th@titleElementHeight}
        % =(216/176)*height
    \setlength{\th@titleElementBelow}{10mm}
    \setlength{\th@titleLogoBelow}{215.8mm} % =240-(12+12.2)
    \setlength{\th@titleTextBottom}{82mm}
    \renewcommand{\th@fontsize}{10pt}
}

% Suppress remaining book class options
\DeclareOption*{\OptionNotUsed}

\ProcessOptions\relax
\LoadClass[\th@fontsize]{\th@baseclass}

% Packages
% =============================================================================

\RequirePackage[T1]{fontenc}
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
\RequirePackage[hidelinks]{hyperref}
\RequirePackage[defaultsans,scale=0.92]{opensans}
    % scaled for more compatible x-height with most serif body text fonts

% Page geometry
% =============================================================================

\newlength{\th@bindingoffset}
\setlength{\th@bindingoffset}{6mm}

\geometry{
    paperwidth=\th@paperwidth,
    paperheight=\th@paperheight,
    textwidth=\th@textwidth,
    vscale=0.75,
    vmarginratio={1:1},
    hmarginratio=\th@hmarginratio,
    bindingoffset=\th@bindingoffset,
    headheight=14pt % makes fancyhdr stop complaining
}

% Colors
% =============================================================================

\definecolor{uitblue2}{cmyk}{0.99,0.03,0.16,0.19}
\definecolor{hfcolor}{gray}{0.4}

% Title page
% =============================================================================

\newlength{\th@titleBleed}
\setlength{\th@titleBleed}{3mm}

% element.pdf is 216x180 mm, sized for A4 paper with 3 mm bleed;
% for PhD thesis with 170x240 mm paper, top edge of element should be cropped
% so that element height is 135mm.
\newcommand{\th@titleElement}{\put(-\th@titleBleed,\th@titleElementBelow){%
    \includegraphics[
        width=\th@titleElementWidth,
        viewport=0mm 0mm 216mm \th@titleElementUnscaledHeight,
        clip
    ]{titlepage/element.pdf}%
}}

\newcommand{\th@titleImage}{\put(-\th@titleBleed,\th@titleElementBelow){%
    \begin{tikzpicture}[scale=\th@titleElementScale]
        \clip (0, 18) -- (19.94, 18) -- (13.44, 0) -- (0, 0) -- cycle;
        \clip (0, \th@titleElementUnscaledHeight) --
            (21.6, \th@titleElementUnscaledHeight) --
            (21.6, 0) -- (0, 0) -- cycle;
        \node[anchor=south west, inner sep=0] at (0, 0) {%
            \includegraphics[height=\th@titleElementHeight]{\th@titleImageFile}%
        };
    \end{tikzpicture}%
}}

% Top left corner of logo is at (12 mm, 12 mm) from top left corner of page;
% "UiT..." name aligns with thesis title text at 27 mm from left edge.
\newcommand{\th@titleLogo}{\put(12mm,\th@titleLogoBelow){%
    \includegraphics[height=12.2mm]{titlepage/logo_\th@titleLogoFile.pdf}%
}}

\newcommand{\thesisFaculty}[1]{\gdef\@faculty{#1}}
\newcommand{\thesisDepartment}[1]{\gdef\@department{#1}}
\newcommand{\thesisSubtitle}[1]{\gdef\@subtitle{#1}}
\newcommand{\thesisCourse}[1]{\gdef\@course{#1}}
\newcommand{\thesisImage}[1]{\gdef\th@titleImageFile{#1}}

\newcommand{\th@titleLogoFile}{english} % logo in English by default

\renewcommand{\maketitle}{%
    \babelprovide[hyphenrules=finnish]{samin}% initializing Northern Sami
    % Detect document language to select appropriate logo
    \iflanguage{norsk}{\renewcommand{\th@titleLogoFile}{bokmål}}{%
    \iflanguage{nynorsk}{\renewcommand{\th@titleLogoFile}{nynorsk}}{%
    \iflanguage{samin}{\renewcommand{\th@titleLogoFile}{samin}}{}}}%
    %
    \newgeometry{
        % layoutwidth=\th@paperwidth,
        % layoutheight=\th@paperheight,
        ignorehead,
        ignorefoot,
        top=0mm,
        left=27mm,
        right=12mm
    }%
    \AddToShipoutPictureBG*{\th@titleElement}%
    \ifdefined\th@titleImageFile%
        \AddToShipoutPictureFG*{\th@titleImage}%
    \fi%
    \AddToShipoutPictureBG*{\th@titleLogo}%
    \begin{titlepage}%
        \setlength{\parindent}{0pt}%
        \setlength{\parskip}{0pt}%
        \begin{minipage}[b][\th@titleTextBottom]{\textwidth}%
            \raggedright\opensans%
            {\fontseries{l}\fontsize{12pt}{16.8pt}\selectfont%
                \@faculty\\
                \ifdefined\@department\@department\fi\par}%
            \vspace{10pt}%
            {\fontseries{sb}\fontsize{15pt}{18pt}\selectfont\@title\par}%
            \vspace{8pt}%
            \ifdefined\@subtitle%
                {\fontseries{m}\fontsize{13pt}{15.6pt}\selectfont%
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

\newcommand{\th@hffont}{\opensans\fontseries{l}\selectfont}
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
    \fancyhead[LO]{\small\lsstyle\th@hfformat{\rightmark}}
    \fancyhead[RE]{\small\lsstyle\th@hfformat{\leftmark}}
    \fancyhead[LE,RO]{\th@hfformat{\thepage}}
}
\pagestyle{standard}

% Headings
% =============================================================================

\newcommand{\th@headingfont}{\opensans}

\titleformat{\chapter}[display]
    {\normalfont\th@headingfont\huge\bfseries}
    {%
        \vspace{-30pt}%
        \fontsize{56pt}{56pt}\selectfont%
        \raisebox{-12pt}{\uitslash[3]}%
        \thechapter%
    }
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

% Norwegian-style quotes for Northern Sami with csquotes package
\DeclareQuoteAlias[guillemets]{norwegian}{samin}