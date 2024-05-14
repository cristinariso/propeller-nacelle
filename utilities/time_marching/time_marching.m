%% Time-marching analysis of isolated rotor model

% Cristina Riso
% criso@gatech.edu

function results = time_marching(params, mu, mu_label)

% sanity check
if (strcmp(mu_label,'V') == false)
    error('Error. \n Code only supports stability analysis with respect to V.')
end

% number of transient responses
n_mu = length(mu);

% allocate cell to store state matrices
A = cell(1,n_mu);

% allocate cells to store transient responses
t = cell(1,n_mu);
y = cell(1,n_mu);

% allocate vector to store computational times
time = zeros(1,n_mu);

% allocate bifurcation diagram if applicable
if (params.get_diagram == true)
    
    % initialize bifurcation diagram
    diagram = zeros(n_mu,params.n_states+1);

end

% loop the transient responses
for i = 1:n_mu
    
    % initial time
    i_time = tic;
    
    % note: the compute_A function assumes that the parameter passed is the
    % forward speed and needs to be generated for other cases    
    
    % compute state matrix
    A_i = compute_A(params,mu(i));

    % compute nonlinear stiffness coefficients
    params = update_nonlinear_coefficients(params,mu(i));
    
    % integrate transient response 
    [t_i, y_i] = ode45(@(t_i,y_i)dydt(t_i,y_i,A_i,params),params.t,params.y_0,params.tm_opts);
       
    % compute bifurcation diagram if applicable
    if (params.get_diagram == true)
    
        % store parameter
        diagram(i,1) = mu(i);
        
        % loop states
        for j = 1:params.n_states
        
            % extract response peaks 
            [r_peaks, ~] = findpeaks(y_i(:,j));
            
            % get average amplitude from peaks
            r_mean = mean(r_peaks(end-10:end));
            
            % store amplitude
            diagram(i,1+j) = r_mean;
        
        end
        
    end
    
    % store state matrix
    A{1,i} = A_i;    
    
    % store transient response
    t{1,i} = t_i; 
    y{1,i} = y_i*180.0/pi; 
    
    % store computational time
    time(i) = toc(i_time);
    
end

% store results
results.A = A;
results.t = t;
results.y = y;

if (mu_label == 'V')
   
    results.n_V = n_mu;
    results.V = mu;
    
end

% store bifurcation diagram if applicable
if (params.get_diagram == true)
    diagram(:,2:end) = diagram(:,2:end)*180.0/pi;
    results.diagram = diagram;
end

% store computational time
results.time_tm = time;

% store total computational time
results.time_tm_total = sum(time);

% store average computational time
results.time_tm_mean = mean(time);

end