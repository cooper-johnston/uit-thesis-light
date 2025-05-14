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
    \setlength{\th@titleTextBottom}{82mm}
    \renewcommand{\th@fontsize}{10pt}
}

% `bleed` option adds 3 mm bleed for professional printing
\newif{\ifth@bleedenabled}
\DeclareOption{bleed}{\th@bleedenabledtrue}

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
\RequirePackage{setspace}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
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

% Set layout dimensions to paper dimensions without bleed
\newlength{\th@layoutwidth}
\setlength{\th@layoutwidth}{\th@paperwidth}
\newlength{\th@layoutheight}
\setlength{\th@layoutheight}{\th@paperheight}

\newlength{\th@bleed}
\setlength{\th@bleed}{0mm}

% Add 3 mm bleed to paper dimensions if `bleed` option is chosen
\ifth@bleedenabled
    \setlength{\th@bleed}{3mm}
    \addtolength{\th@paperwidth}{2\th@bleed}
    \addtolength{\th@paperheight}{2\th@bleed}
\fi

\geometry{
    % showframe,
    paperwidth=\th@paperwidth,
    paperheight=\th@paperheight,
    layoutwidth=\th@layoutwidth,
    layoutheight=\th@layoutheight,
    layoutoffset=\th@bleed,
    textwidth=\th@textwidth,
    vscale=0.75,
    vmarginratio={1:1},
    hmarginratio=\th@hmarginratio,
    headheight=14pt, % makes fancyhdr stop complaining
}

% Colors
% =============================================================================

% For header and footer text
\definecolor{hfcolor}{gray}{0.4}

% From the UiT Visual Profile, for non-laminated paper
% https://uit.no/ansatte/grafiskprofil#innhold_617372
\definecolor{uitblue}{cmyk}{1,0.17,0,0.73} % PMS 2189
\definecolor{uitbluelight}{cmyk}{0.1,0.017,0,0.073}

\definecolor{uitred}{cmyk}{0.01,0.87,0.89,0.04} % PMS 1797
\definecolor{uitredlight}{cmyk}{0.001,0.087,0.089,0.004}

\definecolor{uitblue2}{cmyk}{0.99,0.03,0.16,0.19} % PMS 633
\definecolor{uitblue2light}{cmyk}{0.099,0.003,0.016,0.019}

\definecolor{uitcyan}{cmyk}{0.6,0,0.2,0} % PMS 2227
\definecolor{uitcyanlight}{cmyk}{0.06,0,0.02,0}

\definecolor{uityellow}{cmyk}{0,0.31,0.9,0} % PMS 130
\definecolor{uityellowlight}{cmyk}{0,0.031,0.09,0}

% Title page
% =============================================================================

% Title element image is 216x180 mm, sized for A4 paper with 3 mm bleed;
% when printing without bleed, the left edge of the title element should be
% 3 mm outside the left edge of the paper.
\newlength{\th@titleElementHOffset}
\setlength{\th@titleElementHOffset}{3mm}
\addtolength{\th@titleElementHOffset}{-\th@bleed}
    % resets offset to 0 mm when printing with bleed

\addtolength{\th@titleElementBelow}{\th@bleed}

% For PhD thesis with 170x240 mm paper, top edge of element should be cropped
% so that element height is 135 mm.
\newcommand{\th@titleElement}{%
    \put(-\th@titleElementHOffset,\th@titleElementBelow){%
        \includegraphics[
            width=\th@titleElementWidth,
            viewport=0mm 0mm 216mm \th@titleElementUnscaledHeight,
            clip
        ]{titlepage/element.pdf}%
    }%
}

\newcommand{\th@titleImage}{%
    \put(-\th@titleElementHOffset,\th@titleElementBelow){%
        \begin{tikzpicture}[scale=\th@titleElementScale]
            \clip (0, 18) -- (19.94, 18) -- (13.44, 0) -- (0, 0) -- cycle;
            \clip (0, \th@titleElementUnscaledHeight) --
                (21.6, \th@titleElementUnscaledHeight) --
                (21.6, 0) -- (0, 0) -- cycle;
            \node[anchor=south west, inner sep=0] at (0, 0) {%
                \includegraphics[height=\th@titleElementHeight]%
                    {\th@titleImageFile}%
            };
        \end{tikzpicture}%
    }%
}

% Top left corner of logo is at (12 mm, 12 mm) from top left corner of layout;
% "UiT..." name aligns with thesis title text at 27 mm from left edge.
\newlength{\th@titleLogoLeft}
\setlength{\th@titleLogoLeft}{\th@bleed} % left edge of paper
\addtolength{\th@titleLogoLeft}{12mm} % left edge of logo

% Calculate space from bottom of logo to bottom of page
\newlength{\th@titleLogoBelow}
\setlength{\th@titleLogoBelow}{\th@paperheight} % top edge of paper
\addtolength{\th@titleLogoBelow}{-\th@bleed} % top edge of layout
\addtolength{\th@titleLogoBelow}{-24.2mm} % bottom edge of logo

