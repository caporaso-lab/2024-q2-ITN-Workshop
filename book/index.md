# QIIME 2 Cancer AutoFMT Tutorial

This tutorial was originally developed for the 2024 ITN and QIIME 2
workshop, taught August 27th - August 29th, 2024.

```{admonition} Code of Conduct
Please review the [QIIME 2 Community Code of Conduct](https://forum.qiime2.org/t/qiime-2-community-code-of-conduct/9057).
All workshop instructors agreed to abide by these community expectations and we hope you will too as you become involved in the QIIME 2 community.
```

## Relevant links and protocols

* [QIIME 2 Forum](https://forum.qiime2.org): Technical support and many other resources.
* [Project homepage](https://qiime2.org): Announcements and other relevant links.
* [YouTube channel](https://youtube.com/qiime2): Full video courses in videos ranging from 5-60 minutes.
* [User Documentation](https://docs.qiime2.org): The official QIIME 2 user documentation.
  This is in the process of being refactored and will transition to a new URL shortly.
* [_Developing with QIIME 2_](https://develop.qiime2.org): A free online book for bioinformatics software developers looking to make their tools accessible in the QIIME 2 ecosystem. Includes a step-by-step guide to building your first QIIME 2 plugin.
* [Linkedin](https://www.linkedin.com/groups/14490597/): A new LinkedIn group for the QIIME 2 community.

## Recommended readings

The following readings will provide background information for this tutorial.
These are presented in priority order.

1. [_Assessing Engraftment Following Fecal Microbiota Transplant_](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC11042410/) ({cite:t}`herman_2024`)
1. [_Reconstitution of the gut microbiota of antibiotic-treated patients by autologous fecal microbiota transplant_](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6468978/) ({cite:t}`taur-autofmt-2018`)
1. [_Compilation of longitudinal microbiota data and hospitalome from hematopoietic cell transplantation patients_](https://www.nature.com/articles/s41597-021-00860-8) ({cite:t}`liao-data-2021`)
1. [_Reproducible, interactive, scalable and extensible microbiome data science using QIIME 2_](https://doi.org/10.1038/s41587-019-0209-9) ({cite:t}`bolyen-qiime2-2019`)
1. [_q2-longitudinal: Longitudinal and Paired-Sample Analyses of Microbiome Data_](http://dx.doi.org/10.1128/mSystems.00219-18) ({cite:t}`bokulich-q2long-2018`)
1. [Getting started with QIIME 2](https://gregcaporaso.github.io/q2book/using/getting-started.html)
1. [_Experiences and lessons learned from two virtual, hands-on microbiome bioinformatics workshops_](https://doi.org/10.1371/journal.pcbi.1009056) ({cite:t}`dillon-workshops-2021`)

## Your instruction team

```{list-table}
:header-rows: 1

* - Name
  - Affiliation(s)
* - J. Gregory Caporaso
  - Center for Applied Microbiome Sciences, Pathogen and Microbiome Institute,
    Northern Arizona University, USA
* - Johannah Hagen
  - Center for Applied Microbiome Sciences, Pathogen and Microbiome Institute,
    Northern Arizona University, USA
* - Chloe Herman
  - Center for Applied Microbiome Sciences, Pathogen and Microbiome Institute,
    Northern Arizona University, USA
* - Colin Wood
  - Center for Applied Microbiome Sciences, Pathogen and Microbiome Institute,
    Northern Arizona University, USA
* - Colin Brislawn
  - Vasogo, USA
* - Carrie Wright
  - Fred Hutch Cancer Center, USA
* - Candace Savonen
  - Fred Hutch Cancer Center, USA
* - Kate Issac
  - Fred Hutch Cancer Center, USA
```

We additionally thank the many instructors who were involved in preparing the content used in this tutorial, including preparing the data and the written and video tutorials for the [Cancer Microbiome Intervention Tutorial](https://docs.qiime2.org/jupyterbooks/cancer-microbiome-intervention-tutorial/index.html) from which this content is derived.

## Thank you to our funders

This workshop was funded in part by NIH National Cancer Institute Informatics Technology for Cancer Research grant [1U24CA248454-01](https://reporter.nih.gov/project-details/9951750) to JGC and UE5CA254170 to the ITCR Training Network.

QIIME 2 is additionally funded by 1U24CA248454-01, and grants from the Chan Zuckerberg Initiative (CZI) DAF, an advised fund of Silicon Valley Community Foundation, to JGC including [DAF2019-207342](https://doi.org/10.37921/862772dbrrej) (CZI grant DOI: 10.37921/862772dbrrej; funder DOI 10.13039/100014989). Initial support for the development of QIIME 2 was provided through a [grant](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1565100) from the National Science Foundation to JGC.

The Cancer Galaxy server used in this event is funded in part by NIH grants U24CA231877 and U24HG006620 to Jeremy Goecks.

The preparation and dissemination of the data used in this tutorial was funded in part by the National Institutes of Health (NIH) grants U01 AI124275, R01 AI137269 and U54 CA209975 to Joao B. Xavier.

This website is built with MyST Markdown and Jupyter Book, which are supported in part with [funding](https://sloan.org/grant-detail/6620) from the Alfred P. Sloan Foundation.
