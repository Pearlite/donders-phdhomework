%%%%%PLOTS FILE%%%%%
%This file calls RunNetwork with the parameters necessary to generate a
%number of plots characterizing the effects of network A input on network B
%activation and the synchrony between nets A and B.

%%%%%GLOBAL PARAMETER DEFINITIONS%%%%%
% timesteps = number of population activation update cycles. Takes integer.
timesteps = 100;

% iE, iI = external input to E and I populations of net A. Takes a double (for
% constant input) or vector of size timesteps (for varying input).
iE = zeros(1, timesteps);
iE(21:50) = 10;
iI = zeros(1, timesteps);
iI(21:50) = 10;

% wEE, wEI, wIE, wII = weights representing connection strength between
% populations. wEE{1} and equivalent is used for net A, wEE{2} and
% equivalent
% is used for net B. If only one value is given this is used for both
% net A and B. Takes doubles (for constant weights) or vectors of size
% timesteps (for varying weights).
wEE = 16; %default = 16
wEI = 26; %default = 26
wIE = 20; %default = 20
wII = 1; %default = 1

% wAB = weight representing unidirectional connection strength between
% nets A and B. Takes a double (for constant weight) or vector of size
% timesteps (for varying weight).
wAB = 3;

% slopeE, slopeI = rate at which E and I population responses change as
% function of input. Takes a double.
slopeE = 1; %default for sigmoid = 1, default for linear = 0.25
slopeI = 1; %default for sigmoid = 1, default for powerlaw = 0.005

% thresholdE, thresholdI = net input below which response function value is
% 0. Takes a double.
thresholdE = 5; %default for sigmoid = 5, default for linear = 1
thresholdI = 20; %default for sigmoid = 20, default for powerlaw = 12

% typeE = excitatory response function. Takes 'sigmoid' or 'linear'.
% typeI = inhibitory response function. Takes 'sigmoid' or 'powerlaw'.
typeE = 'sigmoid';
typeI = 'sigmoid';

%%
%%%%%PLOT 1%%%%%%
% Replication of plots from Figure 3 in Jadi & Sejnowski (2014) as proof of
% principle. The graphs are only generated for network A; network B data is
% left out.
counter = 0;

for iE = 0:0.2:20
    for iI = 0:0.2:20
        counter = counter+1;
        [nodeE_temp, nodeI_temp] = RunNetwork ( timesteps, iE, iI, wEE, wEI, wIE, wII, wAB, ...
            slopeE, slopeI, thresholdE, thresholdI, typeE, typeI );
            nodeE{1}.iE(counter) = iE;
            nodeE{1}.iI(counter) = iI;
            nodeE{1}.firingrate(counter, 1:numel(nodeE_temp{1})) = nodeE_temp{1};
            
            nodeI{1}.iE(counter) = iE;
            nodeI{1}.iI(counter) = iI;
            nodeI{1}.firingrate(counter, 1:numel(nodeI_temp{1})) = nodeI_temp{1};
    end
end

%convert nodeE and nodeI results to mean firing rate over a period of 
%time where network is presumed to be stable (51 to 100 timesteps)
firingrateE = reshape(mean(nodeE{1}.firingrate(:, 51:100),2), numel(0:0.2:20), numel(0:0.2:20));
figure;
pcolor(firingrateE);

firingrateI = reshape(mean(nodeI{1}.firingrate(:, 51:100),2), numel(0:0.2:20), numel(0:0.2:20));
figure;
pcolor(firingrateI);

clear;

%Note: the output here seems to differ from Jadi & Sejnowski figure 3b,
%most likely on account of different input scaling.

