%% Plot eigenvalue-based stability analysis

% Cristina Riso
% criso@gatech.edu

clearvars
close all
clc

% folder name (must contain results)
output_folder = '..\output_K3t10_K5t0_K3p10_K5p0';

% load results
load(strcat(output_folder,'\results.mat'),'results_sa'); results = results_sa; clear results_sa

% top level plot folder - update accordingly
plot_folder = '';


%% Plot parameters

% colors
c1 = [0.0000, 0.4470, 0.7410];
c2 = [0.8500, 0.3250, 0.0980];
c3 = [0.9290, 0.6940, 0.1250];
c4 = [0.4940, 0.1840, 0.5560];
c5 = [0.4660, 0.6740, 0.1880];
c6 = [0.4118, 0.4118, 0.4118];
c7 = [0.7451, 0.7451, 0.7451];
c8 = [236.0, 138.0, 95.0]/255.0;

% font size
font_size = 28;

% bounds
d_min = -15.0; d_max = 5.0; f_min = 0.0; f_max = 12.0;

% number of ticks
n_ticks_V = 4; n_ticks_d = 4; n_ticks_f = 4;

% markersize
ms = 6; 

% skip
skip = 2;

% flag to output results
save_plots = false;

% plot format
plot_format = 'pdf';


%% Extract stability analysis results

% get eigenvalues
roots = results.roots; roots_f = results.roots_f; 

% get control parameter range
V = results.V; V_f = results.V_f;


%% Plot root locus

fig1 = figure(1); set(fig1,'Position',[0 0 1200 900]); hold all;

% plot eigenvalues
plot(real(roots(1,1:skip:end)),imag(roots(1,1:skip:end))/2.0/pi,'o','MarkerFaceColor',c6,'MarkerEdgeColor',c6,'MarkerSize',ms); 
plot(real(roots(2,1:skip:end)),imag(roots(2,1:skip:end))/2.0/pi,'kv','MarkerFaceColor','k','MarkerFaceColor','k','MarkerSize',ms);

% plot flutter point
plot([0.0 0.0], [f_min, f_max],'k-');
plot(real(roots_f(1)),imag(roots_f(1))/2.0/pi,'o','MarkerFaceColor',c8,'MarkerEdgeColor',c8,'MarkerSize',ms+6,'LineWidth',2);
plot(real(roots_f(2)),imag(roots_f(2))/2.0/pi,'v','MarkerFaceColor',c2,'MarkerEdgeColor',c2,'MarkerSize',ms+6,'LineWidth',2);

% labels and ticks
xlabel('Damping (rad/s)'); ylabel('Frequency (Hz)'); 

% annotations
annotation(gcf,'textbox',[0.72 0.38 0.13 0.06],'String','Backward whirl','FontSize',28,'FontName','Arial','FitBoxToText','off','EdgeColor','None');
annotation(gcf,'textbox',[0.34 0.66 0.13 0.06],'String','Forward whirl','Color',c6,'FontSize',28,'FontName','Arial','FitBoxToText','off','EdgeColor','None');
axis([d_min d_max f_min f_max]); ax = gca; ax.FontSize = font_size;
xticks(d_min:(d_max-d_min)/n_ticks_d:d_max);
yticks(f_min:(f_max-f_min)/n_ticks_f:f_max);


%% Plot damping evolution

fig2 = figure(2); set(fig2,'Position',[0 0 1200 900]); hold all;

% plot damping values
plot(V(1:skip:end),real(roots(1,1:skip:end)),'o','MarkerFaceColor',c6,'MarkerEdgeColor',c6,'MarkerSize',ms);
plot(V(1:skip:end),real(roots(2,1:skip:end)),'kv','MarkerFaceColor','k','MarkerFaceColor','k','MarkerSize',ms);

% plot flutter point
plot([V_f V_f], [d_min d_max],'k-');
plot(V_f,real(roots_f(1)),'o','MarkerFaceColor',c8,'MarkerEdgeColor',c8,'MarkerSize',ms+6,'LineWidth',2);
plot(V_f,real(roots_f(2)),'v','MarkerFaceColor',c2,'MarkerEdgeColor',c2,'MarkerSize',ms+6,'LineWidth',2);

% labels and ticks
xlabel('Forward speed (m/s)'); ylabel('Damping (rad/s)'); 

% annotations
annotation(gcf,'textbox',[0.15 0.61 0.13 0.06],'String','Backward whirl','FontSize',28,'FontName','Arial','FitBoxToText','off','EdgeColor','None');
annotation(gcf,'textbox',[0.15 0.35 0.13 0.06],'String','Forward whirl','Color',c6,'FontSize',28,'FontName','Arial','FitBoxToText','off','EdgeColor','None');
axis([0.0 V(end) d_min d_max]); ax = gca; ax.FontSize = font_size;
xticks(0.0:(V(end)-0.0)/n_ticks_V:V(end));
yticks(d_min:(d_max-d_min)/n_ticks_d:d_max);


%% Plot frequency evolution

fig3 = figure(3); set(fig3,'Position',[0 0 1200 900]); hold all;

% plot frequencies
plot(V(1:skip:end),imag(roots(1,1:skip:end))/2.0/pi,'o','MarkerFaceColor',c6,'MarkerEdgeColor',c6,'MarkerSize',ms);
plot(V(1:skip:end),imag(roots(2,1:skip:end))/2.0/pi,'kv','MarkerFaceColor','k','MarkerFaceColor','k','MarkerSize',ms);

% plot flutter point
plot([V_f V_f], [f_min f_max],'k-');
plot(V_f,imag(roots_f(1))/2.0/pi,'o','MarkerFaceColor',c8,'MarkerEdgeColor',c8,'MarkerSize',ms+6,'LineWidth',2);
plot(V_f,imag(roots_f(2))/2.0/pi,'v','MarkerFaceColor',c2,'MarkerEdgeColor',c2,'MarkerSize',ms+6,'LineWidth',2);

% labels and ticks
xlabel('Forward speed (m/s)'); ylabel('Frequency (Hz)'); 

% annotations
annotation(gcf,'textbox',[0.15 0.43 0.13 0.06],'String','Backward whirl','FontSize',28,'FontName','Arial','FitBoxToText','off','EdgeColor','None');
annotation(gcf,'textbox',[0.15 0.82 0.13 0.06],'String','Forward whirl','Color',c6,'FontSize',28,'FontName','Arial','FitBoxToText','off','EdgeColor','None');
axis([0.0 V(end) f_min f_max]); ax = gca; ax.FontSize = font_size;
xticks(0.0:V(end)/n_ticks_V:V(end));
yticks(f_min:(f_max-f_min)/n_ticks_f:f_max);


%% Save plots

if save_plots == true
    
    for i = [1, 2, 3]
        
        switch i 
            case 1
                filename = strcat(plot_folder,'\roots.',plot_format); fig = fig1;
            case 2
                filename = strcat(plot_folder,'\damps.',plot_format); fig = fig2;
            case 3
                filename = strcat(plot_folder,'\freqs.',plot_format); fig = fig3;
        end
        
        % save figure 
        set(fig,'Units','Inches'); pos = get(fig,'Position');
        set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
        print(fig,filename,strcat('-d',plot_format),'-r250');
    
    end

end