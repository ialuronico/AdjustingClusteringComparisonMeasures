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
hold on;
plot(rs,SVIqFreq/samples,'bo-','Linewidth',1);
grid on;
ylabel('SMI$_q$','Interpreter','latex','FontSize',12);
title(['Probability of selection ($q = ' num2str(q) '$)'],'Interpreter','latex','FontSize',12);
ylim([0 max(SVIqFreq/samples)+0.01]);

subplot(3,1,2);
hold on;
plot(rs,AVIqFreq/samples,'bx-','Linewidth',1);
grid on;
ylabel('AMI$_q$','Interpreter','latex','FontSize',12);
ylim([0 max(AVIqFreq/samples)+0.01]);

subplot(3,1,3);
hold on;
plot(rs, VIqFreq/samples,'bs-','Linewidth',1);
grid on;
ylabel('NMI$_q$','Interpreter','latex','FontSize',12);
ylim([0 max(VIqFreq/samples)+0.01]);

xlabel('Number of sets $r$ in $U$','Interpreter','latex','FontSize',12);

set(h,'Position',[200 200 280 260]);
set(h,'PaperSize',[7.4 7],'PaperPositionMode','auto');
saveas(h,'selBias','pdf');


