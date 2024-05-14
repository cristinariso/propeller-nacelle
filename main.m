%% Bifurcation analysis of isolated rotor model for varying forward speed

clearvars
close all
clc

% add paths
addpath('utilities\general');
addpath('utilities\model');
addpath('utilities\stability');
addpath('utilities\time_marching');

% behavior (supercritical or subcritical)
behavior = 'supercritical';
% behavior = 'subcritical';

% load parameters
switch behavior
    case 'supercritical'
        load_parameters_supercritical
    case 'subcritical'
        load_parameters_subcritical
end

% append flags
params.behavior = behavior;

% make output folder
output_folder = make_output_folder(params,'output');

% copy input file
copyfile(strcat('load_parameters_',behavior,'.m'),output_folder);

% flag to run or load transient responses
run_tm = true;


%% Eigenvalue-based stability analysis

% conducts eigenvalue analysis
results_sa = stability(params,params.V_eig,'V');


%% Time marching 

% check flag
if (run_tm == true)
    
    % bifurcation diagram calculation on
    params.get_diagram = true;
    
    % run transient responses to compute bifurcation diagram
    results_tm = time_marching(params,params.V_tm,'V');
    
else
    
    % load results
    load(strcat(output_folder,'\results.mat'),'results_tm');
    
end


%% Save results

% save results
save(strcat(output_folder,'\results.mat'));