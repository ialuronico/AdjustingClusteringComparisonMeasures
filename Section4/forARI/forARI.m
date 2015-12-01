clear all;
close all;
clc;
  
   
T1 = [17 0 0 0;
      0 17 0 0;
      0 0 17 0;
      8 8 8 25]
    
T2 = [20 2 1 1;
      2 20 2 1;
      1 1 20 1;
      2 2 2 22]
    
 qs= [(0.5:0.01:0.99) (1.01:0.01:3)];
 
 dispT1 = zeros(1,length(qs));
 dispT2 = zeros(1,length(qs));
 
 for i=1:length(qs)
   q = qs(i);
   %disp(q);
   dispT1(i) = computeAMIq(T1,q);
   dispT2(i) = computeAMIq(T2,q);
 end
 
h = figure;
plot(qs, dispT1, '-.');
hold all;
plot(qs, dispT2, '-');
xlabel('$q$','interpreter','latex');
ylabel('AMI$_q$','interpreter','latex');
leg = legend('AMI$_q(U_1,V)$','AMI$_q(U_2,V)$');
set(leg,'interpreter','latex','Location','SouthEast');
grid on;

set(h,'Position',[200 200 260 200]);
set(h,'PaperSize',[6.8 5.4],'PaperPositionMode','auto');
saveas(h,'forARI','pdf');
