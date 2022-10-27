%% Load and initilize data 

% Load Results.m
dates = cell2mat({Output.date}.'); 


%clear *_cc

c1 = 'k'; 
c2 = 'r';
c3 = [0 0.5 0];
c4 = 'b';

V_pf_err = [Output.V_pf_err].'; 
ind_remove = V_pf_err >100; 

Output = Output(~ind_remove);
Ang = Ang(~ind_remove); 
BPar = BPar(~ind_remove); 
TShift = TShift(~ind_remove); 
dates = dates(~ind_remove,:); 


% prepare data
c_eval('temp_ang_B(:,?) =[Ang.Ang_B?]; ',1:4)
angB = mean(temp_ang_B,2); 



width = [Output.width];
V_pf = [Output.V_pf].'; 

V_t = [Output.V_t].'; 
V_t_err = [Output.V_t_sd].'; 

V_pf_err = [Output.V_pf_err].'; 

n_t = cell2mat({Output.n_t}.'); 
n_sw = cell2mat({Ang.n_sw}.'); 

v_sw = cell2mat({Output.Vsw}.');
dd = dot(n_sw,n_t,2); 

c_eval('Va_e_temp(?,:) = [BPar.Va?_e]; ',1:4)
Va_e = mean(Va_e_temp.',2,'omitnan'); 
c_eval('Va_i_temp(?,:) = [BPar.Va?_H]; ',[1,3])
Va_i = mean(Va_i_temp.',2,'omitnan'); 
clear Va_e_temp Va_i_temp
c_eval('Ni_temp(?,:) = [BPar.Ni?]; ',[1,3])
Ni = mean(Ni_temp.',2,'omitnan'); 
c_eval('Ne_temp(?,:) = [BPar.Ne?]; ',[1,3])
Ne = mean(Ne_temp.',2,'omitnan'); 
clear Va_e_temp Va_i_temp Ne_temp

Va_diff = Va_e-Va_i; 


% decompose Va 
ang_B_nt = [Ang.theta_B0nt_min]; 

% make all angles between 0 and 90. 
ang_90m = ang_B_nt(ang_B_nt<=90); 
ang_90p = ang_B_nt(ang_B_nt>90);
ang_90c = abs(ang_90p-180); 

theta_B_nt   =[ang_90m, ang_90c]; 

Va_comp = Va_e.*cosd(theta_B_nt); 

ind_lin = (angB < 50);
ind_rot = (angB >= 50); 

inside_lin = length(find(V_pf(ind_lin)< mean(Va_e(ind_lin),'omitnan') & V_pf(ind_lin)> -mean(Va_e(ind_lin),'omitnan')))/length(Va_e(ind_lin)) ;

inside_rot = length(find(V_pf((ind_rot))< mean(Va_e(ind_rot),'omitnan') & V_pf(ind_rot)> -mean(Va_e(ind_rot),'omitnan')))/length(Va_e(ind_rot)); 


%% PLOT


set(groot, ...
'DefaultFigureColor', 'w', ...
'DefaultAxesLineWidth', 0.5, ...
'DefaultAxesXColor', 'k', ...
'DefaultAxesYColor', 'k', ...
'DefaultAxesFontUnits', 'points', ...
'DefaultAxesFontSize', 17, ...
'DefaultAxesFontName', 'Arial', ...
'DefaultLineLineWidth', 1.1, ...
'DefaultTextFontUnits', 'Points', ...
'DefaultTextFontSize', 17, ...
'DefaultTextFontName', 'Arial', ...
'DefaultAxesBox', 'on', ...
'defaultAxesTickLabelInterpreter','tex', ...
'DefaultAxesTickDir', 'in', ...
'DefaultAxesTickDirMode', 'manual',...
'defaultLegendInterpreter','tex');
 
set(groot, 'DefaultAxesTickDir', 'in');
set(groot, 'DefaultAxesTickDirMode', 'manual');




figure('units','normalized','outerposition',[0 0 1 1]); 
subplot(2,2,1)


bins = -200:10:250; 
pdSix = fitdist(V_pf(ind_lin), 'Kernel','Kernel','epanechnikov');
ySix = pdf(pdSix,bins);
p1 =plot(bins,ySix,'k','LineWidth', 2); 
hold on 
p3 = errorbar(median(V_pf(ind_lin),'omitnan'),0.006,mean(V_pf_err(ind_lin)),'horizontal'); 

p4 = xline(mean(Va_e(ind_lin),'omitnan'),'b:','LineWidth',2);
p5 = xline(-mean(Va_e(ind_lin),'omitnan'),'b:','LineWidth',2); 
p6 = xline(mean(V_pf(ind_lin),'omitnan'),'r--','LineWidth',2); 
p7 = xline(median(V_pf(ind_lin),'omitnan'),'r','LineWidth',2);  


xlabel('V_{pf} (km/s)')
ylabel('Probability density')
set(gca, 'LineWidth',1)
title('Linear \Delta \phi < 50')
ylim('auto')

xlim([-200,250])


p1.Annotation.LegendInformation.IconDisplayStyle = 'off';
p5.Annotation.LegendInformation.IconDisplayStyle = 'off';
l6 = sprintf('Mean = %.0f km/s',mean(V_pf(ind_lin)));
l7 = sprintf('Median = %.1f km/s',median(V_pf(ind_lin)));
l3 = sprintf('Error = \x00B1 %.0f km/s',mean(V_pf_err(ind_lin)));
l4 = sprintf('Mean V_A = \x00B1 %.0f km/s',median(Va_e(ind_lin),'omitnan'));
legend([p7,p6,p3,p4],l7,l6,l3,l4 )


h = subplot(2,2,2)
bins = -200:10:250; 
pdSix = fitdist(V_pf(ind_rot), 'Kernel','Kernel','epanechnikov');
ySix = pdf(pdSix,bins);
p1 =plot(bins,ySix,'k','LineWidth', 2); 
hold on 
p3 = errorbar(median(V_pf(ind_rot),'omitnan'),0.004,mean(V_pf_err(ind_rot)),'horizontal'); 

p4 = xline(mean(Va_e(ind_rot),'omitnan'),'b:','LineWidth',2);
p5 = xline(-mean(Va_e(ind_rot),'omitnan'),'b:','LineWidth',2); 
p6 = xline(mean(V_pf(ind_rot),'omitnan'),'r--','LineWidth',2); 
p7 = xline(median(V_pf(ind_rot),'omitnan'),'r','LineWidth',2);  


%set(gca,'ytick',[0, 0.002, 0.003 ,0.004, 0.005,0.006, 0.007, 0.008])
ax = ancestor(h, 'axes');
ax.YAxis.Exponent = 0; 
xtickformat('%.0f')

xlabel('V_{pf} (km/s)')
ylabel('Probability denisty')
set(gca, 'LineWidth',1)
title('Rotational \Delta \phi \geq 50')
ylim('auto')
xlim([-200,250])



p1.Annotation.LegendInformation.IconDisplayStyle = 'off';
p5.Annotation.LegendInformation.IconDisplayStyle = 'off';
l6 = sprintf('Mean = %.0f km/s',mean(V_pf(ind_rot)));
l7 = sprintf('Median = %.0f km/s',median(V_pf(ind_rot)));
l3 = sprintf('Error = \x00B1 %.0f km/s',mean(V_pf_err(ind_rot)));
l4 = sprintf('Mean V_A = \x00B1 %.0f km/s',median(Va_e(ind_rot),'omitnan'));
legend([p7,p6,p3,p4],l7,l6,l3,l4 )


subplot(2,2,3)
bins = -3:.25:7; 
%histogram(Ang_Bmva(ind_lin),bins) 
pdSix = fitdist(V_pf(ind_lin)./Va_e(ind_lin), 'Kernel','Kernel','epanechnikov');
ySix = pdf(pdSix,bins);
p1 = plot(bins,ySix,'LineWidth',2,'color','k'); 
hold on

p3 = xline(1,'b:','LineWidth',2);
p4 =xline(-1,'b:','LineWidth',2); 
p1.Annotation.LegendInformation.IconDisplayStyle = 'off';
p3.Annotation.LegendInformation.IconDisplayStyle = 'off';
p4.Annotation.LegendInformation.IconDisplayStyle = 'on';
p5 = xline(median(V_pf(ind_lin)./Va_e(ind_lin),'omitnan'),'r','LineWidth',2); 
p6 = errorbar(median(V_pf(ind_lin)./Va_e(ind_lin),'omitnan'),0.23,median(V_pf_err(ind_lin))./median(Va_e(ind_lin),'omitnan'),'horizontal'); 
l5 = sprintf('Relaitve median =  %.2f',median(V_pf(ind_lin)./Va_e(ind_lin),'omitnan')); 
l6 = sprintf('Error =  \x00B1 %.2f ',median(V_pf_err(ind_lin))./median(Va_e(ind_lin),'omitnan'));
legend([p4,p5,p6], 'V_A',l5,l6); 


%title('Relative velocity relative to alfven velocity')
xlabel('V_{pf}/V_A')
ylabel('Probability denisty ')
ax = gca; 
xlim([-3, 7])
set(gca,'xtick',[-4, -3, -2 ,-1, 0, 1, 2, 3,4, 5, 6,7])

subplot(2,2,4)
bins = -3:.25:7;  
%histogram(Ang_BmVa_e(ind_lin),bins) 
pdSix = fitdist(V_pf(ind_rot)./Va_e(ind_rot), 'Kernel','Kernel','epanechnikov');
ySix = pdf(pdSix,bins);
p2 =plot(bins,ySix,'LineWidth',2,'color','k');
hold on 
p3 = xline(1,'b:','LineWidth',2);
p4 =xline(-1,'b:','LineWidth',2); 
p5 = xline(median(V_pf(ind_rot)./Va_e(ind_rot),'omitnan'),'r','LineWidth',2); 
p6 = errorbar(median(V_pf(ind_rot)./Va_e(ind_rot),'omitnan'),0.23,median(V_pf_err(ind_rot))./median(Va_e(ind_rot),'omitnan'),'horizontal'); 

p2.Annotation.LegendInformation.IconDisplayStyle = 'off'; 
p3.Annotation.LegendInformation.IconDisplayStyle = 'off';
p4.Annotation.LegendInformation.IconDisplayStyle = 'on';
l5 = sprintf('Relaitve median =  %.2f',median(V_pf(ind_rot)./Va_e(ind_rot),'omitnan')); 
l6 = sprintf('Error =  \x00B1 %.2f ',median(V_pf_err(ind_rot))./median(Va_e(ind_rot),'omitnan'));
legend([p4,p5,p6], 'V_A',l5,l6); 
%title('Relative velocity relative to alfven velocity')
xlabel('V_{pf}/V_A')
ylabel('Probability density')
ax = gca; 
xlim([-3, 7])
set(gca,'xtick',[-4, -3, -2 ,-1, 0, 1, 2, 3,4, 5, 6,7])

