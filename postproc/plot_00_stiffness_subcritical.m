%% Plot stiffness profiles

% Cristina Riso
% criso@gatech.edu

clearvars
close all
clc

% define linear stiffness (Nm/rad)
k1 = 0.4;

% define stiffness cases
k3 = [-10.0, -7.5, -5.0, -2.5]; k5 = [350.0, 400.0, 450.0, 500.0];

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
theta = deg2rad(theta_min:0.5:theta_max);

% number of thicks
n_ticks_theta = 4; n_ticks_y = 6;

% flat to save plot
save_plots = false;

% plot format
plot_format = 'pdf';


%% Plot parametric bifurcation diagrams

for stiffness_case = [3, 5]
    
    % open figure
    fig = figure(stiffness_case); set(fig,'Position',[0 0 1200 900]); hold all;
    
    xlabel('Pitch angle (deg)'); ylabel('Pitch restoring elastic moment (Nm)');
    axis([theta_min theta_max M_min M_max]); ax = gca; ax.FontSize = font_size;
    xticks(theta_min:(theta_max-theta_min)/n_ticks_theta:theta_max);
    yticks(M_min:(M_max-M_min)/n_ticks_y:M_max);
    
    % select stiffness case
    switch stiffness_case
        case 3
            k = k3;
        case 5
            k = k5;
    end
    
    % linear restoring elastic moment
    M_linear = k1*theta;
    
    % plot linear restoring elastic moment
    plot(rad2deg(theta),M_linear,'k-','LineWidth',2,'DisplayName','Linear');
    
    % loop the stiffness cases
    for i = 1:length(k)
        
        % extract this stiffness case
        k_i = k(i);
        
        % restoring elastic moment
        switch stiffness_case 
            case 3
                M_i = k1*theta+k_i*theta.^3+k5(1)*theta.^5;
            case 5
                M_i = k1*theta+k3(i)*theta.^3+k_i*theta.^5;
        end
        
        % select line style
        switch i
            case 1
                ls = 'k--'; 
            case 2
                ls = 'k-.'; 
            case 3
                ls = 'k:'; 
            case 4
                ls = 'kx-'; 
        end
        
        % create legend lines
        switch stiffness_case
            case 3
                legend_line = strcat('{\it K_{2\theta}}',sprintf(' = %1.1f Nm/rad^3',k_i));
            case 5
                legend_line = strcat('{\it K_{4\theta}}',sprintf(' = %i Nm/rad^5',k_i));
        end
        
        % plot restoring elastic moment
        plot(rad2deg(theta),M_i,ls,'LineWidth',2,'DisplayName',legend_line);
        
        % legend
        if (legend_on == true)
            hleg = legend('show'); set(hleg,'Location','NorthWest');
        end
        
    end
    
    % save plot
    if save_plots == true
        
        switch stiffness_case
            case 3
                filename = strcat(plot_folder,'\moment_param_k3.',plot_format);
            case 5
                filename = strcat(plot_folder,'\moment_param_k5.',plot_format);
        end
        
        set(fig,'Units','Inches'); pos = get(fig,'Position');
        set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
        print(fig,filename,strcat('-d',plot_format),'-r250');
        
    end
    
end