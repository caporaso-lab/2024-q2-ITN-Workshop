# Exploring the Data
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
## Access the study metadata

To begin our work with QIIME 2 and the tutorial data we will
start by downloading the metadata, generating a summary of it, and exploring
that summary.

First, download the metadata.

```{usage}
md_url = 'https://qiime2-workshops.s3.us-west-2.amazonaws.com/itn-aug2024/sample-metadata-v3-q2-fmt.tsv'

def metadata_from_url(url):
    def factory():
        import tempfile
        import requests
        import qiime2
        import pandas as pd

        data = requests.get(url)

        with tempfile.NamedTemporaryFile() as f:
            f.write(data.content)
            f.flush()
            fmt_metadata = pd.read_csv(f.name, sep='\t').set_index('SampleID')
            # drop #q2:types from the metadata
            fmt_metadata = fmt_metadata.drop(['#q2:types'])
            result = qiime2.Metadata(fmt_metadata)

        return result
    return factory

sample_metadata = use.init_metadata('sample_metadata',
                                    metadata_from_url(md_url))

```


```{usage}
use.action(
    use.UsageAction(plugin_id='metadata', action_id='tabulate'),
    use.UsageInputs(input=sample_metadata),
    use.UsageOutputNames(visualization='metadata_summ_1')
)
```

We could download this file but that means we will have to filter 
otherwise we need to host the autofmt group feature table 
```{usage}

feature_table_url = 'https://data.qiime2.org/2024.5/tutorials/liao/full-feature-table.qza'

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

feature_table = use.init_artifact(
        'feature-table',
        artifact_from_url(feature_table_url))

```

```{usage}
autofmt_table, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_samples'),
    use.UsageInputs(table=feature_table, metadata=sample_metadata),
    use.UsageOutputNames(filtered_table='autofmt_table')
)
```

Filtering, if we don't host a filtered table. 

```{usage}
use.action(
    use.UsageAction(plugin_id='feature_table', action_id='summarize'),
    use.UsageInputs(table=autofmt_table, sample_metadata=sample_metadata),
    use.UsageOutputNames(visualization='autofmt_table_summ'),
)
```
