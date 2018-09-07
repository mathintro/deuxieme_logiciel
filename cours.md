---
author:
- Orestis Malaspinas
title: MATH2 pour Technologies de l'Information orientation logiciel
autoSectionLabels: false
autoEqnLabels: true
eqnPrefix:
  - "éq."
  - "éqs."
chapters: true
numberSections: false
chaptersDepth: 1
sectionsDepth: 3
lang: fr
documentclass: book
papersize: A4
cref: false
urlcolor: blue
---
\newcommand{\real}{\mathbb{R}}
\newcommand{\rational}{\mathbb{Q}}
\newcommand{\integer}{\mathbb{Z}}
\renewcommand{\natural}{\mathbb{N}}
\newcommand{\complex}{\mathbb{C}}
\newcommand{\zbar}{\bar{z}}
\newcommand{\dd}{\mathrm{d}}
\newcommand{\perm}{\mathrm{perm}}
\newcommand{\card}{\mathrm{card}}
\newcommand{\fh}{\hat{f}}
\newcommand{\gh}{\hat{g}}
\newcommand{\hh}{\hat{h}}
\renewcommand{\Re}{\mathrm{Re}}
\renewcommand{\Im}{\mathrm{Im}}
\newcommand{\pDeriv}[2]{\frac{\partial #1}{\partial #2}}
\newcommand{\pDerivTwo}[2]{\frac{\partial^2 #1}{\partial #2^2}}
\newcommand{\dDeriv}[2]{\frac{\dd #1}{\dd #2}}
\newcommand{\dDerivTwo}[2]{\frac{\dd^2 #1}{\dd #2^2}}
\newcommand{\cm}{\mathrm{cm}}
\newcommand{\km}{\mathrm{km}}
\newcommand{\mm}{\mathrm{mm}}
\newcommand{\cd}{\mathrm{cd}}
\newcommand{\mol}{\mathrm{mol}}
\newcommand{\m}{\mathrm{m}}
\renewcommand{\l}{\mathrm{l}}
\newcommand{\s}{\mathrm{s}}
\newcommand{\kg}{\mathrm{kg}}
\newcommand{\g}{\mathrm{g}}
\newcommand{\K}{\mathrm{K}}
\newcommand{\J}{\mathrm{J}}
\renewcommand{\C}{\mathrm{C}}
\newcommand{\oC}{^\circ\mathrm{C}}
\newcommand{\oK}{^\circ\mathrm{K}}
\newcommand{\A}{\mathrm{A}}
\newcommand{\N}{\mathrm{N}}
\newcommand{\atm}{\mathrm{atm}}
\renewcommand{\bar}{\mathrm{bar}}
\newcommand{\V}{\mathrm{V}}
\newcommand{\W}{\mathrm{W}}
\newcommand{\kW}{\mathrm{kW}}
\newcommand{\dl}{\mathrm{dl}}
\newcommand{\dm}{\mathrm{dm}}
\newcommand{\kcal}{\mathrm{kcal}}
\newcommand{\h}{\mathrm{h}}
\newcommand{\Pa}{\mathrm{Pa}}
\newcommand{\vectwo}[2]{\begin{pmatrix}#1 \\ #2 \end{pmatrix}}
\newcommand{\vecthree}[3]{\begin{pmatrix}#1 \\ #2 \\ #3 \end{pmatrix}}
\newcommand{\mat}[1]{\underline{\underline{#1}}}
\newcommand{\com}[1]{\mat{\mathrm{com}#1}}
\newcommand{\mattwo}[4]{\begin{pmatrix}
                #1 & #2 \\
                #3 & #4
            \end{pmatrix}}

# Rappel sur les fonctions et les polynômes

## Les fonctions

Une fonction, notée $f$, est une relation entre deux ensembles. Soient deux ensembles $X$ et $Y$, cette fonction va associer à chaque élément de $X$ à un élément de $Y$.

On note de façon formelle
$$f:X\rightarrow Y.$$
Ici $X$ est le *domaine de définition* de $f$ et $Y$ est le *domaine d'arrivée*.
Cette notation nous donne juste le domaine de définition et le domaine d'arrivée de $f$ mais ne nous dit pas quelle est la règle d'association entre les éléments de $X$ et les éléments de $Y$.

Pour un exemple concret, on peut prendre
$$f:\real\rightarrow\real,$$
où $f$ est définie par
$$f:x\rightarrow x^2,\quad \mbox{ou}\quad f(x)=x^2.$$

On a donc ici que $\real$ est le domaine de définition et d'arrivée de $f$. En revanche tout $\real$ n'est pas "couvert" par les éléments de $f(x)$.

## Fonctions polynomiales

Une fonction polynomiale de $\real\rightarrow\real$ de degré $n\in\natural$ est une fonction du genre
\begin{align}
&f:X\rightarrow Y,\\
&f\rightarrow a_0+a_1\cdot x+a_2\cdot x^2+\dots+a_n\cdot x^n,
\end{align}
où $\{a_i\}_{i=0}^n\in\real$ sont des coefficients réels.

# L'interpolation

Dans ce chapitre, nous allons étudier comment nous pouvons essayer de reconstruire de l'information manquante
dans un signal ou dans une image. Cela est très utile si nous souhaitons rééchantillonner un signal,
ou dépixeliser une image (un peu comme dans la série "les experts"). On appelle **techniques d'interpolation**
les méthodes utilisées pour résoudre ce genre de problème.

Dans la @fig:interp_experts nous pouvons voir 3 versions d'une image. La première pixelisée (tout à gauche), 
la seconde (au centre) rééchantillonnée de façon naïve, et la troisième (à droite) 
avec une méthode plus avancée.

![Différents rééchantillonages d'une image pixelisée (plus proche voisin, bilinéaire et bicubique de gauche à droite). Source: Wikipedia
<https://bit.ly/2wTidqj>, <https://bit.ly/2wTib1F>, et <https://bit.ly/2wPyjAA>.](figs/Interpolation-all.png){#fig:interp_experts width=70%}

## Définitions diverses

Avant de faire à proprement parler des interpolations, nous allons d'abord poser le problème de façon 
mathématique et aussi simple que possible. 
Nous définissons un ensemble de $n+1$ points ($n\in\natural$) $\{p_i\}_{i=0}^n\in\real$,
qui correspondent à $n+1$ positions $\{x_i\}_{i=0}^n\in\real$ (voir @fig:points).
Pour simplifier, nous allons supposer qu'ils sont dans un ordre croissant, soit
\begin{equation}
x_0 < x_1< \cdots < x_n.
\end{equation}

![Six points $p_0$, ..., $p_5$ aux positions $x_0$, ..., $x_5$.](figs/points.png){#fig:points width=100%}

Le but à présent est de déterminer une fonction $f$ définie 
dans tout l'intervalle $[x_0,x_n]$ et passant par tous les points $p_i$ (voir @fig:points_int).

![La fonction d'interpolation $f(x)$ passant par les six paires de points $(x_0,p_0)$, ..., $(x_5,p_5)$.](figs/points_int.png){#fig:points_int width=100%}

La fonction $f(x)$ n'est pas unique et il existe différents moyens de déterminer ces fonctions qui peuvent être plus ou moins complexes.
