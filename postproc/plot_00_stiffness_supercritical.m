%% Plot stiffness profiles

% Cristina Riso
% criso@gatech.edu

clearvars
close all
clc

% define linear stiffness (Nm/rad)
k1 = 0.4;

% define stiffness cases
k3 = 10.0;

% top level plot folder - update accordingly
plot_folder = '';


%% Plot parameters

% flag to put legend
legend_on = true;

% label font size
font_size = 28;

% bounds
theta_min = -10.0; theta_max = 10.0; M_min = -0.15; M_max = 0.15;

% angle range
theta = deg2rad(theta_min:0.01:theta_max);

% number of thicks
n_ticks_theta = 4; n_ticks_y = 6;

% flat to save plot
save_plots = false;

% plot format
plot_format = 'pdf';


%% Plot restoring elastic moment
    
% open figure
fig = figure(1); set(fig,'Position',[0 0 1200 900]); hold all;

xlabel('Pitch angle (deg)'); ylabel('Pitch restoring elastic moment (Nm)');
axis([theta_min theta_max M_min M_max]); ax = gca; ax.FontSize = font_size;
xticks(theta_min:(theta_max-theta_min)/n_ticks_theta:theta_max);
yticks(M_min:(M_max-M_min)/n_ticks_y:M_max);
    
% linear and nonlinear restoring elastic moment
M_l = k1*theta; M_nl = k1*theta+k3*theta.^3;
        
% plot linear and nonlinear restoring elastic moments
plot(rad2deg(theta),M_l,'k-','LineWidth',2,'DisplayName','Linear');
plot(rad2deg(theta),M_nl,'k--','LineWidth',2,'DisplayName',strcat('{\it K_{2\theta}}',sprintf(' = %1.1f Nm/rad^3',k3)));

% legend
if (legend_on == true)
    hleg = legend('show'); set(hleg,'Location','NorthWest');
end
    
% save plot
if save_plots == true
    
    filename = strcat(plot_folder,'\moment.',plot_format);
    
    set(fig,'Units','Inches'); pos = get(fig,'Position');
    set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
    print(fig,filename,strcat('-d',plot_format),'-r250');
    
end