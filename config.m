%%%%%CONFIGURATION FILE%%%%%
% This file is used to define the parameters that are passed to RunNetwork.
% Default values here are taken from Jadi & Sejnowski (2014) or arbitrarily
% chosen.

% timesteps = number of population activation update cycles. Takes integer.
timesteps = 50;

% iE, iI = external input to E and I populations of net A. Takes double (for
% constant input) or vector of size timesteps (for varying input).
iE = 5;
iI = 5;

% wEE, wEI, wIE, wII = weights representing connection strength between
% populations. wEE{1} and equivalent is used for net A, wEE{2} and equivalent
% is used for net B. If only one value is given this is used for both
% net A and B. Takes doubles (for constant weights) or vectors of size
% timesteps (for varying weights).
wEE = 16; %default = 16
wEI = 26; %default = 26
wIE = 20; %default = 20
wII = 1; %default = 1

% wAB = weight representing unidirectional connection strength between
% nets A and B. Takes double (for constant weight) or vector of size
% timesteps (for varying weight).
wAB = 0.2;

% slopeE, slopeI = rate at which E and I population responses change as
% function of input. Takes double.
slopeE = 1; %default for sigmoid = 1, default for linear = 0.25
slopeI = 1; %default for sigmoid = 1, default for powerlaw = 0.005

% thresholdE, thresholdI = net input below which response function value is
% 0. Takes double.
thresholdE = 5; %default for sigmoid = 5, default for linear = 1
thresholdI = 20; %default for sigmoid = 20, default for powerlaw = 12

% typeE = excitatory response function. Takes 'sigmoid' or 'linear'.
% typeI = inhibitory response function. Takes 'sigmoid' or 'powerlaw'.
typeE = 'sigmoid';
typeI = 'sigmoid';

%%%%%SIMULATE NETWORK%%%%%
[nodeE, nodeI] = RunNetwork ( timesteps, iE, iI, wEE, wEI, wIE, wII, wAB, ...
    slopeE, slopeI, thresholdE, thresholdI, typeE, typeI );