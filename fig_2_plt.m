%% Load and initilize data 

% Load Results.mat 
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
dates = cell2mat({Output.date}.'); 




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

% ROTATION 
    hca = figure; 
    
        
    bins = 0:.1:180; 
    pdSix = fitdist(angB, 'Kernel','Kernel','epanechnikov');
    ySix = pdf(pdSix,bins);
    plot(bins,ySix,'k','LineWidth',2)
     %findpeaks( ySix,bins )
    ax = gca;
    xline(50,'--k','LineWidth',2)
    xlabel('Angular change \Delta \phi [\circ]')
    ylabel('Probability density')

    set(gca, 'LineWidth',1)

     set(gca,'xtick',[0,10 , 30 , 50, 70, 90, 110, 130, 150, 170])
     xlim([-0.1, 180]);
