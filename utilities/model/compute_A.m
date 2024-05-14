%% Classical whirl flutter model linear state matrix

% Cristina Riso
% criso@gatech.edu

% based on code developed by Todd Goehmann

function A = compute_A(params, V)

% extract parameters
r = params.r;
W = params.W; 
c = params.c;  
a = params.a; 
Ix = params.Ix; 
In = params.In; 
Ct = params.Ct; 
Kt = params.Kt; 
Cp = params.Cp; 
Kp = params.Kp; 
Var = params.Var;

% compute advance ratio
mu = V/(W*r);

% compute aerodynamic coefficients from the literature
A1 = +mu^2*c*asinh(1.0/mu)/r; 
A2 = +mu*c/(2.0*r)*(sqrt(mu^2+1.0)-mu^2*asinh(1.0/mu));
A3 = -c/r*((3.0*mu^2-2.0)*sqrt(mu^2+1.0)-3.0*mu^4*asinh(1.0/mu))/8.0;

% compute state matrix coefficients
e31 = +(a*mu*A1*Var-Kt)/In;
e32 = -(mu*A2*Var)/In;
e33 = +(-Ct-Var*(A3+a^2*A1)/W)/In;
e34 = +(Ix*W)/In;
e41 = +(mu*A2*Var)/In;
e42 = +(Var*a*mu*A1-Kp)/In;
e43 = -(Ix*W)/In;
e44 = +(-Cp-Var*(A3+a^2*A1)/W)/In;

% assemble state matrix
A = [0.0 0.0 1.0 0.0; 0.0 0.0 0.0 1.0; e31 e32 e33 e34; e41 e42 e43 e44];