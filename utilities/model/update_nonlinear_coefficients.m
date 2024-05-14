%% Updated nonlinear stiffness coefficients

% Cristina Riso
% criso@gatech.edu

function params = update_nonlinear_coefficients(params, V)

% update pitch nonlinear stiffness coefficients for this forward speed
params.k3t = params.k3t_0+params.k3t_2*V^2;
params.k5t = params.k5t_0+params.k5t_2*V^2;
params.K3t = params.k3t*params.In;
params.K5t = params.k5t*params.In;

% update yaw nonlinear stiffness coefficients for this forward speed
params.k3p = params.k3p_0+params.k3p_2*V^2;
params.k5p = params.k5p_0+params.k5p_2*V^2;
params.K3p = params.k3p*params.In;
params.K5p = params.k5p*params.In;
