function [L,u0,n] = connectomelaplacian_fsl(costype,csize,csource,cweight)
%  ---------------------------------------------------
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
% -----------------------------------------------------------------
% This function will generate the Laplacian matrix of a chosen connectome
% graph and automatically generate homogeneous initial condition at the entorhinal
% nodes with total initial concentration 5e-3, and zero elsewhere;
% INPUT  : csize, connectome size; csource, connectome source; cweight, connectome weight;
% OUTPUT : L, Laplacian matrix; u0, initial value vector; n, size of graph;

switch csize(1)
    case 500
        loc = 1;
    case 250
        loc = 2;
    case 125
        loc = 3;
    case 60
        loc = 4;
    case 33
        loc = 5;
    otherwise
        disp('please input correct value')
end

switch cweight
    case 1
        weight = 'master-w2';
    case 2
        weight = 'master-w1';
    case 3
        weight = 'master-n';
    otherwise
        disp('please input correct value')
end

cf = pwd;


filenameoffice = ''

switch costype
    case 1
        filenameoffice = [cf,'\',csource,'\',weight,'.csv'];
    case 2
        filenameoffice = [cf,'/',csource,'/',weight,'.csv'];
end


M = csvread(filenameoffice);

k = sum(M'); n = csize(2);
L = M - diag(k);

%scale-500; 412,413: right entorhinal; 920,921: left entorhinal
%scale-33; 27: right entorhinal; 68: left entorhinal
seed_node = {[412 413 920 921], [184 416], [89 205], [46 110], [27 68]};
seed = 0.005/length(seed_node{loc});
u0 = zeros(n,1); u0(seed_node{loc}) = seed;
end