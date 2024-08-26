# Computational infrastructure for this workshop

(choose-your-interface)=
## Choose your own interface

QIIME 2 is designed to work through diverse interfaces to enable users with different computational backgrounds to work through the interface that they'll be most efficient with {numref}`multiple-interfaces`.

```{figure} _images/multiple-interfaces.png
:name: multiple-interfaces

QIIME 2 is designed to provide the same functionality through different types of interfaces.
```

In this course you'll gain experience working with (a) QIIME 2 View, (b) Galaxy, and (c) q2cli, the QIIME 2 command line interface.
QIIME 2 additionally has a (d) Python 3 API, which you are free to experiment with in the Jupyter Notebook environment provided in the workshop container.

We'll start using Galaxy through the free public Galaxy server, https://cancer.usegalaxy.org.
As we generate results that we want to look at, we'll using [QIIME 2 View](https://view.qiime2.org).
We'll then spend the majority of the course interacting with QIIME 2 through its command line interface in a containerized environment that you'll run on your own computer.
Both of these will be available for your own work after the course, and you can feel free to switch back-and-forth between these (and the other interfaces) as is helpful for you.

At the top of each page in the tutorial, you'll see a box that allows you to select which interface you would like the instructions to be presented with {numref}`interface-dropdown`.

```{figure} ./_images/interface-dropdown.png
:name: interface-dropdown
:height: 150px

The interface selection box at the top of each page allows you to toggle which interface the commands are presented with.
```

(notebook-qzv-viewing)=
## Viewing QIIME 2 Visualizations in Jupyter Notebooks

If you don't have an Internet connection when you're working through the content of this book, you won't be able to use QIIME 2 View.
You can instead view the Visualizations using a Jupyter Notebook in this case.

To do this, open a new tab in Jupyter Lab and select the *Notebook* option toward the top-left.
To view a visualization called `feature-table.qzv`, you can run the following commands in the notebook:

```python
from qiime2 import Visualization
Visualization.load('./feature-table.qzv')
```

This assumes that the file, `feature-table.qzv`, is in the same directory as the notebook.
If that's not the case, adjust your filepath to reflect where it can be found, or move the notebook file to the same directory as the file you want to view.