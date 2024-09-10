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

The next step that we'll work through is computing a series of common diversity metrics on our feature table.
We'll do this using the `q2-diversity` plugin's `core-metrics` action.
This action is a QIIME 2 `Pipeline` which combines over ten different actions in a single command.

## Core diversity metrics

The `core-metrics` action requires your feature table and your sample metadata as input.
It additionally requires that you provide the sampling depth that this analysis will be performed at.
Determining what value to provide for this parameter is often one of the most confusing steps of an analysis.
Refer to the previous chapter for details.
Here we prioritize retaining samples and so we select a sampling depth of 10,000.

```{usage}
core_metrics_results = use.action(
    use.UsageAction(plugin_id='diversity', action_id='core_metrics'),
    use.UsageInputs(table=autofmt_table,
                    sampling_depth=10000, metadata=sample_metadata),
    use.UsageOutputNames(rarefied_table='rarefied_table',
                            observed_features_vector='observed_features_vector',
                            shannon_vector='shannon_vector',
                            evenness_vector='evenness_vector',
                            jaccard_distance_matrix='jaccard_distance_matrix',
                            bray_curtis_distance_matrix='bray_curtis_distance_matrix',
                            jaccard_pcoa_results='jaccard_pcoa_results',
                            bray_curtis_pcoa_results='bray_curtis_pcoa_results',
                            jaccard_emperor='jaccard_emperor',
                            bray_curtis_emperor='bray_curtis_emperor'),
)
```

As you can see, this command generates many outputs including both QIIME 2 artifacts and visualizations.
We'll work together on a guided exploration of these results.

## Longitudinal alpha diversity analysis

In this section of the tutorial we'll perform several analyses using QIIME 2's `q2-longitudinal` {cite:p}`bokulich-q2long-2018` plugin.
These will allow us to track microbiome changes across time on a per-subject basis, and specifically allow us to ask a more targeted question: *Did an FMT treatment help individuals recover alpha diversity?*

To address this question, we'll include the ``autoFmtGroup`` *interaction term* in our linear model through the `group-columns` parameter: this will let us test whether alpha diversity behaves differently for individuals in the two different groups.

```{tip}
Notice that for the input metadata we're including our typical sample metadata, but also an artifact that we previously computed.
A convenient feature of QIIME 2 is that some artifacts can be "viewed" as metadata.
In this case, since the "observed features" alpha diversity artifact contains alpha diversity values on a per-sample basis, it looks a lot like metadata.
We can use artifacts that can be viewed as metadata anywhere that we can use metadata.
```


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

Here we see that the ``autoFmtGroup`` is not on its own a significant predictor of richness, but its interaction term with ``Q('day-relative-to-fmt')`` is.
This implies that there are different slopes between these groups, and we note that given the coding of ``Q('day-relative-to-fmt'):autoFmtGroup[T.treatment]`` we have a positive coefficient which counteracts (to a degree) the negative coefficient of ``Q('day-relative-to-fmt')``.

```{warning}
The slopes of the regression scatterplot in this visualization are not the same fit as our mixed-effects model in the table.
They are a naive OLS fit to give a sense of the situation.
A proper visualization would be a partial regression plot which can condition on other terms to show some effect in "isolation".
This is not currently implemented in QIIME 2.
```
