#  <div align = "center"> Oxford Mathematical Brain Modelling Group </div>
## <div align = "center"> Computational connectomes and braid surface software </div>
#### <div align = "center"> <i>Braiding Braak and Braak: Staging patterns and model selection in network neurodegeneration</i> </div>
##### <div align = "center"> Copyright (c) 2021 P. Putra, P. Chaggar, T. Thompson and A. Goriely, Mathematical Institute, Oxford University Oxford, United Kingdom </div>

##### <div align="center"> All files are made available under the [GNU GPL V3 License](https://www.gnu.org/licenses/gpl-3.0.html) </div>
<br>

#### <div align="center"> Authors </div>
##### <div align="center"> Prama S. Putra prama.putra@maths.ox.ac.uk </div>
##### <div align="center"> Pavan Chaggar chaggar@maths.ox.ac.uk </div>
##### <div align="center"> Travis B. Thompson thompsont@maths.ox.ac.uk </div>
##### <div align="center"> Alain Goriely goriely@maths.ox.ac.uk </div>

# Connectome Staging
This repository contains the connectomes and the source code in support of the 
manuscript entitled *Braiding Braak and Braak: Staging patterns and model 
selection in network neurodegeneration*.

## Source Code
The source code included in this repository is written in Matlab and can be found in the subdirectory titled *Source*.  The code was written, and tested, in Matlab version R2015a and will work in other any backwards-compatible version.  Instructions for using the included source code can be found in the file *Source/Readme.md*.  

## Connectomes
The *Connectomes* subdirectory contains two subdirectories.  These 
subdirectories are named *PIT-deterministic* and *FSL-probabilistic*. The 
connectomes come in two primary file formats; a *graphml* format and *csv* 
format.  The *csv* formatted files are used by the Matlab scripts but the 
*graphml* format, which may be useful for other applications, is also 
included for posterity.  

There are several *csv* formatted files for each connectome.  These are as follows

1. **master-adj**.csv: Contains the binary adjacency matrix in CSV format.  This adjacency matrix could be used to construct the unweighted graph Laplacian for the connectome.  
2. **master-l.csv**: A weighted adjacency matrix whose *ij* entry is the length of the fiber bundle connecting node *i* to node *j*.
3. **master-n.csv**: A weighted adjacency matrix whose *ij* entry corresponds to the number of fibers in the bundle from node *i* and node *j*.  This adjacency matrix is used to construct the *length-free weighted* graph Laplacian referred to in the manuscript.
4. **master-w1.csv**: A weighted adjacency matrix whose *ij* entry corresponds to the number of fibers divided by the length for the fiber bundle from node *i* to node *j*.  This adjacency matrix is used to construct the *ballistic weighted* graph Laplacian referred to in the manuscript.
5. **master-w2.csv**: A weighted adjacency matrix whose *ij* entry corresponds to the number of fibers divided by the length squared for the fiber bundle from node *i* to node *j*.  This adjacency matrix is used to construct the *diffusive weighted* graph Laplacian referred to in the manuscript.   


### The PIT deterministic tractography connectomes
These connectomes were generated from the freely-available data of the PIT 
bioinformatics group.  Specifically, the dataset entitled *Full Set, 426 brains, 
20,000 streamlines* (available online through the 
[braingraph.org](https://braingraph.org/cms/download-pit-group-connectomes/) 
website) was used in their generation. These connectomes are saved in subdirectories named according to their respective scales.  For instance, the Scale-33 deterministic PIT connectome files are saved in *Connectomes/PIT-deterministic/Scale-33*.  

### The FSL probabilistic tractography connectomes
These connectomes were generated, by manuscript author P. Chaggar, using the FSL PROBTRACKX algorithm with 10,000 streamlines per voxel.  Human connectome project (HCP) patient data was used.  50 HCP patients were used to generate the Scale-33 connectome and 25 patients were used to generate the Scale-500 connectome.  The sparsity of raw FSL connectomes is quite low (approximately 7-12 percent). Thus, the raw connectomes were postprocessed by applying various thresholding techniques implemented in Professor Michele Coscia's [network backboning library](https://www.michelecoscia.com/?page_id=287).  Each connectome is stored in a subdirectory corresponding to the thresholding technique and the thresholding value.  The abbreviations for the techniques are listed in the table below.

|Subdirectory Abbreviation | Name of thresholding algorithm       |
|--------------------------|--------------------------------------|
|DF                        | Disparity Filtering                  |
|DS                        | Doubly Stochastic Disparity Filtering|
|HSS                       | High-Salience Skeletonization        |
|NC                        | Noise-Corrected Backboning           |
|NV                        | Naive Cutoff                         |

The directory *FLS-probabilistic/Scale-33/NC/2.32* therefore contains the files pertaining the the Noise-Corrected backboning thresholding method used at a threshold value of 2.32. 



