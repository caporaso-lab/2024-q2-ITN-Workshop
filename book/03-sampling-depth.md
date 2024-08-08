
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

As we begin performing more analyses of the samples in our feature table, an
important parameter that needs to be define is the even sampling (i.e.
rarefaction) depth that diversity metrics need to be computed at. Because most
diversity metrics are sensitive to different sampling depths across different
samples, it is common to randomly subsample the counts from each sample to a
specific value. For example, if you define your sampling depth as 500 sequences
per sample, the counts in each sample will be subsampled without replacement so
that each sample in the resulting table has a total count of 500. If the total
count for any sample(s) are smaller than this value, those samples will be
dropped from the downstream analyses. Choosing this value is tricky. We
recommend making your choice by reviewing the information presented in the
feature table summary file. Choose a value that is as high as possible (so you
retain more sequences per sample) while excluding as few samples as possible.

Lets revisit that feature table summary! 

## Alpha rarefaction plots

After choosing an even sampling depth, it's also helpful to see if your
diversity metrics appear to have stabilizes at that depth of coverage. You can
do this for alpha diversity using an alpha rarefaction plot.

```{usage}
use.action(
    use.UsageAction(plugin_id='diversity', action_id='alpha_rarefaction'),
    use.UsageInputs(table=autofmt_table, metrics={'shannon'},
                    metadata=sample_metadata, max_depth=33000),
    use.UsageOutputNames(visualization='shannon_rarefaction_plot'))
```
