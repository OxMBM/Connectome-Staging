function braid_conc = timerecordinterp(ts,sty)
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
% This function computes time interpolation of a given biomarker threshold;
% INPUT  : ts, time vector; sty, biomarker vector;
% OUTPUT : braid_conc, computed arrival time of Braak regions;

level = [0.01:0.01:0.99];
    for j = 1:length(level)
       [XU1,~,jx1] = unique(sty(:,1));
       YU1 = accumarray(jx1,ts',[],@min);
       [XU2,~,jx2] = unique(sty(:,2));
       YU2 = accumarray(jx2,ts',[],@min);
       [XU3,~,jx3] = unique(sty(:,3));
       YU3 = accumarray(jx3,ts',[],@min);
       [XU4,~,jx4] = unique(sty(:,4));
       YU4 = accumarray(jx4,ts',[],@min);
       [XU5,~,jx5] = unique(sty(:,5));
       YU5 = accumarray(jx5,ts',[],@min);
       braid_conc(:,j) = [interp1(XU1,YU1,level(j));
           interp1(XU2,YU2,level(j));
           interp1(XU3,YU3,level(j));
           interp1(XU4,YU4,level(j));
           interp1(XU5,YU5,level(j))];
    end
end