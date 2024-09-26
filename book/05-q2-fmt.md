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

[Herman et al. (2024)](https://pubmed.ncbi.nlm.nih.gov/38659636/) {cite}`herman_2024` defines three criteria that are important for understanding if a microbiome engrafted following FMT.
These are:
1. Chimeric Asymmetric Community Coalescence
1. Donated Microbiome Indicator Features
1. Temporal Stability.

q2-fmt is a QIIME 2 plugin that was designed to help you investigate all three of these criteria.
For additional infomation, Here is a lecture video of Chloe Herman discussing the importance of assessing engraftment extent![](https://www.youtube.com/watch?v=5vTTDp-t0Bw). 

In this tutorial we will be using q2-fmt to investigating all of these criteron.
## Chimeric Asymmetric Community Coalescence

First, we'll assess the *distance to donor* (using Jaccard distance) to see how the recipient's distance to their donor sample changes following the FMT.
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

### Community Richness

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
#TODO: Lil writeup

### Distance to Baseline
Developing a personalized microbiome following FMT intervention is expected. Although, there is no expected threshold for the length of time before personalization starts. It is important that the recipients microbiome doesn't return to their baseline composition. `qiime fmt cc` can help us investigate this! 

```{usage}
use.action(
    use.UsageAction('fmt', 'cc'),
    use.UsageInputs(
        diversity_measure=core_metrics_results.jaccard_distance_matrix,
        metadata=sample_metadata,
        distance_to='baseline',
        compare='baseline',
        time_column='timepoints',
        baseline_timepoint='0',
        subject_column='PatientID',
        filter_missing_references=True,
        against_group='1',
        p_val_approx='asymptotic'
    ),
    use.UsageOutputNames(
        stats='baseline_jaccard_stats',
        raincloud_plot='baseline_jaccard_raincloud_plot'
    )
)

```
TODO: Lil write up 
### Proportional Engraftment of Donor Strains(PEDS)

If you are interested in how many microbes from the donor engrafted in the recipient, Proportional Engraftment of Donor Strains helps capture just that. 

The above metrics capture how similar the recipient and donor microbiomes are. However, We want these microbiome to coalesce asymmetrically meaning that we want the donor's features to be more prominment in the recipeint following FMT than baseline features. This metrics investigates this asymmetric colescence and captures how many donated features engrafted. Note: Drop incomplete timepoints will be run before drop incomplete subjects. 

```{usage}
sample_peds_dists, = use.action(
        use.UsageAction('fmt', 'sample_peds'),
        use.UsageInputs(
            table=core_metrics_results.rarefied_table,
            metadata=sample_metadata,
            time_column='timepoints',
            reference_column='DonorSampleID',
            filter_missing_references=True,
            subject_column='PatientID', 
            drop_incomplete_timepoints = ["2","5","6"],
            drop_incomplete_subjects=True
        ),
        use.UsageOutputNames(
            peds_dists='sample_peds_dist'
        )

    )
```
Now, we have our PEDS metrics and we want to visualize them. Lets use `qiime fmt peds-heatmap`. 

Note: you can also use `qiime stats plot-rainclouds` to visualize this data! This will create plots more similar to the ouput of `qiime fmt cc` above. 

```{usage}
use.action(
    use.UsageAction('fmt', 'heatmap'),
    use.UsageInputs(
        data=sample_peds_dists,
    ),
    use.UsageOutputNames(
        visualization='sample-heatmap',

    )
)
```
This can also be run using `qiime fmt peds`. Run `qiime fmt ped --help` for more info! 

TODO: ADD Description of output 

### Monte Carlo Simulation of PEDS
```{usage}
per_subject_stats, global_stats = use.action(
        use.UsageAction('fmt', 'peds_simulation'),
        use.UsageInputs(
            table=core_metrics_results.rarefied_table,
            metadata=sample_metadata,
            time_column='timepoints',
            reference_column='DonorSampleID',
            filter_missing_references=True,
            subject_column='PatientID', 
            drop_incomplete_timepoints = ["2","5","6"],
            drop_incomplete_subjects=True
        ),
        use.UsageOutputNames(
            per_subject_stats='per-subject-stats',
            global_stats='global-stats'
        )
    )
```
We can now re-vizualize our heatmap and include these new stats that we created. 
```{usage}
use.action(
    use.UsageAction('fmt', 'heatmap'),
    use.UsageInputs(
        data=sample_peds_dists,
        per_subject_stats=per_subject_stats,
        global_stats=global_stats
    ),
    use.UsageOutputNames(
        visualization='peds-stats-heatmap',

    )
)
```
TODO: lil write up
### Proportional Persistence of Recipient Strains(PPRS)
```{usage}
sample_pprs_dists, = use.action(
        use.UsageAction('fmt', 'sample_pprs'),
        use.UsageInputs(
            table=core_metrics_results.rarefied_table,
            metadata=sample_metadata,
            time_column='timepoints',
            baseline_timepoint='0',
            filter_missing_references=True,
            subject_column='PatientID', 
            drop_incomplete_timepoints = ["2","5","6"],
            drop_incomplete_subjects=True
        ),
        use.UsageOutputNames(
            pprs_dists='sample_pprs_dist'
        )

    )
```
TODO: lil write up 
## Donated Microbiome Indicator Features

Another method that researchers commonly use to assess engraftment is donated microbiome indicator features

Currently, we do this by running ANCOMBC comparing the recipient at baseline to their donor. However because ancombc can not be run on dependent samples (i.e. a patient over time), we are not able to compare the baseline to their donor. 

(This review)[https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8436969/] reported that the class of *Clostridia* is correlated with positive health outcomes.
So here I am going to use q2-longitudinal to track the relative abunadnce of *Clostridia* over time. This will help us identify if the donated microbiome had the previously reported feature and if the recipients recieve this feature.

```{usage}

taxonomy_url = 'https://qiime2-workshops.s3.us-west-2.amazonaws.com/itn-aug2024/taxonomy.qza'

taxonomy = use.init_artifact_from_url('taxonomy', taxonomy_url)
```
Lets use this Taxonomy to collapse our table at level three or Class. 

```{usage}
collapsed3_table,  = use.action(
    use.UsageAction('taxa', 'collapse'),
    use.UsageInputs(
        table=autofmt_table,
        taxonomy=taxonomy,
        level=3
    ),
    use.UsageOutputNames(
        collapsed_table='collapsed3-table.qza'
    )
)
```

Let's transform this feature-table into relative frequency feature table. This will allow us to look at relative frequency instead of raw counts that can be misleading. 

```{usage}
collapsed3_table_rf,  = use.action(
    use.UsageAction('feature_table', 'relative_frequency'),
    use.UsageInputs(
        table=collapsed3_table
    ),
    use.UsageOutputNames(
        relative_frequency_table='collapsed3-table-rf.qza'
    )
)
```
Now we are ready to use `q2-longitudinal` to track our previously identified feature

### Tracking Features with `q2-longitudinal`

```{usage}
md_collapsed3_table_rf= use.view_as_metadata(
    'md_collapsed3_table_rf',
     collapsed3_table_rf)

merged_collaped3_rf = use.merge_metadata(
    'merged_collaped3_rf',
    sample_metadata,
    md_collapsed3_table_rf)

use.action(
    use.UsageAction('longitudinal', 'linear_mixed_effects'),
    use.UsageInputs(metadata=merged_collaped3_rf,
                    state_column='day-relative-to-fmt',
                    group_columns='autoFmtGroup',
                    individual_id_column='PatientID',
                    metric='k__Bacteria;p__Firmicutes;c__Clostridia'),
    use.UsageOutputNames(visualization='lme-clostridia-treatmentVScontrol')
)
```
TODO: lil write up

### Feature Engraftment

Feature engraftment doesn't "assess engraftment" of a recipient but instead investigates if there are features that engraft across all subjects. This will help researchers understand which features are sucessfully engrafting and helping them decide which successfully engrafted features correlate with postive clinical outcome. 

This could be utilized to help researchers decide on specified communities to donate (as opposed the black-box commmunity approach we have currently). This specified communities would be full of microbes that have successfully engraftment accross patients and are associated with postive clincal outcomes.

Let's take a look now and see if we have any features that are sucessfully engrafting accross subjects.

```{usage}
feature_peds_dist, = use.action(
    use.UsageAction('fmt', 'feature_peds'),
    use.UsageInputs(
        table=core_metrics_results.rarefied_table,
        metadata=sample_metadata,
        time_column='timepoints',
        reference_column='DonorSampleID',
        subject_column='PatientID',
        filter_missing_references=True
    ),
    use.UsageOutputNames(
        peds_dists='feature_peds_dist'
    )

)
```
And again, Visualize the data using `qiime fmt heatmap`. 

```{usage}
use.action(
    use.UsageAction('fmt', 'heatmap'),
    use.UsageInputs(
        data=feature_peds_dist,
    ),
    use.UsageOutputNames(
        visualization='feature-heatmap',

    )
)

```
TODO: lil write up 

