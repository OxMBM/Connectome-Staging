function braidsurfaceplot(braid_ind,dif)
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
% Function to produce the braid surface plot of a chosen connectome graph;
% INPUT  : braid_ind, ordered indexes of Braak regions; dif, defined dif range;
% OUTPUT : Plot of braid surface;

nd = length(dif);

braak1 = [4; 5; 3; 1; 2];
braak2 = [4; 5; 3; 2; 1];
add3 = [4; 3; 5; 1; 2];
add4 = [4; 3; 5; 2; 1];
add5 = [4; 3; 2; 5; 1];
add6 = [4; 3; 2; 1; 5];
add7 = [4; 3; 1; 2; 5];
add8 = [4; 3; 1; 5; 2];
add9 = [4; 1; 5; 3; 2];
add10 = [4; 1; 3; 5; 2];
add11 = [4; 1; 2; 3; 5];
add12 = [4; 1; 3; 2; 5];
add13 = [4; 2; 3; 1; 5];

add14 = 1;
add15 = 2;
add16 = 3;
add17 = 5;

iden1 = braid_ind - repmat(braak1,1,size(braid_ind,2),nd);
iden2 = braid_ind - repmat(braak2,1,size(braid_ind,2),nd);
iden3 = braid_ind - repmat(add3,1,size(braid_ind,2),nd);
iden4 = braid_ind - repmat(add4,1,size(braid_ind,2),nd);
iden5 = braid_ind - repmat(add5,1,size(braid_ind,2),nd);
iden6 = braid_ind - repmat(add6,1,size(braid_ind,2),nd);
iden7 = braid_ind - repmat(add7,1,size(braid_ind,2),nd);
iden8 = braid_ind - repmat(add8,1,size(braid_ind,2),nd);
iden9 = braid_ind - repmat(add9,1,size(braid_ind,2),nd);
iden10 = braid_ind - repmat(add10,1,size(braid_ind,2),nd);
iden11 = braid_ind - repmat(add11,1,size(braid_ind,2),nd);
iden12 = braid_ind - repmat(add12,1,size(braid_ind,2),nd);
iden13 = braid_ind - repmat(add13,1,size(braid_ind,2),nd);

iden14 = braid_ind(1,:,:) - repmat(add14,1,size(braid_ind,2),nd);
iden15 = braid_ind(1,:,:) - repmat(add15,1,size(braid_ind,2),nd);
iden16 = braid_ind(1,:,:) - repmat(add16,1,size(braid_ind,2),nd);
iden17 = braid_ind(1,:,:) - repmat(add17,1,size(braid_ind,2),nd);

resprod1 = prod(iden1==0); P1 = [];
resprod2 = prod(iden2==0); P2 = [];
resprod3 = prod(iden3==0); P3 = [];
resprod4 = prod(iden4==0); P4 = [];
resprod5 = prod(iden5==0); P5 = [];
resprod6 = prod(iden6==0); P6 = [];
resprod7 = prod(iden7==0); P7 = [];
resprod8 = prod(iden8==0); P8 = [];
resprod9 = prod(iden9==0); P9 = [];
resprod10 = prod(iden10==0); P10 = [];
resprod11 = prod(iden11==0); P11 = [];
resprod12 = prod(iden12==0); P12 = [];
resprod13 = prod(iden13==0); P13 = [];

resprod14 = (iden14==0); P14 = [];
resprod15 = (iden15==0); P15 = [];
resprod16 = (iden16==0); P16 = [];
resprod17 = (iden17==0); P17 = [];

for i = 1:nd
    P1(:,i) = dif(i)*resprod1(:,:,i)';
    P2(:,i) = dif(i)*resprod2(:,:,i)';
    P3(:,i) = dif(i)*resprod3(:,:,i)';
    P4(:,i) = dif(i)*resprod4(:,:,i)';
    P5(:,i) = dif(i)*resprod5(:,:,i)';
    P6(:,i) = dif(i)*resprod6(:,:,i)';
    P7(:,i) = dif(i)*resprod7(:,:,i)';
    P8(:,i) = dif(i)*resprod8(:,:,i)';
    P9(:,i) = dif(i)*resprod9(:,:,i)';
    P10(:,i) = dif(i)*resprod10(:,:,i)';
    P11(:,i) = dif(i)*resprod11(:,:,i)';
    P12(:,i) = dif(i)*resprod12(:,:,i)';
    P13(:,i) = dif(i)*resprod13(:,:,i)';
    
    P14(:,i) = dif(i)*resprod14(:,:,i)';
    P15(:,i) = dif(i)*resprod15(:,:,i)';
    P16(:,i) = dif(i)*resprod16(:,:,i)';
    P17(:,i) = dif(i)*resprod17(:,:,i)';
end
B = [1:99]';

figure;
hold on
plot(B,log(P1),'ys','MarkerFaceColor','y')
plot(B,log(P2),'bs','MarkerFaceColor','b')
plot(B,log(P3),'gs','MarkerFaceColor','g')
plot(B,log(P4),'rs','MarkerFaceColor','r')
plot(B,log(P5),'ms','MarkerFaceColor','m')
plot(B,log(P6),'cs','MarkerFaceColor','c')
plot(B,log(P7),'s','Color',[0, 0.75, 0.75],'MarkerFaceColor',[0, 0.75, 0.75])
plot(B,log(P8),'s','Color',[0.3010, 0.7450, 0.9330],'MarkerFaceColor',[0.3010, 0.7450, 0.9330])
plot(B,log(P9),'s','Color',[0, 0.5, 0],'MarkerFaceColor',[0, 0.5, 0])
plot(B,log(P10),'s','Color',[0.4660, 0.6740, 0.1880],'MarkerFaceColor',[0.4660, 0.6740, 0.1880])
plot(B,log(P11),'s','Color',[0.4940, 0.1840, 0.5560],'MarkerFaceColor',[0.4940, 0.1840, 0.5560])
plot(B,log(P12),'s','Color',[0.75, 0, 0.75],'MarkerFaceColor',[0.75, 0, 0.75])
plot(B,log(P13),'s','Color',[0.5, 0, 0.5],'MarkerFaceColor',[0.5, 0, 0.5])

plot(B,log(P14),'s','Color',[0.6350, 0.0780, 0.1840],'MarkerFaceColor',[0.6350, 0.0780, 0.1840])
plot(B,log(P15),'s','Color',[0.8500, 0.3250, 0.0980],'MarkerFaceColor',[0.8500, 0.3250, 0.0980])
plot(B,log(P16),'s','Color',[0.9290, 0.6940, 0.1250],'MarkerFaceColor',[0.9290, 0.6940, 0.1250])
plot(B,log(P17),'s','Color',[0.75, 0.75, 0],'MarkerFaceColor',[0.75, 0.75, 0])

xlim([-1 101])
ylim([min(log(dif))-0.3 max(log(dif))+0.3])
xlabel('biomarker abnormality [%]','fontweight','bold')
ylabel('log(\beta)','fontweight','bold')
set(gca,'xtick',[1 10:10:90 99],'fontweight','bold')
box on

end