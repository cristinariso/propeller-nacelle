%% Eigenvalue analysis 

% Cristina Riso
% criso@gatech.edu

function [lambda, Phi, Psi] = solve_eigenproblem(A, state_index, normalize_modes)

% eigenvalue analysis of A
[Phi, Lambda, Psi] = eig(A); lambda = diag(Lambda);

% normalize eigenvectors if applicable
if normalize_modes == true
 
    for i = 1:length(lambda)
        
        % normalize right eigenvector
        Phi(:,i) = Phi(:,i)/Phi(state_index,i);
        
        % normalize left eigenvector
        Psi(:,i) = Psi(:,i)/Psi(state_index,i);
        
    end
    
end