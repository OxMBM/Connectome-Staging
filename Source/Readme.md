#  <div align = "center"> Oxford Mathematical Brain Modelling Group </div>
## <div align = "center"> Matlab source code: Staging and model selection using braid surfaces for a Fisher-Kolmogorov-Petrovsky-Piskunov model </div>
#### <div align = "center"> Copyright (c) 2021 P. Putra, A. Goriely, Mathematical Institute, Oxford University Oxford, United Kingdom </div>

#### <div align="center"> This code is distributed under the [GNU GPL V3 License](https://www.gnu.org/licenses/gpl-3.0.html) </div>
<br>

#### <div align="center"> Authors </div>
##### <div align="center"> Prama Putra prama.putra@maths.ox.ac.uk </div>
##### <div align="center"> Alain Goriely goriely@maths.ox.ac.uk </div>

<br><br>

The braid surface generation source code produces a braid surface plot for a Fisher-Kolmogorov-Petrovsky-Piskunov (FKPP) model evolving on an undirected human connectome brain graph in *csv* format. The FKPP solver uses built-in MATLAB functions, such as ode45, to solve the nonlinear ODE system.   

MATLAB Version Dependencies: requires R2020a or greater

#### Braid surface generation scripts and connectome types
The source code to produce braid surfaces falls into two categories:

1. The source files needed to produce braid surfaces for the PIT connectomes (generated using a deterministic tractography method)
2. The source files needed to produce braid surfaces for the FSL connectomes (generated using a probabilistic tractography method)

This division reflects the fact that there are differences between the PIT connectomes and the FSL connectomes.  These differences are small, in practice, but they do affect the dimensionality of graph Laplacian and the numerical indices of the various nodes; this latter detail has practical implications for specifying the initial conditions of the model as the global node numberings are different between the two connectome types.  

##### Preparing to generate a braid surface with a PIT deterministic connectome
The PIT connectomes are located in the directory `Connectome-Staging/Connectomes/PIT-deterministic`.  The steps to prepare for a braid surface generation using a PIT connectome is as follows:

1. Open the directory `Connectome-Staging/Connectomes/PIT-deterministic`.  Select a connectome scale by navigating to one of the directories `Scale-33`, `Scale-60`, `Scale-125`, `Scale-250` or `Scale-500`.
2. In this directory is a compressed file that contains the connectome files.  You will need to uncompress this file.  This can be done on Mac OS, or a Linux system, using the following terminal commands 

> $ gunzip scale33-compressed.tar.gz
>
> $ tar -xvf scale33-compressed.tar

You should substitute the name of the file you want to extract for `scale33-compressed.tar.gz`, above.  If you are using a Windows operating system, use a utility such as `Winzip` or `7-zip` to extract the contents of these files, instead.

3. The extracted *csv* files should now be present in the directory where you extracted the zipped file.  Copy these files to the directory `Connectome-Staging/Source/active-connectome`
4. Read about the PIT deterministic scripts and options in the next section.

##### Preparing to generate a braid surface with an FSL probabilistic connectome
The FSL connectomes are located in the directory `Connectome-Staging/Connectomes/FSL-probabilistic`.  The steps to prepare for a braid surface generation using a PIT connectome is as follows:

1. Open the directory `Connectome-Staging/Connectomes/FSL-deterministic`.  The first level of subdirectories determines the scale of the connectome you want to choose.  The options, here, are `Scale-33` and `Scale-500`.

2. Within each of the scale subdirectories is a tree of subdirectoreis reflecting the various thresholding methods used.  Choose a subdirectory from the following list and navigate there: 

|Subdirectory Abbreviation | Name of thresholding algorithm       |
|--------------------------|--------------------------------------|
|DF                        | Disparity Filtering                  |
|DS                        | Doubly Stochastic Disparity Filtering|
|HSS                       | High-Salience Skeletonization        |
|NC                        | Noise-Corrected Backboning           |
|NV                        | Naive Cutoff                         |

3. Inside each of the thresholding method subdirectories is a final subdirectory tree.  This time, the subdirectories are named according to a numeric value, such as `0.2` or `1.32` etc, reflecting the threshold value used to generate the connectome with the method determined by the parent directory name.  Navigate into the directory corresponding to the threshold value of your choice.
4. Inside this final directory is a compressed file containing the connectome *csv* files that we need in order to run the braid surface generation process.  If you are using Mac OS or Linux, the compressed files can be decompressed using the following commands.

