%% Classical whirl flutter model nonlinear equations

% This based on the code developed by Todd Goehmann under his AE 4699 work 
% in Spring 2022

function ydot = dydt(~, y, A, params)

% extract nonlinear coefficients
k3t = params.k3t;
k5t = params.k5t;
k3p = params.k3p;
k5p = params.k5p;

% compute linear part of state velocity
ydot = A*y;

% add the nonlinear portion
ydot(1) = ydot(1);
ydot(2) = ydot(2);
ydot(3) = ydot(3)-y(1)*(k3t*y(1)^2+k5t*y(1)^4);
ydot(4) = ydot(4)-y(2)*(k3p*y(2)^2+k5p*y(2)^4);