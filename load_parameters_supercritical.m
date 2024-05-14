%% Parameters for bifurcation analysis of isolated rotor model


%% Model parameters (from Mair, Ph.D. Thesis, 2021)

% number of states
params.n_states = 4;

% rotor radius (m)
params.r = 0.152;                       

% angular velocity (rad/s)
params.W = 40;

% number of blades
params.n = 4;

% blade chord (m)
params.c = 0.026;

% blade airfoil lift curve slope (1/rad)
params.cla = 2*pi; 

% ratio of pivot length to rotor radius
params.a = 0.25;                                      

% rotor and nacelle moments of inertia (kg/m2)
params.Ix = 0.000103;
params.In = 0.000178;

% structural pitch damping (N.m.s/rad) and linear stiffness (N.m/rad) 
params.Ct = 0.001; params.Kt = 0.4;

% structural yaw damping (N.m.s/rad) and stiffness (N.m/rad)
params.Cp = 0.001; params.Kp = 0.4;

% nominal air density (kg/m3) - this may change
params.rho = 1.225;

% auxiliary variable
params.Var = params.n*params.rho*params.cla*params.r^5*params.W^2/4;

% structural pitch cubic and fifth-order stiffness (N.m/rad^3) and (N.m/rad^5)
params.K3t_0 = 10.0; params.K5t_0 = 0.0;

% structural yaw cubic and fifth-order stiffness (N.m/rad^3) and (N.m/rad^5)
params.K3p_0 = 10.0; params.K5p_0 = 0.0;

% coefficient to specify structural pitch stiffness variation with forward speed (N.s^2/rad^3/m) and (N.s^2/rad^5/m)
params.K3t_2 = 0.0; params.K5t_2 = 0.0;

% coefficient to specify structural yaw stiffness variation with forward speed (N.s^2/rad^3/m) and (N.s^2/rad^5/m)
params.K3p_2 = 0.0; params.K5p_2 = 0.0;

% divide by moment of inertia
params.k3t_0 = params.K3t_0/params.In;
params.k5t_0 = params.K5t_0/params.In;
params.k3p_0 = params.K3p_0/params.In;
params.k5p_0 = params.K5p_0/params.In;
params.k3t_2 = params.K3t_2/params.In;
params.k5t_2 = params.K5t_2/params.In;
params.k3p_2 = params.K3p_2/params.In;
params.k5p_2 = params.K5p_2/params.In;

% initialize values to baseline
params.K3t = params.K3t_0;
params.K5t = params.K5t_0;
params.K3p = params.K3p_0;
params.K5p = params.K5p_0;
params.k3t = params.k3t_0;
params.k5t = params.k5t_0;
params.k3p = params.k3p_0;
params.k5p = params.k5p_0;


%% Stability analysis parameters

% lower and upper speed for eigenvalue analyses (m/s)
params.V_min_eig = 0.1;
params.V_max_eig = 10.0;

% velocity increment for eigenvalue analyses (m/s)
params.dV_eig = 0.1;

% assemble speed range for eigenvalue analyses 
params.V_eig = params.V_min_eig:params.dV_eig:params.V_max_eig;

% number of speeds
params.n_V_eig = length(params.V_eig);

% frequency threshold to retain modes (rad/s)
params.omega_min = 0.01;

% flag to normalize modes
params.normalize_modes = true;

% index to normalize modes (also used to define forecasted state)
params.state_index = 1;


%% Time-marching parameters

% initial conditions 
%
% y1 = pitch (rad)
% y2 = yaw (rad)
% y3 = pitch rate (rad/s)
% y4 = yaw rate (rad/s)
%
params.y1_0 = 6.0*pi/180; 
params.y2_0 = 0.0; 
params.y3_0 = 0.0; 
params.y4_0 = 0.0;

% assemble initial conditions
params.y_0 = [params.y1_0; params.y2_0; params.y3_0; params.y4_0];

% absolute and relative convergence tolerance
params.abs_tol = 1.0e-12; params.tm_opts = odeset('AbsTol',params.abs_tol);

% relative convergence tolerance
params.rel_tol = 1.0e-12; params.tm_opts = odeset('RelTol',params.rel_tol);

% initial and final time (s)
params.t_min = 0.0; 
params.t_max = 200.0; 

% time step (s)
params.dt = 0.002; 

% assemble time range
params.t = params.t_min:params.dt:params.t_max;

% number of times
params.n_t = length(params.t);


%% Parameters for obtaining time-marching bifurcation diagram

% lower and upper speed for time marching (m/s)
params.V_min_tm = 7.4;
params.V_max_tm = 8.2;

% velocity increment for time marching (m/s)
params.dV_tm = 0.025;

% assemble speed range
params.V_tm = params.V_min_tm:params.dV_tm:params.V_max_tm;

% number of speeds
params.n_V_tm = length(params.V_tm);