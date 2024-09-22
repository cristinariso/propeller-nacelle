# README

This repository contains the implementation of an analytical propeller-nacelle model with polynomial stiffness nonlinearities. The model is a variant of the model reported by Reed in the 1966 whirl flutter review paper.

## Folder Structure

Folders `output_XX` will be generated when running main.m to store input files and results.

Folder `postproc` contains plot scripts.

Folder `utilities` contains helper functions.

Input files begin with `load_parameters_XX`. 

The main file main.m is the analysis driver.

The time-marching function is in the `time_marching` folder in `utilities` and calls functions in the `model` folder. This folder contains one function to build the linear state matrix and a dydt function that adds nonlinear terms.

## Execution

To conduct the eigenvalue-based stability analysis and simulate transient responses, run main.m by selecting the flag for the desired bifurcation behavior (supercritical or subcritical). 

## Visualization

After generating the results, run the scripts in the `postproc` folder to visualize the stability analysis and simulated time histories.

## References

The code was implemented and verified in the paper below:

Gali, S. V., Goehmann, T. G., and Riso, C., "Fundamental Investigation into Output-Based Prediction of Whirl Flutter Bifurcations," Journal of Fluids and Structures, 2023. 

Link: https://www.sciencedirect.com/science/article/pii/S0889974623001548. 

The nonlinear extension of Reed's model was originally proposed in the paper below:

Mair, C., Rezgui, D. and Titurus, B., "Nonlinear Stability Analysis of Whirl Flutter in a Rotor-Nacelle System," Nonlinear Dynamics, 2018. 

Link: https://link.springer.com/article/10.1007/s11071-018-4472-y. 

The present implementation extends the work by Mair et al. by including nonlinearities in both the pitch and yaw degrees of freedom.

## Contact

Cristina Riso (criso@gatech.edu)
