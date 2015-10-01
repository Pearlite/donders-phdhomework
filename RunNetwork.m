function [ nodeE, nodeI ] = RunNetwork ( timesteps, iE, iI, wEE, wEI, wIE, wII, wAB, slopeE, slopeI, thresholdE, thresholdI, typeE, typeI )
%RUNNETWORK is a function that constructs and simulates net A and net B,
% both consisting of an inhibitory and an excitatory population, according
% to the model described in Jadi & Sejnowski (2014). The E-population in
% net B receives weak input from the E-population in net A.
%
% timesteps = number of population activation update cycles. Takes integer.
%
% iE, iI = external input to E and I populations of net A. Takes integer (for
% constant input) or vector of size timesteps (for varying input).
%
% wEE, wEI, wIE, wII = weights representing connection strength between
% populations. wEE{1} and equivalent is used for net A, wEE{2} and equivalent
% is used for net B. If only one value is given this is used for both
% net A and B. Takes integers (for constant weights) or vectors of size
% timesteps (for varying weights).
%
% wAB = weight representing unidirectional connection strength between
% nets A and B. Takes integer (for constant weight) or vector of size
% timesteps (for varying weight).
%
% slopeE, slopeI = rate at which E and I population responses change as
% function of input. Takes integer.
%
% thresholdE, thresholdI = net input below which response function value is
% 0. Takes integer.
%
% typeE = excitatory response function. Takes 'sigmoid' or 'linear'.
% typeI = inhibitory response function. Takes 'sigmoid' or 'powerlaw'.


%%%%%INITIALIZATION%%%%%
% validating weight parameters
if ~iscell('wEE')
    tempvar = wEE;
    clear wEE;
    wEE{1} = tempvar;
    wEE{2} = tempvar;
end
for i = 1:2
    if numel(wEE{i}) == 1
        wEE{i}(1:timesteps) = wEE{i};
    elseif numel(wEE{i}) > 1 && numel(wEE{i}) ~= timesteps
        error('wEE should contain either 1 or %i elements.', timesteps);
    end
end

if ~iscell('wEI')
    tempvar = wEI;
    clear wEI;
    wEI{1} = tempvar;
    wEI{2} = tempvar;
end
for i = 1:2
    if numel(wEI{i}) == 1
        wEI{i}(1:timesteps) = wEI{i};
    elseif numel(wEI{i}) > 1 && numel(wEI{i}) ~= timesteps
        error('wEI should contain either 1 or %i elements.', timesteps);
    end
end

if ~iscell('wIE')
    tempvar = wIE;
    clear wIE;
    wIE{1} = tempvar;
    wIE{2} = tempvar;
end
for i = 1:2
    if numel(wIE{i}) == 1
        wIE{i}(1:timesteps) = wIE{i};
    elseif numel(wIE{i}) > 1 && numel(wIE{i}) ~= timesteps
        error('wIE should contain either 1 or %i elements.', timesteps);
    end
end

if ~iscell('wII')
    tempvar = wII;
    clear wII;
    wII{1} = tempvar;
    wII{2} = tempvar;
end
for i = 1:2
    if numel(wII{i}) == 1
        wII{i}(1:timesteps) = wII{i};
    elseif numel(wII{i}) > 1 && numel(wII{i}) ~= timesteps
        error('wII should contain either 1 or %i elements.', timesteps);
    end
end

% validating iE and iI parameters
if numel(iE) == 1
    iE(1:timesteps) = iE;
elseif numel(iE) > 1 && numel(iE) ~= timesteps
   error('iE should contain either 1 or %i elements.', timesteps);
end

if numel(iI) == 1
   iI(1:timesteps) = iI; 
elseif numel(iI) > 1 && numel(iI) ~= timesteps
   error('iI should contain either 1 or %i elements.', timesteps);
end

% validating wAB parameter
if numel(wAB) == 1
   wAB(1:timesteps) = wAB; 
elseif numel(wAB) > 1 && numel(wAB) ~= timesteps
   error('wAB should contain either 1 or %i elements.', timesteps);
end

%%%%%BUILDING THE MODEL%%%%%
%Network A: inhibitory-excitatory network, external input
nodeE{1}(1:timesteps) = 0; %population firing rates start at 0. Preallocating for speed.
nodeI{1}(1:timesteps) = 0;

%Network B: inhibitory-excitatory network, EE input from net A
nodeE{2}(1:timesteps) = 0;
nodeI{2}(1:timesteps) = 0;

%%%%%RUNNING THE SIMULATION%%%%%
% Current setup: E-population net B receives unidirectional input from
% E-population net A. Net B receives no other external input (iI and iE for
% net B are 0).
for t = 1:timesteps-1
    nodeE{1}(t+1) = GE(wEE{1}(t), nodeE{1}(t), wEI{1}(t), nodeI{1}(t), iE(t), typeE, slopeE, thresholdE);
    nodeI{1}(t+1) = GI(wIE{1}(t), nodeE{1}(t), wII{1}(t), nodeI{1}(t), iI(t), typeI, slopeI, thresholdI);
    nodeE{2}(t+1) = GE(wEE{2}(t), nodeE{2}(t), wEI{2}(t), nodeI{2}(t), (wAB(t) * nodeE{1}(t)), typeE, slopeE, thresholdE);
    nodeI{2}(t+1) = GI(wIE{2}(t), nodeE{2}(t), wII{2}(t), nodeI{2}(t), 0, typeI, slopeI, thresholdI);
end

end