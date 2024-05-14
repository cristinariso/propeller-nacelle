%% Creates an output folder

% Cristina Riso
% criso@gatech.edu

function folder_name = make_output_folder(params, folder_type)

% extract parameters
K3t = params.K3t;
K5t = params.K5t;
K3p = params.K3p;
K5p = params.K5p;

% create output folder name to store data
folder_name = strcat(folder_type,'_K3t',num2str(K3t),'_K5t',num2str(K5t),'_K3p',num2str(K3p),'_K5p',num2str(K5p));

% create output folder if does not exist
if isfolder(folder_name) == 0
    mkdir(folder_name)
end

end