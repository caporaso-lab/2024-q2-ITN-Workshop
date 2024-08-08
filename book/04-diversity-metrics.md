# Computing diversity metrics

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

The next step that we'll work through is computing a series of common diversity
metrics on our feature table. We'll do this using the `q2-diversity` plugin's
`core-metrics-phylogenetic` action. This action is another QIIME 2 pipeline,
this time combining over ten different actions into a single action.

## Core phylogenetic diversity metrics

`core-metrics-phylogenetic` requires your feature table, your rooted
phylogenetic tree, and your sample metadata as input. It additionally requires
that you provide the sampling depth that this analysis will be performed at.
Determining what value to provide for this parameter is often one of the most
confusing steps of an analysis for users, and we therefore have devoted
time to discussing this in the lectures and in the previous chapter. In the
interest of retaining as many of the samples as possible, we'll set our
sampling depth to 10,000 for this analysis.

```{usage}
core_metrics_results = use.action(
    use.UsageAction(plugin_id='diversity', action_id='core_metrics_phylogenetic'),
    use.UsageInputs(phylogeny=rooted_tree, table=autofmt_table,
                    sampling_depth=10000, metadata=sample_metadata),
    use.UsageOutputNames(rarefied_table='rarefied_table',
                            faith_pd_vector='faith_pd_vector',
                            observed_features_vector='observed_features_vector',
                            shannon_vector='shannon_vector',
                            evenness_vector='evenness_vector',
                            unweighted_unifrac_distance_matrix='unweighted_unifrac_distance_matrix',
                            weighted_unifrac_distance_matrix='weighted_unifrac_distance_matrix',
                            jaccard_distance_matrix='jaccard_distance_matrix',
                            bray_curtis_distance_matrix='bray_curtis_distance_matrix',
                            unweighted_unifrac_pcoa_results='unweighted_unifrac_pcoa_results',
                            weighted_unifrac_pcoa_results='weighted_unifrac_pcoa_results',
                            jaccard_pcoa_results='jaccard_pcoa_results',
                            bray_curtis_pcoa_results='bray_curtis_pcoa_results',
                            unweighted_unifrac_emperor='unweighted_unifrac_emperor',
                            weighted_unifrac_emperor='weighted_unifrac_emperor',
                            jaccard_emperor='jaccard_emperor',
                            bray_curtis_emperor='bray_curtis_emperor'),
)
```

As you can see, this command generates many outputs including both QIIME 2
artifacts and visualizations. You can take a look at the visualizations that are
generated now. 

## Longitudinal alpha diversity analysis

In this section of the tutorial we'll perform several analyses using QIIME 2's
`q2-longitudinal` {cite:p}`bokulich-q2long-2018` plugin. These will allow us
to track microbiome changes across time on a per-subject basis. 

this next command will allow us to ask a more targeted question:
Did an FMT treatment help individuals recover alpha diversity.

By adding the ``autoFmtGroup`` to our linear model, we can see if there
are different slopes for the two groups, based on an *interaction term*.


```{usage}
md_observed_features = use.view_as_metadata(
    'md_observed_features',
     core_metrics_results.observed_features_vector)

merged_observed_features = use.merge_metadata(
    'merged_observed_features',
    sample_metadata,
    md_observed_features)

use.action(
    use.UsageAction('longitudinal', 'linear_mixed_effects'),
    use.UsageInputs(metadata=merged_observed_features,
                    state_column='day-relative-to-fmt',
                    group_columns='autoFmtGroup',
                    individual_id_column='PatientID',
                    metric='observed_features'),
    use.UsageOutputNames(visualization='lme-obs-features-treatmentVScontrol')
)
```

Here we see that the ``autoFmtGroup`` is not on its own a significant predictor
of richness, but its interaction term with ``Q('day-relative-to-fmt')`` is.
This implies that there are different slopes between these groups, and we note
that given the coding of ``Q('day-relative-to-fmt'):autoFmtGroup[T.treatment]``
we have a positive coefficient which counteracts (to a degree) the negative
coefficient of ``Q('day-relative-to-fmt')``.

```{warning}
The slopes of the regression scatterplot in this visualization are not the
same fit as our mixed-effects model in the table. They are a naive OLS fit to
give a sense of the situation. A proper visualization would be a partial
regression plot which can condition on other terms to show some effect in
"isolation". This is not currently implemented in QIIME 2.
```
