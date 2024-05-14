# README

This repository contains the code for an analytical propeller-nacelle whirl flutter test case with polynomial nonlinearities. The model is an adaptation of the model reported by Reed in the 1966 review paper.

## Folder Structure

Folders `output_XX` will be generated when running main.m to store results.

Folder `postproc` contains plot scripts.

Folder `utilities` contains helper functions.

Files that begin with `load_parameters_XX` are input files. 

The main file is the file to be used for generating results.

The time-marching function is under the time marching folder in utilities and calls functions in the model folder (also in utilities). The model folder contains one function to build the state matrix of the linear model and a dydt function that sums up the nonlinear terms.

## Execution

To generate transient responses, run main.m by selecting the flag for the bifurcation behavior (supercritical or subcritical). 

## Visualization

To plot the stability analysis and transient responses, first generate the results. Then run the scripts in `postproc`.

## References

The code was implemented and verified to generate the results in the paper below:

Gali, S. V., Goehmann, T. G., and Riso, C., "Fundamental Investigation into Output-Based Prediction of Whirl Flutter Bifurcations," Journal of Fluids and Structures, 2023. 

Link: https://www.sciencedirect.com/science/article/pii/S0889974623001548. 

The nonlinear extension of Reed's model was originally proposed in the paper below:

Mair, C., Rezgui, D. and Titurus, B., "Nonlinear Stability Analysis of Whirl Flutter in a Rotor-Nacelle System," Nonlinear Dynamics, 2018. 

Link: https://link.springer.com/article/10.1007/s11071-018-4472-y. 

This implementation is based off the above work with no modifications except including nonlinearities in both degrees of freedom.

## Contact

Cristina Riso (criso@gatech.edu)
