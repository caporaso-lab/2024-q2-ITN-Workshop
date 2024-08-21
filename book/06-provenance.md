# Provenance in QIIME 2

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

## Wrapping up: What did you do three days ago?

```{exercise}
:label: q1

We're now getting close to the end of our analysis. Over the course of the
tutorial we've taken many steps with our data using QIIME 2, and if
we were writing this work up for publication it would be essential to
accurately describe the steps that we applied, the order in which we
applied them, and the parameters that were used for each.

Without referring back to the earlier sections of the tutorial, but rather
using your memory or information from the results that you've generated,
describe all the steps that were applied to the feature table and in the
order that we applied them as well as the even sampling depth that you chose your analysis.
```

```{solution} q1
:label: q1-solution
:class: dropdown

This information is contained in the provenance of the artifacts
(`.qza` files) and visualizations (`.qzv` files) that were generated in this
tutorial. To get a comprehensive view of the analyses that we ran, you can load
one of the most recent visualizations that were created (e.g., a volatility or
feature volatility
plot from the last section of the tutorial) with QIIME 2 View, and then click
the Provenance tab in QIIME 2 View to review the steps that led to that
particular visualization.

A more comprehensive provenance script can be generated for all of the artifacts
 created during our analysis using following command:

```shell
qiime tools replay-provenance \
 --in-fp 2024-workshop \
 --out-fp 2024-workshop/workshop-provenance-replay
```

```{note}
In this tutorial, we started with the feature table, sequences, and metadata 
provided by the authors. This leads to a more abbreviated provenance than 
is typical with an analysis using sequences recieved from a sequencer.
```

Thankfully QIIME 2's data provenance tracking
system keeps track of it all for us in case we forget.
