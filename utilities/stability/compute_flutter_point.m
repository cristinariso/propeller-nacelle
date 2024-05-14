%% Flutter point from stability analysis results

% Cristina Riso
% criso@gatech.edu

function [mu_f, omega_f, mu_index, mode_index] = compute_flutter_point(mu, roots)

% number of control parameter increments
n_mu = length(mu);

% number of states
n_states = length(roots(:,1));

% initialize flag 
found = false;

% initialize output
omega_f = NaN; mu_f = NaN; mu_index = 0; mode_index = 0;

% loop the control parameter values
for i = 1:n_mu-1
       
    % loop the eigenvalues
    for k = 1:n_states
        
        % check crossing condition
        if real(roots(k,i)) <= 0 && real(roots(k,i+1)) > 0 && imag(roots(k,i)) >= 0
            
            % compute flutter frequency
            omega_f = interp1([real(roots(k,i)) real(roots(k,i+1))],[imag(roots(k,i)) imag(roots(k,i+1))],0);
            
            % compute flutter control parameter value
            mu_f = interp1([real(roots(k,i)) real(roots(k,i+1))],[mu(i) mu(i+1)],0);
            
            % store control parameter index before flutter
            mu_index = i;
            
            % store flutter mode index
            mode_index = k;
            
            % set found flag to true
            found = true;
            
            % exit inner loop
            break;
            
        end
        
    end
    
    % exit outer loop
    if found == true
        break;
    end    
    
end