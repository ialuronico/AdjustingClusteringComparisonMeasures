clear all;
close all;
clc;

% load experiments about 
% q = 1.001
% selBias1
% q = 2
% selBias2
% q = 3
% selBias3

load('selBias3');
h = figure;

subplot(3,1,1);
bar(rs,SVIqFreq/samples,'r');
hold on;
plot(rs,SVIqFreq/samples,'ko--','Linewidth',.5,'MarkerSize',4);
grid on;
ylabel('SMI$_q$','Interpreter','latex','FontSize',12);
title(['Probability of selection ($q = ' num2str(q) '$)'],'Interpreter','latex','FontSize',12);
ylim([0 max(SVIqFreq/samples)+0.01]);
xlim([rs(1)-1 rs(length(rs))+1]);


subplot(3,1,2);
bar(rs,AVIqFreq/samples,'c');
hold on;
plot(rs,AVIqFreq/samples,'kx--','Linewidth',.5,'MarkerSize',4);
grid on;
ylabel('AMI$_q$','Interpreter','latex','FontSize',12);
ylim([0 max(AVIqFreq/samples)+0.01]);
xlim([rs(1)-1 rs(length(rs))+1]);

subplot(3,1,3);
bar(rs, VIqFreq/samples,'g');
hold on;
plot(rs, VIqFreq/samples,'ks--','Linewidth',.5,'MarkerSize',4);
grid on;
ylabel('NMI$_q$','Interpreter','latex','FontSize',12);
ylim([0 max(VIqFreq/samples)+0.01]);
xlim([rs(1)-1 rs(length(rs))+1]);

xlabel('Number of sets $r$ in $U$','Interpreter','latex','FontSize',12);

set(h, 'Position', [150 150 820 275])
set(h,'PaperSize',[19.5 7.5],'PaperPositionMode','auto');
saveas(h,'selBias_color2','pdf');