\newcommand{\th@titleLogo}{\put(\th@titleLogoLeft,\th@titleLogoBelow){%
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
        layoutwidth=\th@layoutwidth,
        layoutheight=\th@layoutheight,
        layoutoffset=\th@bleed,
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
            \begin{singlespace}%
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
            \end{singlespace}%
        \end{minipage}%
    \end{titlepage}
    \restoregeometry
    \cleardoublepage
}

% Headers and footers
% =============================================================================

\newcommand{\th@hffont}{\opensans\fontseries{l}\selectfont}
\newcommand{\th@hfformat}[1]{\th@hffont\textcolor{hfcolor}{#1}}

% Inline UiT slash with space around it
\newcommand{\th@uitslashsep}[1][0.25]
    {\hspace{0.6em}\raisebox{-0.25pt}{\uitslash{#1}}\hspace{0.6em}}

% Chapter and section labels in header
\renewcommand{\sectionmark}[1]
    {\markright{\thesection\th@uitslashsep\MakeUppercase{#1}}}
\renewcommand{\chaptermark}[1]{\markboth{%
    \if@mainmatter\MakeUppercase{\@chapapp}\ \thechapter\th@uitslashsep\fi%
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
    {\begin{singlespace}\normalfont\th@headingfont\huge\bfseries}
    {%
        \vspace{-30pt}%
        \fontsize{56pt}{56pt}\selectfont%
        \raisebox{-12pt}{\uitslash{3}}%
        \thechapter%
    }
    {20pt}{\raggedright\Huge}[\end{singlespace}]
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

% Environment to make a divider page with a background color, for example to
% give a chapter its own title page
\newenvironment{dividerpage}[1][uitbluelight] % default background color
    {\cleardoublepage\pagecolor{#1}}
    {\cleardoublepage\nopagecolor}

% Command to make a chapter with a special label
\newcommand{\specialchapter}
    {\@ifstar{\@specialchapternonum}{\@specialchapternum}}
\newcommand{\@specialchapternum}[3][]{%
    \ifx&#1&%
        \def\@shortchapter{#3}%
    \else%
        \def\@shortchapter{#1}%
    \fi%
    \chapter[\texorpdfstring{%
        % Chapter title to be printed in table of contents
        {\lsstyle\textsc{\MakeLowercase{#2}}}\hspace{1em}\@shortchapter
    }{%
        % Chapter title to be shown in PDF bookmark
        #2. \@shortchapter%
    }]{%
        % Chapter title to be printed on page
        {\LARGE\fontseries{l}\selectfont\lsstyle\MakeUppercase{#2}}\\
        \vspace{0.5ex}#3%
    }%
    % Chapter title to be printed in header
    \chaptermark{#2\th@uitslashsep\@shortchapter}%
}
% Same command but unnumbered version, will still show in table of contents
\newcommand{\@specialchapternonum}[3][]{%
    \ifx&#1&%
        \def\@shortchapter{#3}%
    \else%
        \def\@shortchapter{#1}%
    \fi%
    \chapter*{%
        % Chapter title to be printed on page
        {\LARGE\fontseries{l}\selectfont\lsstyle\MakeUppercase{#2}}\\
        \vspace{0.5ex}#3%
    }%
    \addcontentsline{toc}{chapter}{\texorpdfstring{%
        % Chapter title to be printed in table of contents
        {\lsstyle\textsc{\MakeLowercase{#2}}}\hspace{1em}\@shortchapter
    }{%
        % Chapter title to be shown in PDF bookmark
        #2. \@shortchapter%
    }}%
    % Chapter title to be printed in header
    \markboth{\MakeUppercase{#2}\th@uitslashsep\MakeUppercase{\@shortchapter}}
        {}%
}

% Table of contents
% =============================================================================

\setcounter{tocdepth}{0}

\titlecontents{chapter} % section
    [0em] % left
    {\normalfont} % above code
    {{\bfseries\contentslabel{0em}}\hspace{1.75em}} % numbered entry format
    {\hspace{1.75em}} % numberless entry format
    {\hspace{1em}\contentspage} % filler-page format
    [\vspace{\baselineskip}] % below code

% Miscellaneous
% =============================================================================

% Abstract
\newenvironment{abstract}{%
    \chapter*{\abstractname}%
    \chaptermark{\abstractname}%
}{}

% UiT diagonal element at 20 degrees
\newcommand{\uitslash}[2][uitblue2]{\begin{tikzpicture}[scale=#2]
    \fill[#1] (0, 0) -- (0.35657, 1) -- (0.45657, 1) -- (0.1, 0) -- cycle;
\end{tikzpicture}}

\frenchspacing % one space after period between sentences

\raggedbottom % stops stretching of paragraphs to make text reach page bottom

% Norwegian-style quotes for Northern Sami with csquotes package
\DeclareQuoteAlias[guillemets]{norwegian}{samin}

% Default line spacing is 1.2; stretching by 1.1 gives 1.32 spacing.
\setstretch{1.1}