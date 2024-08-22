# Exploring the Data
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
## Access the study metadata

To begin our work with QIIME 2 and the tutorial data we will
start by downloading the metadata, generating a summary, and exploring
that summary.

First, download the metadata.

```{usage}
md_url = 'https://qiime2-workshops.s3.us-west-2.amazonaws.com/itn-aug2024/sample-metadata-v3-q2-fmt.tsv'

def metadata_from_url(url):
    def factory():
        import tempfile
        import requests
        import qiime2
        #import pandas as pd

        data = requests.get(url)

        with tempfile.NamedTemporaryFile() as f:
            f.write(data.content)
            f.flush()
            result = qiime2.Metadata.load(f.name)
            return result
    return factory

sample_metadata = use.init_metadata('sample_metadata',
                                    metadata_from_url(md_url))

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

def artifact_from_url(url):
    def factory():
        import tempfile
        import requests
        import qiime2

        data = requests.get(url)

        with tempfile.NamedTemporaryFile() as f:
            f.write(data.content)
            f.flush()
            result = qiime2.Artifact.load(f.name)

        return result
    return factory

autofmt_table = use.init_artifact(
        'feature-table',
        artifact_from_url(feature_table_url))

```

```{usage}
use.action(
    use.UsageAction(plugin_id='feature_table', action_id='summarize'),
    use.UsageInputs(table=autofmt_table, sample_metadata=sample_metadata),
    use.UsageOutputNames(visualization='autofmt_table_summ'),
)
```
