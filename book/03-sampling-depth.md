# Selecting an Even Sampling Depth

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

## Rarefying, rarefaction, and q2-boots

A first step in analyzing our microbiome feature table is to choose an "even sampling depth", or the number of sequences that we should select at random from each of our samples to ensure that all samples are sequenced at equivalent depth or with equivalent effort.
This processes is referred to as rarefying our feature table.
Rarefying feature tables, or sampling them to a user-specified sampling depth and discarding samples with a total frequency that is less than the sampling depth, is a bit of a controversial topic because it throws away some of the data that was collected and is subject to biases as a result.
*Rarefaction* differs in a subtle way from rarefying, in that it involves repeat sampling from the input feature table to a user-specified sampling depth.
These concepts were recently discussed in {cite}`Schloss2024-aq`.
In this tutorial, for the sake of time, we are going to focus our diversity analyses on rarefying (i.e., a single iteration of random sampling).
To perform rarefaction-based diversity analysis with QIIME 2, refer to the [q2-boots](https://q2-boots.readthedocs.io/en/latest/) plugin {cite}`Raspet2024-om`.

## Selecting an even sampling depth

To start our diversity analyses, we first need to determine what even sampling depth (or "rarefaction depth") we want to select for computing our diversity metrics.
Because most diversity metrics are sensitive to different sampling depths across different samples, it is common to randomly subsample the counts from each sample to a specific value.
For example, if you define your sampling depth as 500 sequences per sample, the counts in each sample will be subsampled without replacement so that each sample in the resulting table has a total count of 500.
If the total count for any sample(s) are smaller than this value, those samples will be dropped from the downstream analyses. Choosing this value is tricky.
We recommend making your choice by reviewing the information presented in the feature table summary file.
Choose a value that is as high as possible (so you retain more sequences per sample) while excluding as few samples as possible.

Open up the feature table summary that you previously created with either Galaxy or in your QIIME 2 container and we'll discuss this as a group.

## Alpha rarefaction plots

After choosing an even sampling depth, it's helpful to see if your diversity metrics appear stable at that depth of coverage.
You can do this for alpha diversity using an alpha rarefaction plot.

```{usage}
use.action(
    use.UsageAction(plugin_id='diversity', action_id='alpha_rarefaction'),
    use.UsageInputs(table=autofmt_table, metrics={'observed_features'},
                    metadata=sample_metadata, max_depth=33000),
    use.UsageOutputNames(visualization='obs-features-alpha-rarefaction'))
```


