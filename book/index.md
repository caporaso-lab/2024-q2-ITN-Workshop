# QIIME 2 Cancer AutoFMT Tutorial

This tutorial was originally developed for the 2024 ITN and QIIME 2
workshop, taught August 27th - August 29th, 2024.

```{admonition} Important!
Please review the
[QIIME 2 Community Code of Conduct](https://forum.qiime2.org/t/qiime-2-community-code-of-conduct/9057)
. All workshop instructors agreed to abide by these community expectations and
we hope you will too and you become involved in the QIIME 2 community.
```

## Relevant links and protocols

* [Project homepage](https://qiime2.org)
* [Support and Discussion Forum](https://forum.qiime2.org) (go here for help)
* [YouTube channel](https://youtube.com/qiime2)
* [User Documentation](https://docs.qiime2.org)
* [Developer Documentation](https://develop.qiime2.org)
* [Linkedin](https://www.linkedin.com/groups/14490597/)

## Recommended readings

The following readings will provide background information for this tutorial.
These are presented in priority order.

1. [_Reconstitution of the gut microbiota of antibiotic-treated patients by
    autologous fecal microbiota transplant_](
    https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6468978/)
    ({cite:t}`taur-autofmt-2018`)
1. [_Compilation of longitudinal microbiota data and hospitalome from
    hematopoietic cell transplantation patients_](
    https://www.nature.com/articles/s41597-021-00860-8)
   ({cite:t}`liao-data-2021`)
1. [_Reproducible, interactive, scalable and extensible microbiome data science
    using QIIME 2_](https://doi.org/10.1038/s41587-019-0209-9)
   ({cite:t}`bolyen-qiime2-2019`)
1. [_Assessing Engraftment Following Fecal Microbiota Transplant_](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC11042410/)
   ({cite:t}`herman_2024`)
1. [_q2-longitudinal: Longitudinal and Paired-Sample Analyses of Microbiome
    Data_](http://dx.doi.org/10.1128/mSystems.00219-18)
   ({cite:t}`bokulich-q2long-2018`)
1. [Getting started with QIIME 2](https://gregcaporaso.github.io/q2book/using/getting-started.html)
1. [_Experiences and lessons learned from two virtual, hands-on microbiome
    bioinformatics workshops_](
    https://doi.org/10.1371/journal.pcbi.1009056)
   ({cite:t}`dillon-workshops-2021`)

## Thank you to our instruction team

We thank the many instructors who were involved in preparing this content,
including the data set and the written and video tutorials for the [Cancer Microbiome Intervention Tutorial](https://docs.qiime2.org/jupyterbooks/cancer-microbiome-intervention-tutorial/index.html).


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
```

## Thank you to our funders

The QIIME 2 project is funded in part by:
* The National Cancer Institute:
  * [Informatics Technology for Cancer Research](https://itcr.cancer.gov/)
    (1U24CA248454-01) to JGC
  * [The Partnership for Native American Cancer
     Prevention](https://in.nau.edu/nacp/) (U54CA143925 and U54CA143924) to JGC
* Chan-Zuckerberg Initiative Essential Open Source Software for Science to JGC

[Jupyter Book](https://jupyterbook.org) is funded by the Alfred P. Sloan Foundation
 to JGC.

The preparation and dissemination of the data used in this tutorial was funded
in part by the National Institutes of Health (NIH) grants U01 AI124275, R01
AI137269 and U54 CA209975 to Joao B. Xavier.

QIIME 2 was initially developed with support from the National Science
Foundation
([1565100](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1565100)) to JGC.

The ITN is supported by:
 * The National Cancer Institute (UE5CA254170)