%%
%%%%%PLOT 2%%%%%%
% Brief input to net A simulated for a duration of t=30 (from timestep 21
% to 50).
% Input strength iE varied from 0 to 20.
% Input strength iI varied from 0 to 20.
% The four plots show mean firing rate for net A (node E and I) and net B 
%(node E and I) as a function of the input values. The net A graphs are
% nearly identical to the proof-of-principle graphs from the previous
% section. This suggests that taking the mean of the entire timeseries given
% brief input (done in this section) is nearly indistinguishable from taking 
% the mean over the stable-firing part of the timeseries given constant
% input (done in the previous section). This knowledge allows us to simplify 
% our analyses, taking one general mean (and thus condensing a timeseries 
% into a single value, facilitating plotting) rather than arbitrarily 
% defining a "valid" range within the timeseries.

counter = 0;

iE = zeros(1, timesteps);
iI = zeros(1, timesteps);

for k = 1:0.2:21
    iE(21:50) = k-1;
    for l = 1:0.2:21
        iI(21:50) = l-1;
        counter = counter + 1;
        [nodeE_temp, nodeI_temp] = RunNetwork ( timesteps, iE, iI, wEE, wEI, wIE, wII, wAB, ...
            slopeE, slopeI, thresholdE, thresholdI, typeE, typeI );
        for i = 1:2
            nodeE{i}.iE(counter) = iE(22);
            nodeE{i}.iI(counter) = iI(22);
            nodeE{i}.firingrate(counter, 1:numel(nodeE_temp{i})) = nodeE_temp{i};
            
            nodeI{i}.iE(counter) = iE(22);
            nodeI{i}.iI(counter) = iI(22);
            nodeI{i}.firingrate(counter, 1:numel(nodeI_temp{i})) = nodeI_temp{i};
        end
    end
end

firingrateEA = reshape(mean(nodeE{1}.firingrate,2), numel(1:0.2:21), numel(1:0.2:21));
figure;
pcolor(firingrateEA);

firingrateIA = reshape(mean(nodeI{1}.firingrate,2), numel(1:0.2:21), numel(1:0.2:21));
figure;
pcolor(firingrateIA);

firingrateEB = reshape(mean(nodeE{2}.firingrate,2), numel(1:0.2:21), numel(1:0.2:21));
figure;
pcolor(firingrateEB);

firingrateIB = reshape(mean(nodeI{2}.firingrate,2), numel(1:0.2:21), numel(1:0.2:21));
figure;
pcolor(firingrateIB);

clear;

%%
%%%%%PLOT 3%%%%%
% Brief input to net A simulated for a duration of t=30 (from timestep 21
% to 50).
% Input strength iE set to 10 (default).
% Input strength iI set to 10 (default).
% Connectivity strength between Networks A and B varied from 0 to 20.

counter = 0;

for k = 1:0.2:21
    wAB = k-1;
    counter = counter + 1;
    [nodeE_temp, nodeI_temp] = RunNetwork ( timesteps, iE, iI, wEE, wEI, wIE, wII, wAB, ...
        slopeE, slopeI, thresholdE, thresholdI, typeE, typeI );
    for i = 1:2
        nodeE{i}.wAB(counter) = wAB;
        nodeE{i}.firingrate(counter, 1:numel(nodeE_temp{i})) = nodeE_temp{i};
        
        nodeI{i}.wAB(counter) = wAB;
        nodeI{i}.firingrate(counter, 1:numel(nodeI_temp{i})) = nodeI_temp{i};
    end
end

%plot average firing rate over entire duration against A-B connection
%weight
figure;
plot(nodeE{2}.wAB, mean(nodeE{2}.firingrate,2));

figure;
plot(nodeI{2}.wAB, mean(nodeI{2}.firingrate,2));


figure;
plot(nodeE{2}.wAB, nodeE{2}.firingrate);

figure;
plot(nodeI{2}.wAB, mean(nodeI{2}.firingrate,2));

%cross-correlation between signals
a = xcorr(nodeE{1}.firingrate(30,:), nodeE{2}.firingrate(30,:));

clear;

%%
%%%%%PLOT 4%%%%%
%input duration varied
%