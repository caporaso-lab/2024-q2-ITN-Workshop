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

## Wrapping up: What did you do over the course of this workshop?

We're now getting close to the end of our analysis.
Over the course of the tutorial we've taken many steps with our data using QIIME 2, and if we were writing this work up for publication it would be essential to accurately describe the steps that we applied, the order in which we applied them, and the parameters that were used for each.

QIIME 2 makes this easy by recording the provenance of your data.

(provenance-exercise)=
```{note}

Without referring back to the earlier sections of the tutorial, but rather using your memory or information from the results that you've generated, describe the steps that were applied to the feature table and the order that we applied them.
Additionally, provide information on where we set parameter values such as the even sampling depth that was used in our diversity analyses.
```

(provenance-exercise-solution)=
````{admonition} Solution
:class: dropdown, note

This information is contained in the provenance of the artifacts (`.qza` files) and visualizations (`.qzv` files) that were generated in this tutorial.
To get a comprehensive view of the analyses that we ran, you can load one of the most recent visualizations that were created (e.g., a raincloud plot from the last section of the tutorial) with [QIIME 2 View](https://view.qiime2.org).
Then, click the Provenance tab in QIIME 2 View to review the steps that led to that particular visualization.

A more comprehensive provenance script can be generated for all of the artifacts created during our analysis using following command:

```shell
qiime tools replay-supplement \
 --recurse \
 --in-fp 2024-workshop \
 --out-fp 2024-workshop-provenance-replay.zip
```

Run this command from the top-level directory of your Jupyter Lab environment (you can get there by running `cd` with no additional parameters).
The resulting documents can serve as notes that you can use to refer back to what you did here.

```{note}
In this tutorial, we started with the feature table, sequences, and metadata
provided by the authors. This leads to a more abbreviated provenance than
is typical with an analysis using sequences recieved from a sequencer.
```
````

