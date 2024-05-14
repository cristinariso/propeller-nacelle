%% Eigenvalue-based stability analysis of isolated rotor model

% Cristina Riso
% criso@gatech.edu

function results = stability(params, mu, mu_label)

% sanity check
if (strcmp(mu_label,'V') == false)
    error('Error. \n Code only supports stability analysis with respect to V.')
end

% start time
i_time = tic;

% number of control-parameter values
n_mu = length(mu);

% conduct stability analysis
[A, roots, Phi, ~] = analyze_flutter(params,mu);

% search for flutter point
[mu_f, omega_f, mu_index, mode_index] = compute_flutter_point(mu,roots);

% if flutter occurs
if (mu_index > 0)
    
    % compute state matrix at flutter point
    A_f = compute_A(params,mu_f);
    
    % compute eigenvalues and eigenvectors at flutter point
    [roots_f, Phi_f, Psi_f] = solve_eigenproblem(A_f,params.state_index,params.normalize_modes);
    
    % find frequencies above threshold
    keep_indices = find(imag(roots_f) > params.omega_min);
    
    % extract eigenvalues above threshold
    roots_f = roots_f(keep_indices);
    
    % extract eigenvectors corresponding to eigenvalues
    Phi_f = Phi_f(:,keep_indices); 
    Psi_f = Psi_f(:,keep_indices);
    
    % track eigenvalues and eigenvectors at flutter point
    [roots_f, Phi_f, Psi_f] = track_modes(roots(:,mu_index),Phi{1,mu_index},roots_f,Phi_f,Psi_f);

    % get flutter mode
    phi_f = Phi_f(:,mode_index);
    psi_f = Psi_f(:,mode_index);    
    
    % store state matrix at flutter point
    results.A_f = A_f; 
    
    % store eigenvectors at flutter point
    results.Phi_f = Phi_f;
    results.Psi_f = Psi_f;
    results.phi_f = phi_f;
    results.psi_f = psi_f;
    
    % store eigenvalues at flutter point
    results.roots_f = roots_f;

end

% store results
results.A = A;
results.Phi = Phi;
results.roots = roots;
results.mode_index = mode_index;
results.omega_f = omega_f;

if (mu_label == 'V')

    results.n_V = n_mu;
    results.V = mu;
    results.V_index = mu_index;
    results.V_f = mu_f;
    
end

% store total 
results.time_total = toc(i_time);

% store average time
results.time_mean = results.time_total/n_mu;

end