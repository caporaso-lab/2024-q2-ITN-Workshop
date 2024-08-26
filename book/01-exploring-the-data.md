(exploring-the-data)=
# Exploring the data with Galaxy
```{usage-scope}
---
name: tutorial
---
```

```{usage-selector}
---
default-interface: galaxy-usage
---
```

## Access Galaxy

We'll start working with QIIME 2 through the Galaxy graphical user interface.
This is a convenient way to use QIIME 2 as it's fully graphical - no command line or coding is needed!
However, as of now, Galaxy environments tend to have slightly older versions of QIIME 2 installed on them, and the installations are harder for you to customize (e.g., to install plugins you're interested in that aren't included in QIIME 2).
For this reason, in this workshop we're going to teach you how to use QIIME 2 both through Galaxy and on the command line.

To access the Galaxy server we'll be using for this class, go to https://cancer.usegalaxy.org.
You will need to create an account the first time you use this server.
This server is free to use, and you can feel free to continue using the account you create after the workshop has ended.

## Access the study metadata

To begin our work with QIIME 2 and the tutorial data we will
start by downloading the metadata, generating a summary, and exploring
that summary.

First, download the metadata.

```{usage}
md_url = 'https://qiime2-workshops.s3.us-west-2.amazonaws.com/itn-aug2024/sample-metadata-v3-q2-fmt.tsv'

sample_metadata = use.init_metadata_from_url('sample_metadata', md_url)
```

Next, we’ll get a view of the study metadata using QIIME 2. This will allow you to assess whether the metadata that QIIME 2 is using is as you expect. You can do this using the tabulate action in QIIME 2’s q2-metadata plugin as follows.

```{usage}
use.action(
    use.UsageAction(plugin_id='metadata', action_id='tabulate'),
    use.UsageInputs(input=sample_metadata),
    use.UsageOutputNames(visualization='metadata_summ_1')
)
```

## Summarize Feature Table

The feature table will describe the amplicon sequence variants (ASVs) observed in each sample, and how many times each ASV was observed in each sample. The feature data in this case is the sequence that defines each ASV.

In this tutorial, we're going to work specifically with samples that were
included in the autoFMT randomized trial.

Lets generate and explore a summary of the feature table we will be using.

```{usage}

feature_table_url = 'https://qiime2-workshops.s3.us-west-2.amazonaws.com/itn-aug2024/autofmt-table.qza'

autofmt_table = use.init_artifact_from_url('feature-table', feature_table_url)
```

```{usage}
use.action(
    use.UsageAction(plugin_id='feature_table', action_id='summarize'),
    use.UsageInputs(table=autofmt_table, sample_metadata=sample_metadata),
    use.UsageOutputNames(visualization='autofmt_table_summ'),
)
```
