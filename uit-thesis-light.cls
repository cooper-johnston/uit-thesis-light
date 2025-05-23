\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uit-thesis-light}[2025/05/19 UiT Thesis Document Class by Cooper Johnston]

% Base class and options
% =============================================================================

% Base class
\newcommand{\utl@baseclass}{book}

% Default paper size and margins (A4)
\newlength{\utl@paperwidth}
\setlength{\utl@paperwidth}{210mm}
\newlength{\utl@paperheight}
\setlength{\utl@paperheight}{297mm}
\newlength{\utl@textwidth}
\setlength{\utl@textwidth}{360pt}
\newcommand{\utl@hmarginratio}{2:3}

% Default sizes for title page; see title page section further down
\newlength{\utl@titleElementWidth}
\setlength{\utl@titleElementWidth}{216mm}
\newlength{\utl@titleElementHeight}
\setlength{\utl@titleElementHeight}{180mm}
\newcommand{\utl@titleElementScale}{1}
\newlength{\utl@titleElementUnscaledHeight}
\setlength{\utl@titleElementUnscaledHeight}{\utl@titleElementHeight}
\newlength{\utl@titleElementBelow}
\setlength{\utl@titleElementBelow}{12mm}
\newlength{\utl@titleTextBottom}
\setlength{\utl@titleTextBottom}{89.5mm}

% Default font size
\newcommand{\utl@fontsize}{11pt}

% Thesis type options
\DeclareOption{master}{} % default
\DeclareOption{phd}{ % 17x24 paper and 10 pt font
    \setlength{\utl@paperwidth}{170mm}
    \setlength{\utl@paperheight}{240mm}
    \setlength{\utl@textwidth}{345pt}
    \renewcommand{\utl@hmarginratio}{1:1}
    \setlength{\utl@titleElementWidth}{176mm}
    \setlength{\utl@titleElementHeight}{135mm}
    \renewcommand{\utl@titleElementScale}{0.8148}
    \setlength{\utl@titleElementUnscaledHeight}{1.227\utl@titleElementHeight}
        % =(216/176)*height
    \setlength{\utl@titleElementBelow}{10mm}
    \setlength{\utl@titleTextBottom}{82mm}
    \renewcommand{\utl@fontsize}{10pt}
}

% `bleed` option adds 3 mm bleed for professional printing
\newif{\ifutl@bleedenabled}
\DeclareOption{bleed}{\utl@bleedenabledtrue}

% Chapter heading style options
\newif{\ifutl@marginchapters}
\DeclareOption{classicchapters}{} % default
\DeclareOption{marginchapters}{ % chapter numbers in right margin
    \utl@marginchapterstrue
}

% Suppress remaining book class options
\DeclareOption*{\OptionNotUsed}

\ProcessOptions\relax
\LoadClass[\utl@fontsize]{\utl@baseclass}

% Packages
% =============================================================================

\RequirePackage[T1]{fontenc}
\RequirePackage{geometry}
\RequirePackage{emptypage}
\RequirePackage{microtype}
\RequirePackage{setspace}
\RequirePackage[\ifutl@marginchapters rigidchapters\fi]{titlesec}
\RequirePackage{titletoc}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage{tikz}
\RequirePackage{babel}
\RequirePackage{csquotes}
\RequirePackage{eso-pic}
\RequirePackage{graphicx}
\RequirePackage[pdfusetitle,bookmarksnumbered,hidelinks]{hyperref}
\RequirePackage[defaultsans,scale=0.92]{opensans}
    % scaled for more compatible x-height with most serif body text fonts

% Page geometry
% =============================================================================

% Set layout dimensions to paper dimensions without bleed
\newlength{\utl@layoutwidth}
\setlength{\utl@layoutwidth}{\utl@paperwidth}
\newlength{\utl@layoutheight}
\setlength{\utl@layoutheight}{\utl@paperheight}

\newlength{\utl@bleed}
\setlength{\utl@bleed}{0mm}

% Add 3 mm bleed to paper dimensions if `bleed` option is chosen
\ifutl@bleedenabled
    \setlength{\utl@bleed}{3mm}
    \addtolength{\utl@paperwidth}{2\utl@bleed}
    \addtolength{\utl@paperheight}{2\utl@bleed}
\fi

