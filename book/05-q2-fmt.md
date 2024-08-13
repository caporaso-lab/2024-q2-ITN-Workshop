# Assessing Engraftment Extent with q2-FMT
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


When investigating FMTs, it is really important to understand the extent to which the recipient microbiome engrafted the donated microbiome. Without assessing engraftment extent, we can never fully understand the clincial outcomes of the study. 

![engraftment-extent](engraftment-extent.png)
Created with BioRender.

q2-fmt can be used to help you understand engraftment extent following FMT by providing an all-in-one suite for engraftment extent methods.

There are three criteria for assessing engraftment that are defined in Herman et al(2024). 
1. Chimeric Asymmetric Community Coalescence
2. Donated Microbiome Indicator Features
3. Temporal Stability.
For more information on these criteria: [Herman et al (2024)](https://pubmed.ncbi.nlm.nih.gov/38659636/)({cite:t}`herman_2024`).  q2-fmt can be used to investigate all three of these criteria. 


Today for this tutorial, we will be investigating the first criterion: Chimeric Asymmetric Community Coalescence.

Lets take a look at distance to donor (using jaccard distance) see how the recipient's distance to their donor changes following the FMT. 


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
        stats='jaccard_stats',
        raincloud_plot='jaccard_raincloud_plot'
    )
)
```
In our raincloud plot, we can see that following cancer treatment the recipients distance to donor is relatively high. This seems to be naturally resolving itself but after FMT intervention the recipient's microbiome looks more similar to the donor. We see some stability in this but by the last timepoint the repiecient's microbiome mostly looks unique from its donated microbiome.

long term developing a personallze microbiome is common following FMT, however it is important that features of the donated microbiome stick around (Like alpha diveristy). We can investigate this more in our challenge below! 



```{exercise}
:label: alpha-diversity

If you have time, there is an extra challenge! We just looked at distance to donor following FMT intervention. What happens to alpha diveristy following FMT intervention. Lets investigate this using our observered features vector. 

```

```{solution} alpha-diversity
:label: alpha-diversity-solution
:class: dropdown


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
        stats='stats_obs',
        raincloud_plot='raincloud_plot_obs'
    )
)
```
