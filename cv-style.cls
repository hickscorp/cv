% -- Encoding UTF-8 without BOM

\ProvidesClass{cv-style}[2015/02/27 CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

\RequirePackage{parskip}

% Hyphenation.

\newcommand{\sethyphenation}[3][]{%
  \sbox0{
    \begin{otherlanguage}[#1]{#2}
      \hyphenation{#3}
    \end{otherlanguage}
  }
}

% Last Updated

\newcommand{\lastupdated}{
  \begin{textblock}{10}(11.3, 0.05)
    \raggedleft\fontsize{8pt}{10pt}\color{white}\thinfont 
    Last Updated on \today
  \end{textblock}
  \begin{textblock}{10}(11.3, 0.55)
    \raggedleft\fontsize{8pt}{10pt}\color{white}\thinfont
    Source on \href{https://github.com/hickscorp/cv}{Github}
  \end{textblock}
}

% Colors

\RequirePackage{xcolor}

\definecolor{white}{HTML}{ffffff}
\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4d4d4d}
\definecolor{lightgray}{HTML}{999999}
\definecolor{blue}{HTML}{66d9ee}
\definecolor{red}{HTML}{Fa2772}
\definecolor{orange}{HTML}{fe9720}
\definecolor{green}{HTML}{a7e22e}
\definecolor{purple}{HTML}{9358fe}
\definecolor{aquamarine}{HTML}{36af90}
\definecolor{date}{HTML}{a4a4a4}

\colorlet{textcolor}{gray}
\colorlet{headercolor}{gray}

\ifdefined\@cv@print
  \colorlet{blue}{gray}
  \colorlet{red}{gray}
  \colorlet{orange}{gray}
  \colorlet{green}{gray}
  \colorlet{purple}{gray}
  \colorlet{aquamarine}{gray}
  \colorlet{fillheader}{white}
  \colorlet{header}{gray}
\else
  \colorlet{fillheader}{gray}
  \colorlet{header}{white}
\fi

% Fonts

\RequirePackage[quiet]{fontspec}
\RequirePackage[math-style=TeX]{unicode-math}

\newfontfamily\bodyfont{Roboto-Regular}[Path=fonts/]
\newfontfamily\bodyfontit{Roboto-LightItalic}[Path=fonts/]
\newfontfamily\thinfont{Roboto-Thin}[Path=fonts/]
\newfontfamily\headingfont{RobotoCondensed-Bold}[Path=fonts/]

\defaultfontfeatures{Mapping=tex-text}
\setmainfont[Mapping=tex-text, Color=textcolor, Path=fonts/]{Roboto-Light}

\renewcommand{\bfseries}{\headingfont\color{headercolor}}

% Page size and margins.

\RequirePackage[absolute,overlay]{textpos}
\setlength{\TPHorizModule}{0.01\paperwidth}
\setlength{\TPVertModule}{0.01\paperwidth}

% Header

\RequirePackage{tikz}

\newcommand{\header}[2]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=2cm] (box) at (current page.north){};
    \node [anchor=east] (name) at (box) {
      \fontsize{26pt}{65pt}\color{header}
      {\thinfont #1} {\bodyfont #2}
    };
  \end{tikzpicture}
  \lastupdated
  \vspace{0.98cm}
}

% Language.

\RequirePackage{polyglossia}
\setdefaultlanguage[variant=british]{english}

% Side block

\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}
\newenvironment{aside}{%
  \let\oldsection\section\renewcommand{\section}[1]{%
    \par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}%
  }
  \begin{textblock}{3.7}(1, 0.4)
  \begin{flushright}
  \obeycr
}{%
  \restorecr
  \end{flushright}
  \end{textblock}
  \let\section\oldsection
}

% Section header color rotation.

\newcounter{colorCounter}
\def\@sectioncolor#1#2#3{
  {\color{
    \ifcase\value{colorCounter}
      green\or
      orange\or
      purple\or
      red\or
      aquamarine\or
      blue
    \else
      headercolor
    \fi
  }#1#2#3}%
  \stepcounter{colorCounter}%
}

% Section.

\renewcommand{\section}[1]{{
  \par\vspace{0.7cm}
  {\LARGE\headingfont\color{headercolor}\@sectioncolor #1}%
  \par\vspace{\parskip}%
}}

% Jobs.

\usepackage{longtable}

\newenvironment{jobs}{%
  \renewcommand*{\arraystretch}{1.2}
  \begin{longtable}{lr}
}{
  \end{longtable}
}

% Job.

\newcommand{\job}[5]{
  {\color{gray}\textbf{#2}} - {\color{gray}\bodyfontit{#3 - #4}} & #1\\
  \multicolumn{2}{l}{\parbox[t]{13.9cm}{#5}}\\
  \vspace{0.2cm}\\
}

% Other tweaks

\RequirePackage[left=5.4cm,top=1cm,right=2cm,bottom=1cm,nohead,nofoot]{geometry}

% PDF data

\RequirePackage{hyperref}
\hypersetup{
  pdftitle=CV / Resume \textbar{} Pierre Martin,
  pdfauthor=Pierre Martin,
  pdfsubject=CV / Resume%
}
