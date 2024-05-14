%% MAC-based mode tracking

% Cristina Riso
% criso@gatech.edu

function [roots_2_tracked, Phi_2_tracked, Psi_2_tracked] = track_modes(~, Phi_1, roots_2, Phi_2, Psi_2)

% number of states 
n_states = length(Phi_1(:,1)); 

% vector to store tracked eigenvalues
roots_2_tracked = zeros(length(Phi_1(1,:)),1);

% matrices to store tracked eigenvectors
Phi_2_tracked = zeros(n_states,length(Phi_1(1,:)));
Psi_2_tracked = zeros(n_states,length(Phi_1(1,:)));

% list of matched indices
exclude_modes = zeros(length(Phi_1(1,:)),1);

% loop the set 2 eigenvectors
for i = 1:length(Phi_2(1,:))
    
    % initialize the best MAC
    MAC_best = 0;
    
    % loop the set 1 eigenvectors
    for j = 1:length(Phi_1(1,:))
        
        % skip if matched
        if ismember(j,exclude_modes) == 1
            continue
        end
        
        % compute MAC 
        MAC_temp = compute_MAC(Phi_1(:,j),Phi_2(:,i));
        
        % update best MAC 
        if MAC_temp > MAC_best
            
            MAC_best = MAC_temp;
            MAC_best_index = j;
        
        end
        
    end
    
    % add matched eigenvector index to list 
    exclude_modes(MAC_best_index) = MAC_best_index;
    
    % store tracked eigenvalue
    roots_2_tracked(MAC_best_index,1) = roots_2(i);
    
    % store tracked eigenvectors
    Phi_2_tracked(:,MAC_best_index) = Phi_2(:,i);
    Psi_2_tracked(:,MAC_best_index) = Psi_2(:,i);
    
end