> $ gunzip df-0.2-compressed.tar.gz
>
> $ tar -xvf df-0.2-compressed.tar

You should substitute the name of the specific compressed file, that you want to decompress, for the filename `df-0.2-compressed.tar.gz` given above.  If you are using a Windows operating system, use a utility such as `Winzip` or `7-zip` to extract the contents of these files, instead.

5. The extracted *csv* files should now be present in the directory where you extracted the zipped file.  Copy these files to the directory `Connectome-Staging/Source/active-connectome`.

6. Read about the FSL probabilistic scripts and options in the next section.

#### Generating a braid surface

In the previous section, we mentioned that the scripts for generating a braid surface differed based on which connectome type, e.g. PIT or FSL, you wanted to produce a braid surface for.  In this section, we discuss the specific scripts and script options in order to generate braid surfaces for both tau seeds and tau NFT staging on PIT and FSL connectomes.  

##### Braid surface Matlab scripts by connectome type
There are four main files for braid surface generation; two files for each type of connectome.  These files are

1. Generating a braid surface for a PIT connectome:
	1. main_fkpp_pit.m: This source file generates a braid surface for tau seed staging using a PIT deterministic connectome.
	2. main_damage_pit.m: This source file generates a braid surface for tau NFT staging using a PIT deterministic connectome
2. Generating a braid surface for an FSL connectome:
	1. main_fkpp_fsl.m: This source file generates a braid surface for tau seed staging using an FSL probabilistic connectome.
	2. main_damage_fsl.m: This source file generates a braid surface for tau NFT staging using an FSL probabilistic connectome.  

##### Script options
The scripts above contain various options that must be set, depending on the connectome that you have selected to produce a braid surface for.

1. costype: This option should be set to `1`, if you are using Matlab on a Windows operating system, or to `2` if you are using Matlab on a Unix-like operating system (Mac OS, Linux, etc).
2. csource: It is encouraged that you leave this option set to its default value of `active-connectome`.  This option indicates the subdirectory, of the `Connectome-Staging/Source` directory, where the script being run will look for the connectome files needed to generate a braid surface.  This is the directory into which you should copy your (PIT or FSL) connectome *csv* file data.
3. csize: This option indicates the scale (X) of the connectome and the number of nodes (Y) in the connectome as `csize = [X Y]`.  All of the valid choices are already present in the source files provided; you need only uncomment the case that coincides with the connectome that you are currently running and ensure that all other choices are commented out.  

> Example: A Scale-33 PIT connectome has been copied to the `active-connectome` directory.  In the file main_fkpp_pit.m (or main_damage_pit.m), the csize option should be set to `csize=[33 83]`

4. cweight: This option indicates the type of weighting matrix to use in the construction fo the graph Laplacian.  If `n` represents the number of fibers for a fiber bundle (edge) connecting two nodes and `l` represents the average length of the fiber bundle, then the relevant values are 
	1. `cweight=1` : diffusive weights `n/(l*l)`
	2. `cweight=2` : ballistic weights `n/l`
	3. `cweight=3` : length-free weights `n`


##### Solver options
There are also several options that determine aspects of the ODE system to be solved.  These are listed below.

1. dif: In the files main_fkpp_pit.m and main_fkpp_fsl.m, the `dif` option specifies an array which determines the bounds for the dynamics parameter, beta.  Beta represents the ratio of diffusion to growth in the model.  In the files main_damage_pit.m and main_damage_fsl.m, the `dif` option can be used in two different ways.  See the comments in these files for further instructions.

> Example (main_fkpp_pit.m or main_fkpp_fsl.m): dif = exp([-30:0.1:0]) means that a braid surface will be generated for log(beta) between -30 and 0.

2. TIME: The option `TIME` specifies the time interval on which the problem will be solved in order to generate the braid surface; for example, `TIME=[0,1000]`.  It is suggested that you use a time interval for which the system will reach a fully invaded state wherein all nodes are at their steady-state value; this ensures that all staging patterns can be resolved.

3. dam: The files main_damage_pit.m and main_damage_fsl.m also have a `dam` option.  This option works in the same way as the `dif` option.  This option can be set to an array or to a single value depending on the context of the braid surface you wish to generate. See the commented documentation in the script files for more information. 

