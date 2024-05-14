%% MAC between two eigenvectors

% Cristina Riso
% criso@gatech.edu

function MAC = compute_MAC(phi_1, phi_2)

MAC = (abs(phi_1'*phi_2))^2/((phi_1'*phi_1)*(phi_2'*phi_2));