\geometry{
    % showframe,
    paperwidth=\utl@paperwidth,
    paperheight=\utl@paperheight,
    layoutwidth=\utl@layoutwidth,
    layoutheight=\utl@layoutheight,
    layoutoffset=\utl@bleed,
    textwidth=\utl@textwidth,
    vscale=0.75,
    vmarginratio={1:1},
    hmarginratio=\utl@hmarginratio,
    headheight=30pt, % good for up to two header lines
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
\newlength{\utl@titleElementHOffset}
\setlength{\utl@titleElementHOffset}{3mm}
\addtolength{\utl@titleElementHOffset}{-\utl@bleed}
    % resets offset to 0 mm when printing with bleed

\addtolength{\utl@titleElementBelow}{\utl@bleed}

% For PhD thesis with 170x240 mm paper, top edge of element should be cropped
% so that element height is 135 mm.
\newcommand{\utl@titleElement}{%
    \put(-\utl@titleElementHOffset,\utl@titleElementBelow){%
        \includegraphics[
            width=\utl@titleElementWidth,
            viewport=0mm 0mm 216mm \utl@titleElementUnscaledHeight,
            clip
        ]{titlepage/element.pdf}%
    }%
}

\newcommand{\utl@titleImage}{%
    \put(-\utl@titleElementHOffset,\utl@titleElementBelow){%
        \begin{tikzpicture}[scale=\utl@titleElementScale]
            \clip (0, 18) -- (19.94, 18) -- (13.44, 0) -- (0, 0) -- cycle;
            \clip (0, \utl@titleElementUnscaledHeight) --
                (21.6, \utl@titleElementUnscaledHeight) --
                (21.6, 0) -- (0, 0) -- cycle;
            \node[anchor=south west, inner sep=0] at (0, 0) {%
                \includegraphics[height=\utl@titleElementHeight]%
                    {\utl@titleImageFile}%
            };
        \end{tikzpicture}%
    }%
}

% Top left corner of logo is at (12 mm, 12 mm) from top left corner of layout;
% "UiT..." name aligns with thesis title text at 27 mm from left edge.
\newlength{\utl@titleLogoLeft}
\setlength{\utl@titleLogoLeft}{\utl@bleed} % left edge of paper
\addtolength{\utl@titleLogoLeft}{12mm} % left edge of logo

% Calculate space from bottom of logo to bottom of page
\newlength{\utl@titleLogoBelow}
\setlength{\utl@titleLogoBelow}{\utl@paperheight} % top edge of paper
\addtolength{\utl@titleLogoBelow}{-\utl@bleed} % top edge of layout
\addtolength{\utl@titleLogoBelow}{-24.2mm} % bottom edge of logo

\newcommand{\utl@titleLogo}{\put(\utl@titleLogoLeft,\utl@titleLogoBelow){%
    \includegraphics[height=12.2mm]{titlepage/logo_\utl@titleLogoFile.pdf}%
}}

\newcommand{\thesisFaculty}[1]{\gdef\@faculty{#1}}
\newcommand{\thesisDepartment}[1]{\gdef\@department{#1}}
\newcommand{\thesisSubtitle}[1]{\gdef\@subtitle{#1}}
\newcommand{\thesisCourse}[1]{\gdef\@course{#1}}
\newcommand{\thesisImage}[1]{\gdef\utl@titleImageFile{#1}}

\newcommand{\utl@titleLogoFile}{english} % logo in English by default

\renewcommand{\maketitle}{%
    \babelprovide[hyphenrules=finnish]{samin}% initializing Northern Sami
    % Detect document language to select appropriate logo
    \iflanguage{norsk}{\renewcommand{\utl@titleLogoFile}{bokmål}}{%
    \iflanguage{nynorsk}{\renewcommand{\utl@titleLogoFile}{nynorsk}}{%
    \iflanguage{samin}{\renewcommand{\utl@titleLogoFile}{samin}}{}}}%
    %
    \newgeometry{
        layoutwidth=\utl@layoutwidth,
        layoutheight=\utl@layoutheight,
        layoutoffset=\utl@bleed,
        ignorehead,
        ignorefoot,
        top=0mm,
        left=27mm,
        right=12mm
    }%
    \AddToShipoutPictureBG*{\utl@titleElement}%
    \ifdefined\utl@titleImageFile%
        \AddToShipoutPictureFG*{\utl@titleImage}%
    \fi%
    \AddToShipoutPictureBG*{\utl@titleLogo}%
    \begin{titlepage}%
        \setlength{\parindent}{0pt}%
        \setlength{\parskip}{0pt}%
        \begin{minipage}[b][\utl@titleTextBottom]{\textwidth}%
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

\newcommand{\utl@hffont}{\opensans\fontseries{l}\selectfont}
\newcommand{\utl@hfformat}[1]{\utl@hffont\textcolor{hfcolor}{#1}}

% Inline UiT slash with space around it
\newcommand{\utl@uitslashsep}[1][0.25]
    {\hspace{0.6em}\raisebox{-0.25pt}{\uitslash{#1}}\hspace{0.6em}}

% Chapter and section labels in header
\renewcommand{\sectionmark}[1]
    {\markright{\thesection\utl@uitslashsep\MakeUppercase{#1}}}
\renewcommand{\chaptermark}[1]{\markboth{%
    \if@mainmatter\MakeUppercase{\@chapapp}\ \thechapter\utl@uitslashsep\fi%
    \MakeUppercase{#1}%
}{}}

\fancypagestyle{plain}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyfoot[C]{\utl@hfformat{\thepage}}
}

\fancypagestyle{standard}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead[LO]{\small\lsstyle\utl@hfformat{\rightmark}}
    \fancyhead[RE]{\small\lsstyle\utl@hfformat{\leftmark}}
    \fancyhead[LE,RO]{\utl@hfformat{\thepage}}
}
\pagestyle{standard}

% Headings
% =============================================================================

\newcommand{\utl@headingfont}{\opensans\bfseries}

\ifutl@marginchapters % `marginchapters` option
    % Right edge of chapter number, from left edge of text column
    \newlength{\utl@chapternumberoffset}
    \setlength{\utl@chapternumberoffset}{\utl@textwidth}
    \addtolength{\utl@chapternumberoffset}{36pt}

    % Chapter titles won't extend past 3/4 of text width
    \newcommand{\utl@chaptertitlebox}[1]{%
        \begin{minipage}[t]{0.75\utl@textwidth}%
            \raggedright\Huge #1%
        \end{minipage}%
    }

    \titleformat{\chapter}[block]
        {\begin{singlespace}\normalfont\utl@headingfont\huge}
        {\rlap{\begin{minipage}[t]{\utl@chapternumberoffset}%
            \vspace{-36pt}%
            \hspace{\utl@chapternumberoffset}%
            \raggedleft%
            \fontsize{56pt}{56pt}\selectfont%
            \smash{\raisebox{-18pt}{\uitslash{3}}}%
            \thechapter%
        \end{minipage}}}
        {0pt}
        {\utl@chaptertitlebox}
        [\end{singlespace}]


    % Body text starts 1/3 of the way down from the top of page
    \titlespacing*{\chapter}{0pt}{0pt}{0.208\utl@paperheight}

\else % `classicchapters` option
    \titleformat{\chapter}[display]
        {\begin{singlespace}\normalfont\utl@headingfont\huge\bfseries}
        {%
            \vspace{-30pt}%
            \fontsize{56pt}{56pt}\selectfont%
            \raisebox{-12pt}{\uitslash{3}}%
            \thechapter%
        }
        {20pt}{\raggedright\Huge}[\end{singlespace}]
\fi

% Other headings are kept the same but with previously specified font
\titleformat*{\section}{\utl@headingfont\Large}
\titleformat*{\subsection}{\utl@headingfont\large}
\titleformat*{\subsubsection}{\utl@headingfont\normalsize}
\titleformat*{\paragraph}{\utl@headingfont\normalsize}
\titleformat*{\subparagraph}{\utl@headingfont\normalsize}

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
        {\lsstyle\textsc{\MakeLowercase{#2}}}:\hspace{0.5em}\@shortchapter
    }{%
        % Chapter title to be shown in PDF bookmark
        #2: \@shortchapter%
    }]{%
        % Chapter title to be printed on page
        {%
            \LARGE%
            \ifutl@marginchapters% `marginchapters` option
                \vspace{-5.5ex}% shifts label up so title position is unchanged
            \fi%
            \fontseries{l}\selectfont\lsstyle\MakeUppercase{#2}% label
        }\\
        \vspace{0.5ex}#3%
    }%
    % Chapter title to be printed in header
    \chaptermark{#2: \@shortchapter}%
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
        {%
            \LARGE%
            \ifutl@marginchapters% `marginchapters` option
                \vspace{-5.5ex}% shifts label up so title position is unchanged
            \fi%
            \fontseries{l}\selectfont\lsstyle\MakeUppercase{#2}% label
        }\\
        \vspace{0.5ex}#3%
    }%
    \addcontentsline{toc}{chapter}{\texorpdfstring{%
        % Chapter title to be printed in table of contents
        {\lsstyle\textsc{\MakeLowercase{#2}}}:\hspace{0.5em}\@shortchapter
    }{%
        % Chapter title to be shown in PDF bookmark
        #2: \@shortchapter%
    }}%
    % Chapter title to be printed in header
    \markboth{\MakeUppercase{#2}: \MakeUppercase{\@shortchapter}}
        {}%
}

% Table of contents
% =============================================================================

\setcounter{tocdepth}{1}

\titlecontents{chapter} % section
    [0em] % left
    {\normalfont} % above code
    {{\bfseries\contentslabel{0em}}\hspace{1.75em}} % numbered entry format
    {\hspace{1.75em}} % numberless entry format
    {\hspace{1em}\contentspage} % filler-page format
    [\vspace{0.5\baselineskip}] % below code

\titlecontents{section} % section
    [1.75em] % left
    {\normalfont} % above code
    {\contentslabel{0em}\hspace{2em}} % numbered entry format
    {\hspace{2em}} % numberless entry format
    {\hspace{1em}\contentspage} % filler-page format
    [\vspace{0.5\baselineskip}] % below code

\titlecontents{figure} % section
    [2.5em] % left
    {\normalfont} % above code
    {\contentslabel{2.5em}} % numbered entry format
    {} % numberless entry format
    {\titlerule*[8pt]{.}\contentspage} % filler-page format
    [\vspace{0.5\baselineskip}] % below code

\titlecontents{table} % section
    [2.5em] % left
    {\normalfont} % above code
    {\contentslabel{2.5em}} % numbered entry format
    {} % numberless entry format
    {\titlerule*[8pt]{.}\contentspage} % filler-page format
    [\vspace{0.5\baselineskip}] % below code

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