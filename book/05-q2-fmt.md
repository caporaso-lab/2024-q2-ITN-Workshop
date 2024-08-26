# Assessing engraftment extent with q2-FMT
```{usage-scope}
---
name: tutorial
---
```

```{usage-selector}
---
default-interface: cli-usage
---
```

When investigating FMTs, it is really important to understand the extent to which the recipient microbiome engrafted the donated microbiome. Without assessing engraftment extent, we can never fully understand the clinical outcomes of the study {numref}`engraftment-extent`.

```{figure} _images/engraftment-extent.png
:name: engraftment-extent

Created with BioRender.
```

[Herman et al. (2024)](https://pubmed.ncbi.nlm.nih.gov/38659636/) {cite:t}`herman_2024` defines three criteria that are important for understanding if a microbiome engrafted following FMT.
These are:
1. Chimeric Asymmetric Community Coalescence
1. Donated Microbiome Indicator Features
1. Temporal Stability.

q2-fmt was designed to help you investigate all three of these criteria.
q2-fmt is a QIIME 2 plugin that was designed to help you investigate all three of these criteria.

## Chimeric Asymmetric Community Coalescence

In this tutorial, we will be investigating the first criterion: Chimeric Asymmetric Community Coalescence.

We'll assess the *distance to donor* (using Jaccard distance) to see how the recipient's distance to their donor sample changes following the FMT.
Before continuing, think about what you might expect to see.
Should you expect a recipient's gut microbiome composition to become more or less similar to their donor after FMT?
How quickly would you expect to see that change?
What do you expect would happen a few months or years after the transplant?

```{usage}
use.action(
    use.UsageAction('fmt', 'cc'),
    use.UsageInputs(
        diversity_measure=core_metrics_results.jaccard_distance_matrix,
        metadata=sample_metadata,
        distance_to='donor',
        compare='baseline',
        time_column='timepoints',
        reference_column='DonorSampleID',
        subject_column='PatientID',
        filter_missing_references=True,
        against_group='0',
        p_val_approx='asymptotic'
    ),
    use.UsageOutputNames(
        stats='jaccard_raincloud_stats',
        raincloud_plot='jaccard_raincloud_plot'
    )
)
```

In the resulting *raincloud plot*, we see that following cancer treatment the recipients distance to donor is relatively high.
This seems to be naturally resolving itself but after FMT intervention the recipient's microbiome looks more similar to the donor.
We see some stability in this but by the last time point the recipient's microbiome mostly looks unique from its donated microbiome.

## An optional exercise

While FMT research is still in its infancy, some early studies suggest that long-term, returning to a "personalize microbiome" is common after FMT, but in some cases features of the donated microbiome are retained.
Let's investigate this idea in an exercise.

(alpha-diversity-exercise)=
```{admonition} Tracking alpha diversity following FMT
:class: note

Above we tracked the *distance to donor* following FMT intervention.
This is a beta diversity approach to assessing Chimeric Asymmetric Community Coalescence that tells us about the overall membership or composition of a microbiome.
We can also directly investigate what happens to community richness, an alpha diversity metric, following FMT intervention.

Try to adapt your above command, and perhaps referring to other sections of the tutorial, to compute a raincloud plot that will allow you to investigate this using the *observed features* vector you computed earlier.
When you're done, or if you get stuck, expand the following dropdown box for a command that will generate this plot for you.
```

(alpha-diversity-solution)=
```{admonition} Solution
:class: dropdown, note

```{usage}
use.action(
    use.UsageAction('fmt', 'cc'),
    use.UsageInputs(
        diversity_measure=core_metrics_results.observed_features_vector,
        metadata=sample_metadata,
        distance_to='donor',
        compare='baseline',
        time_column='timepoints',
        reference_column='DonorSampleID',
        subject_column='PatientID',
        filter_missing_references=True,
        against_group='0',
        p_val_approx='asymptotic'
    ),
    use.UsageOutputNames(
        stats='obs_features_raincloud_stats',
        raincloud_plot='obs_features_raincloud_plot'
    )
)
```
