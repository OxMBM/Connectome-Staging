function [braid_val,braid_ind,braid_conc] = fkppbraidsurface(L,u0,n,TIME,dif)
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
% Function to produce sequence of braids of a chosen connectome graph;
% INPUT  : L, Laplacian matrix; u0, initial value vector; n, size of graph; 
%          TIME, a range of time; dif, defined dif range;
% OUTPUT : braid_conc, computed arrival time of Braak regions; braid_val:
% ordered computed arrival time of Braak regions; braid_ind, ordered
% indexes of Braak regions;

cf = pwd;
datreg = readmatrix([cf,'\brainregion.xlsx'],...
    'Sheet',[num2str(n),' nodes'],'Range','B3:E44');
canreg = [datreg(:,1:2); datreg(:,3:4)]; canreg(42,:) = [];
region = canreg([12 13 21:24 26 27 40 53 54 62:65 67 68 81]',:);
nreg = round(length(region)/2);
nd = length(dif);

tic
for i = 1:nd
[T,Y] = ode45(@fkpp,TIME,[u0'],[],dif(i),L,n);
j = 1;
        area1 = [Y(:,region(j,1):region(j,2)) Y(:,region(j+nreg,1):region(j+nreg,2)) Y(:,region(j+1,1):region(j+1,2)) Y(:,region(j+1+nreg,1):region(j+1+nreg,2))];
        MEAN_REGION(j,:) = mean(area1');
        MEAN_REGION(2,:) = NaN;
j = 3;
        area2 = [Y(:,region(j,1):region(j,2)) Y(:,region(j+nreg,1):region(j+nreg,2)) ...
            Y(:,region(j+1,1):region(j+1,2)) Y(:,region(j+1+nreg,1):region(j+1+nreg,2)) ...
            Y(:,region(j+2,1):region(j+2,2)) Y(:,region(j+2+nreg,1):region(j+2+nreg,2)) ...
            Y(:,region(j+3,1):region(j+3,2)) Y(:,region(j+3+nreg,1):region(j+3+nreg,2))];
        MEAN_REGION(j,:) = mean(area2');
        MEAN_REGION(4,:) = NaN;
        MEAN_REGION(5,:) = NaN;
        MEAN_REGION(6,:) = NaN;
j = 7;
        MEAN_REGION(j,:) = mean([Y(:,region(j,1):region(j,2)) Y(:,region(j+nreg,1):region(j+nreg,2))]');
        MEAN_REGION(j+1,:) = mean([Y(:,region(j+1,1):region(j+1,2)) Y(:,region(j+1+nreg,1):region(j+1+nreg,2))]');
        MEAN_REGION(j+2,:) = mean([Y(:,region(j+2,1):region(j+2,2)) Y(:,region(j+2+nreg,1):region(j+2+nreg,2))]');
    
    MEAN_REGION([2 4:6],:) = [];
    braid_conc(:,:,i) = timerecordinterp(T,MEAN_REGION');
    clear MEAN_REGION T Y
end
toc

[braid_val,braid_ind] = sort(braid_conc,'ascend');
end