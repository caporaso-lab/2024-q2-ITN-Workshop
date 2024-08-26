(exploring-the-data-container)=
# Exploring the data through your container

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

## Navigating your files and folders

After [starting up your container](start-container), you're ready to start working with QIIME 2.

Take a look at the organization of the files and folders (or directories) in your container by running:

```shell
tree -L 1
```

When you're first starting, you should see output that looks like the following:

```shell
.
├── matplotlib
├── q2cli
└── workshop-input-data
```

Create a new directory for your work during this workshop:

```shell
mkdir 2024-workshop
```

If you run `tree` again, you should now see the new directory:

```shell
$ tree -L 1
.
├── 2024-workshop
├── matplotlib
├── q2cli
└── workshop-input-data
```

```{tip}
In this tutorial when you see commands displayed beginning with the `$` character, the `$` indicates your command prompt.
You should not type the `$` character - rather it's intended as an indicator that you should be entering a command, and to differentiate commands from the output they produce (which often follows, as in the preceding example).
```

Change into the directory you just created using the `cd` command:

```shell
cd 2024-workshop
```

At this point, you're ready to start working with QIIME 2.
Run the command `qiime info` to learn about the version of QIIME 2 that is installed.

## Access and summarize the study metadata and feature table

To illustrate the parallels between Galaxy and the command line interface, we'll carry out the same first two steps that we ran with Galaxy, but this time in our container.

Return to the [](access-metadata) and [](access-feature-table) sections of the tutorial.
However, before completing those steps, scroll to the top of that page and select *Command Line (q2cli)* in the interface selection box (see {numref}`interface-dropdown` for an illustration of this box).

## View the results

After completing the access and summarization steps in your container we'll view the resulting summaries.
Using the file browser on the left side of your Jupyter Lab window, download the file.
In your web browser, navigate to https://view.qiime2.org, and drag and drop the files you downloaded onto the file upload box (you'll need to do this in two different browser tabs).
The visualizations should load, and then should present the same results you saw from Galaxy.
(If you don't have an Internet connection, refer to [](notebook-qzv-viewing) to view your .qzv files.)

```{note}
Because different versions of QIIME 2 are installed on Galaxy and in your container environment, you may see slight differences in the visualizations relative to those you created using Galaxy.
Any differences should be inconsequential.
```


