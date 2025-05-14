# uit-thesis-light

A simple LaTeX document class for writing a master's or PhD thesis at UiT – The Arctic University of Norway

The appearance is largely a recreation of the visual style of [uit-thesis](https://github.com/egraff/uit-thesis/) by Erlend Graff, with some of my own adjustments, following the guidelines of and using resources provided by the [UiT Visual Profile](https://uit.no/ansatte/grafiskprofil) (Norwegian). The code is written from scratch independently.

Author: [Cooper Johnston](https://cooper-johnston.github.io)

License: MIT License; see the file [LICENSE](https://raw.githubusercontent.com/cooper-johnston/uit-thesis-light/refs/heads/main/LICENSE) for details.

Repository: [https://github.com/cooper-johnston/uit-thesis-light](https://github.com/cooper-johnston/uit-thesis-light)

---

## Getting started

1. Put the file ``thesis.cls`` and the directory ``titlepage/`` and all of the files inside it into the directory where you want to write your thesis.
2. Create a ``.tex`` file for your thesis.
3. Begin this file with the line
    ```
    \documentclass[SECOND LANGUAGE,MAIN LANGUAGE,THESIS TYPE]{thesis}
    ```

    Replace ``SECOND LANGUAGE`` and ``MAIN LANGUAGE`` with the languages for your document; it is possible to have only one or more than two, but the main language must always come last. See [Language support](#language-support) for more info.
    
    Replace ``THESIS TYPE`` with ``master`` or ``phd`` depending on your thesis type.
4. Recommended: In the preamble (before ``\begin{document}``), load the ``stix2`` package to use the Stix Two font for body text:
    ```
    \usepackage{stix2}
    ```

    The order of the packages can sometimes lead to errors. If you load other packages, it is a good rule of thumb to put this one last. If you run into issues, try changing the order.
5. Also in the preamble, specify the fields for the title page.  
    **Required fields:**
    * ``\thesisFaculty{}``
    * ``\title{}``
    * ``\thesisSubtitle{}``
    * ``\author{}``
    * ``\thesisCourse{}`` (can enter the name of your program if there is no course code for your thesis)
    * ``\date{}``

    **Optional fields:**
    * ``\thesisDepartment{}`` (*institutt*)
    * ``\thesisImage{}`` (the file name of an image to be shown on the title page)
6. Begin your document:
    ```
    \begin{document}

    \maketitle

    CONTENT GOES HERE

    \end{document}
    ```

    See the file ``example.tex`` for more.
7. Compile with pdfLaTeX or LuaLaTeX (pdfLaTeX is the default option on Overleaf).

## More information

### Language support

The language you specify as the main document language will be the language of the UiT logo on the title page and the language used in headings like “Table of Contents”. The supported options are
* ``english``, or variants like ``USenglish`` or ``UKenglish``, for English
* ``norsk`` for Bokmål
* ``nynorsk`` for Nynorsk
* ``samin`` for Northern Sami.

The Northern Sami language is not fully defined in the ``babel`` package. If you specify Northern Sami as your document language, the document class will tell ``babel`` to use Finnish hyphenation patterns and ``csquotes`` to use Norwegian quotation marks.

### Paper and font sizes

The ``master`` option uses A4 paper and 11 pt font, while the ``phd`` option uses 17x24 cm paper and 10 pt font.

### Required packages

The document class loads the following packages, in order:
1. ``fontenc`` (for better character support)
2. ``geometry`` (for page size and layout)
3. ``emptypage`` (for blank pages)
4. ``microtype`` (for better justified text)
5. ``setspace`` (for line spacing)
6. ``titlesec`` (for heading formatting)
7. ``titletoc`` (for table of contents formatting)
8. ``fancyhdr`` (for headers and footers)
9. ``xcolor`` (for color)
10. ``tikz`` (for drawing parts of the title page)
11. ``babel`` (for language support)
12. ``csquotes`` (for smart quotation marks)
13. ``eso-pic`` (for drawing parts of the title page)
14. ``graphicx`` (for drawing parts of the title page)
15. ``hyperref`` (for PDF bookmarks, links, and metadata)
16. ``opensans`` (official UiT sans-serif font).