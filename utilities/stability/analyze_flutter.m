%% Eigenvalue-based stability analysis with mode tracking

% Cristina Riso
% criso@gatech.edu

function [A, roots, Phi, Psi] = analyze_flutter(params, mu)

% number of control parameter increments
n_mu = length(mu);

% number of states
n_states = params.n_states; 

% flag for mode normalization
normalize_modes = params.normalize_modes; 

% state index for mode normalization
state_index = params.state_index;

% frequency threshold (rad/s)
omega_min = params.omega_min;

% allocate cell to save state matrices
A = cell(1,n_mu);

% allocate matrix to save eigenvalues
roots = zeros(n_states,n_mu);

% allocate cell to save eigenvectors
Phi = cell(1,n_mu);
Psi = cell(1,n_mu);

% loop the control paremeter values
for i = 1:n_mu
    
    % note: the compute_A function assumes that the parameter passed is the
    % forward speed and needs to be generated for other cases
    
    % compute state matrix
    A_i = compute_A(params,mu(i));  
    
    % compute eigenvalues and eigenvectors 
    [roots_i, Phi_i, Psi_i] = solve_eigenproblem(A_i,state_index,normalize_modes);  
    
    % find frequencies above threshold
    keep_indices = find(imag(roots_i) > omega_min); 
    
    % extract eigenvalues above the threshold 
    roots_i = roots_i(keep_indices); 
    
    % extract corresponding eigenvectors
    Phi_i = Phi_i(:,keep_indices);
    Psi_i = Psi_i(:,keep_indices);
    
    % mode track
    if (i == 1)
        
        % compute number of retained modes
        n_keep = length(roots_i);
        
        % resize
        roots(n_keep+1:end,:) = [];
        
        % sort eigenvalues by descending frequency
        [~, sort_indices] = sort(imag(roots_i),'descend'); roots_i = roots_i(sort_indices);
        
        % sort eigenvectors accordingly
        Phi_i = Phi_i(:,sort_indices);
        Psi_i = Psi_i(:,sort_indices);
        
    else
        
        % mode track current control parameter increment 
        [roots_i, Phi_i, Psi_i] = track_modes(roots(:,i-1),Phi{1,i-1},roots_i,Phi_i,Psi_i);
        
    end

    % store state matrix
    A{1,i} = A_i;      
    
    % store eigenvalues
    roots(:,i) = roots_i;
    
    % store eigenvectors
    Phi{1,i} = Phi_i; 
    Psi{1,i} = Psi_i;
    
end