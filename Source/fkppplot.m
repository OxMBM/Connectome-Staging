function fkppplot(L,u0,n,TIME,dif)
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
% This function will produce a plot of Braak regions biomarker evolution; 
% User will need to define a new end time if the plot shows unfinished
% evolution process; The braid surface needs the full evolution process
% since it gives arrival time computation between 1% and 99% thresholds;
% The user needs to justify whether the smallest diffusion coefficient has
% given finished evolution process within the defined TIME range;
% INPUT  : L, Laplacian matrix; u0, initial value vector; n, size of graph; 
%          TIME, a range of time; dif, defined dif coefficient;
% OUTPUT : Plot of Braak regions' evolution;

cf = pwd;
datreg = readmatrix([cf,'\brainregion.xlsx'],...
    'Sheet',[num2str(n),' nodes'],'Range','B3:E44');
canreg = [datreg(:,1:2); datreg(:,3:4)]; canreg(42,:) = [];
region = canreg([12 13 21:24 26 27 40 53 54 62:65 67 68 81]',:);
nreg = round(length(region)/2);

[T,Y] = ode45(@fkpp,TIME,[u0'],[],min(dif),L,n);
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

figure;
hold on
plot(T,MEAN_REGION(4,:)','Color',[0.4940, 0.1840, 0.5560],'LineWidth',2)
plot(T,MEAN_REGION(5,:)','Color',[0.4660, 0.6740, 0.1880],'LineWidth',2)
plot(T,MEAN_REGION(3,:)','Color',[0.9290, 0.6940, 0.1250],'LineWidth',2)
plot(T,MEAN_REGION(1,:)','Color',[0, 0.4470, 0.7410],'LineWidth',2)
plot(T,MEAN_REGION(2,:)','Color',[0.8500, 0.3250, 0.0980],'LineWidth',2)
xlabel('time')
ylabel('biomarker abnomality [%]')
timestep = max(TIME)/10;
set(gca,'xtick',[0:timestep:max(TIME)],'ytick',[0:0.2:1],'yticklabel',[0:20:100],'fontweight','bold')
legend('Braak I','Braak II','Braak III',...
    'Braak IV','Braak V','Location','southeast')
% axis tight
xlim([0,max(TIME)])
ylim([0,1])
box on
lgd = legend('boxoff');
end