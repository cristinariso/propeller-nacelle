%% Plot transient responses

% Vishal Gali
% sgali32@gatech.edu

clearvars
close all
clc

% folder name (must contain results)
output_folder = '..\output_K3t10_K5t0_K3p10_K5p0';
% output_folder = '..\output_K3t-10_K5t350_K3p-10_K5p350';

% load results
load(strcat(output_folder,'\results.mat'),'results_tm'); results = results_tm; clear results_tm

% top level plot folder - update accordingly
plot_folder = '';


%% Plot parameters

% forward speed
V_plot = [7.5, 8.0];

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
t_min = 0.0; t_max = 8.0; y_min = -6.0; y_max = 6.0;

% number of ticks
n_ticks_t = 4; n_ticks_y = 6;

% state varieble
state = 1;

% flat to save plot
save_plots = false;

% plot format
plot_format = 'pdf';


%% Plot transient responses

% start counter
k = 1;

% loop cases to plot
for j = 1:length(V_plot)
    
    % extract speed
    V = V_plot(j);
    
    % find index of selected speed
    V_index = find(ismembertol(results.V,V));
    
    % get transient response results for selected speed
    t = results.t{1,V_index};
    y = results.y{1,V_index}(:,state);
    
    % plot selected range and zoom
    for i = 1:2
        
        fig = figure(k); set(fig,'Position',[0 0 1200 900]); hold all;
        
        % plot transient response and fitted envelope
        plot(t,y,'Color',c2,'LineWidth',3)
        
        % labels and thicks
        switch state
            case 1
                yvar = 'Pitch angle (deg)';
            case 2
                yvar = 'Yaw angle (deg)';
            case 3
                yvar = 'Pitch rate (deg/s)';
            case 4
                yvar = 'Yaw rate (deg/s)';
        end
        
        xlabel('Time (s)'); ylabel(yvar);
        ax = gca; ax.FontSize = font_size;
        
        % select range
        switch i
            case 1
                
                % full range
                axis([t_min t_max y_min y_max]);
                                
            case 2
                
                % zoomed range without legend
                axis([t_min t_max/10.0 y_min y_max]);
        end
        
        % save plot
        if save_plots == true
            
            switch i                
                case 1
                    filename = strcat(plot_folder,'\response_state',num2str(state),'_V',num2str(V),'.',plot_format);                
                case 2
                    filename = strcat(plot_folder,'\response_state',num2str(state),'_V',num2str(V),'_zoom.',plot_format);                    
            end
            
            set(fig,'Units','Inches'); pos = get(fig,'Position');
            set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
            print(fig,filename,strcat('-d',plot_format),'-r250');
            
        end
        
        % increment counter
        k = k+1;
        
    end
    
end