# donders-phdhomework
MATLAB code for network simulations based on Jadi & Sejnowski (2014).

Dependencies:
A recent version of MATLAB. Code was created in R2010a.
No further toolkits required.

Run instructions:
1. Open file "plots.m" in MATLAB.
2. Run the first cell within the file (by placing the cursor within it and using CTRL+ENTER) to initialize simulation parameters.
3. Run one of the other cells of choice. Each cell runs a slightly different simulation and produces multiple figures of output.
Parameter initialization cell needs to be re-run before running more graph-generating cells.

Description of files in project:
GE.m            Contains the excitatory response function. Given certain input to a population, calculates the firing rate of that population.
GI.m            Contains the inhibitory response function. Given certain input to a population, calculates the firing rate of that population.
RunNetwork.m    Validates/parses input parameters, sets up the network architecture and gives firing rates over time for each population as output.
config.m        File where parameters can be defined before calling RunNetwork. Not necessary for the assignment but included for completeness.
plots.m         File containing pre-set parameters for predetermined simulations that generates informative plots of the results.
