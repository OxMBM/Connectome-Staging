%% -----------------------------------------------------------------
%
% Oxford Mathematical Brain Modelling Group
%   Staging and model selection using braid surfaces for    
%   a Fisher-Kolmogorov-Petrovsky-Piskunov model
%
% Copyright (c) 2021 P. Putra, A. Goriely,
%  Mathematical Institute, Oxford University
%  Oxford, United Kingdom
%
%
%  Authors:
%                Putra, Prama                 - prama.putra@maths.ox.ac.uk
%                Alain Goriely                - goriely@maths.ox.ac.uk
%
% All rights reserved.
%
% Distribution
% This code is distributed under the GNU GPL V3 License
% https://www.gnu.org/licenses/gpl-3.0.html
%
% Copyright End
%% -----------------------------------------------------------------
close all; clear all; clc;

% -----------------------------------------------------------------
% Select your operating system
% -----------------------------------------------------------------
%   1. Windows
%   2. Unix-like (MacOS, Linux, etc)
%
costype = 2;

% -----------------------------------------------------------------
% Select connectome source directory
%   (it is suggested that you do not modify this option and instead 
%       copy your PIT connectome files to the 'active-connectome' 
%       directory included in the repository)
% -----------------------------------------------------------------
%
% Set the subdirectory name, within the source directory, from which the 
%   PIT connectome files will be read.  Do not include any forward or 
%   backward or backward slashes in this name.
%
%   Example: csource = 'active-connectome'
%
%   Will search for the PIT connectome data in the directory 
%   (Windows)   [path to]\Connectome-Staging\Source\active-connectome
%   (Unix-like) [path to]/Connectome-Staging/Source/active-connectome
csource = 'active-connectome'


% -----------------------------------------------------------------
% Select connectome size
% -----------------------------------------------------------------
% Scale 500 has 1015 nodes;
% Scale 250 has 463 nodes;
% Scale 125 has 234 nodes;
% Scale 60 has 129 nodes;
% Scale 33 has 83 nodes;
% Activate csize by deleting % symbol or activate comment;
% Deactivate csize by typing % symbol or deactivate comment;
%
csize = [500 1015];
% csize = [250 463];
% csize = [125 234];
% csize = [60 129];
% csize = [33 83];
%
% -----------------------------------------------------------------
% Select type of weight
% -----------------------------------------------------------------
% 1: diffusive weight (number of fibers per squared length of fibers);
% 2: ballistic weight (number of fibers per length of fibers);
% 3: length-free weight (length of fibers);
% Example: type cweight = 1 when using diffusive weighting scheme;
%
cweight = 1;

% -----------------------------------------------------------------
% Define diffusion coefficient
% -----------------------------------------------------------------
% dif is given as beta coefficient which is the ratio between diffusion and
% growth coefficients; dif can be defined as a range of very large numbers,
% however, the computation may take long running time;
dif = exp([-30:0.1:0]);

% -----------------------------------------------------------------
% Define range of time of evolution
% -----------------------------------------------------------------
% TIME variable is given as a range of the initial and end time of
% evolution; If TIME is defined as [a,b], the step size will be determined
% automatically by MATLAB; User can define the step size and needs to wrtie
% the code as [a:h:b], where h is the step size;
TIME = [0,100];

% -----------------------------------------------------------------
% Define Laplacian matrix and initial condition
% -----------------------------------------------------------------
% This function will generate the Laplacian matrix of a chosen connectome
% graph and automatically generate homogeneous initial condition at the entorhinal
% nodes with total initial concentration 5e-3, and zero elsewhere;
% INPUT  : csize, connectome size; csource, connectome source; cweight, connectome weight;
% OUTPUT : L, Laplacian matrix; u0, initial value vector; n, size of graph;
[L,u0,n] = connectomelaplacian(costype,csize,csource,cweight);

% -----------------------------------------------------------------
% FKPP plot of the smallest diffusion coefficient value
% -----------------------------------------------------------------
% This function will produce a plot of Braak regions biomarker evolution; 
% User will need to define a new end time if the plot shows unfinished
% evolution process; The braid surface needs the full evolution process
% since it gives arrival time computation between 1% and 99% thresholds;
% The user needs to justify whether the smallest diffusion coefficient has
% given finished evolution process within the defined TIME range;
% INPUT  : L, Laplacian matrix; u0, initial value vector; n, size of graph; 
%          TIME, a range of time; min(dif), the minimum of defined dif;
% OUTPUT : Plot of Braak regions' evolution;
%
fkppplot(L,u0,n,TIME,min(dif))
drawnow;
%
prompt = 'Do you want to continue (Yes type 1/No type 0)? ';
x = input(prompt); % Input of the prompt;
switch x
    case 0
        disp('done!') % The program will continue when the user types 1;
        return
    case 1
        pause(0.01);
    otherwise
        disp('please re-run the program again!') % The program will stop 
        % when the user types 0 and needs to re-define TIME variable and
        % re-run this program;
end
%
% -----------------------------------------------------------------
% Compute braid surface of seeding
% -----------------------------------------------------------------
% Function to produce sequence of braids of a chosen connectome graph;
% INPUT  : L, Laplacian matrix; u0, initial value vector; n, size of graph; 
%          TIME, a range of time; dif, defined dif range;
% OUTPUT : braid_conc, computed arrival time of Braak regions; braid_val:
% ordered computed arrival time of Braak regions; braid_ind, ordered
% indexes of Braak regions;
%
[braid_val,braid_ind,braid_conc] = fkppbraidsurface(L,u0,n,TIME,dif);
%
% -----------------------------------------------------------------
% Plot braid surface
% -----------------------------------------------------------------
% Function to produce the braid surface plot of a chosen connectome graph;
% INPUT  : braid_ind, ordered indexes of Braak regions; dif, defined dif range;
% OUTPUT : Plot of braid surface;
%
braidsurfaceplot(braid_ind,dif)
%
