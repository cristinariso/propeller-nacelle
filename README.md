## README

This code corresponds to the model used for the results in Gali et al., Journal of Fluids and Structures, 2023.

Paper link: https://www.sciencedirect.com/science/article/pii/S0889974623001548. 

The nonlinear extension of Reed's model was originally proposed by Mair et al., Nonlinear Dynamics, 2018.

Paper link: https://link.springer.com/article/10.1007/s11071-018-4472-y

This has been reimplemented for the above work with no modifications except including nonlinearities in both degrees of freedom (for isotropy).

## Folder Structure

Folders `output_XX` will be generated when running main.m to store results.

Folder `postproc` contains plot scripts.

Folder `utilities` contains helper functions.

Files that begin with `load_parameters_XX` are input files. 

The main file is the file to be used for generating results.

The time-marching function is under the time marching folder in utilities and calls functions in the model folder.

The model folder contains one function to build the state matrix of the linear model and then a dydt function that sums up the nonlinear terms.

## Execution

To generate transient responses, run main.m by selecting the flag for the bifurcation behavior (supercritical or subcritical). 

## Visualization

To plot the stability analysis and transient responses, first generate the results. Then run the scripts in `postproc`.

## Contact

Cristina Riso
criso@gatech.edu
