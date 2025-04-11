# uit-thesis-light

A simple LaTeX document class for writing a master's or PhD thesis at UiT -- The Arctic University of Norway

Author: [Cooper Johnston](https://cooper-johnston.github.io)

License: MIT License; see the file [LICENSE](https://raw.githubusercontent.com/cooper-johnston/uit-thesis-light/refs/heads/main/LICENSE) for details.

Repository: [https://github.com/cooper-johnston/uit-thesis-light](https://github.com/cooper-johnston/uit-thesis-light)

---

## Getting started

1. Put the file ``thesis.cls`` and the directory ``titlepage/`` and all of the files inside it into the directory where you will write your thesis.
2. Create a ``.tex`` file for your thesis.
3. Begin this file with the line
    ```
    \documentclass[TYPE]{thesis}
    ```

    and replace ``TYPE`` with ``master`` or ``phd`` depending on your thesis type.
4. In the preamble (before ``\begin{document}``), load the ``babel`` package:
    ```
    \usepackage[SECONDARY LANGUAGE,main=MAIN LANGUAGE]{babel}
    ```

    and replace ``SECONDARY LANGUAGE`` and ``MAIN LANGUAGE`` with the languages for your document. The main language will be the language of the UiT logo on the title page and the language used in headings like "Table of Contents". The supported options are
    * ``english``, ``USenglish``, or ``UKenglish`` for English
    * ``norsk`` for Bokmål
    * ``nynorsk`` for Nynorsk
    * ``samin`` for Northern Sami.

    **Loading the Babel package is required.**
5. Recommended: Also in the preamble, load the ``stix2`` package to use the Stix Two font for body text:
    ```
    \usepackage{stix2}
    ```

    The order of the packages can sometimes lead to errors. If you load other packages, it is a good rule of thumb to put this one last. If you run into issues, try changing the order.
6. Also in the preamble, specify the fields for the title page.  
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
7. Begin your document:
    ```
    \begin{document}

    \maketitle

    CONTENT GOES HERE

    \end{document}
    ```

    See the file ``example.tex`` for more.
8. Compile with pdfLaTeX or LuaLaTeX (pdfLaTeX is the default option on Overleaf).

## More information

The ``master`` option uses A4 paper and 11 pt font, while the ``phd`` option uses 17x24 cm paper and 10 pt font.

The document class loads the following packages, in order:
1. ``fontenc``
2. ``geometry``
3. ``emptypage``
4. ``microtype``
5. ``titlesec``
6. ``fancyhdr``
7. ``xcolor``
8. ``tikz``
9. ``csquotes``
10. ``eso-pic``
11. ``graphicx``
12. ``hyperref``
13. ``opensans``.

The Northern Sami language is not fully defined in the ``babel`` package. If you specify Northern Sami as your document language, the document class will tell ``babel`` to use Finnish hyphenation patterns and ``csquotes`` to use Norwegian quotation marks.