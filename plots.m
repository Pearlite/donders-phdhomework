%%%%%PLOTS FILE%%%%%
%This file calls RunNetwork with the parameters necessary to generate a
%number of plots characterizing the effects of network A input on network B
%activation and the synchrony between nets A and B.

%%%%%GLOBAL PARAMETER DEFINITIONS%%%%%
% timesteps = number of population activation update cycles. Takes integer.
timesteps = 200;

% iE, iI = external input to E and I populations of net A. Takes double (for
% constant input) or vector of size timesteps (for varying input).
iE = zeros(1, timesteps);
iE(10:100) = 5;
iI = zeros(1, timesteps);
iI(10:100) = 5;

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
wAB = 3;

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

%%
%%%%%PLOT 1%%%%%%
% Replication of plots from Figure 3 in Jadi & Sejnowski (2014) as proof of
% principle.

%fewer timesteps to improve simulation speed
timesteps = 40;

counter = 0;

for iE = 0:0.5:10
    for iI = 0:0.5:10
        counter = counter+1;
        [nodeE_temp, nodeI_temp] = RunNetwork ( timesteps, iE, iI, wEE, wEI, wIE, wII, wAB, ...
            slopeE, slopeI, thresholdE, thresholdI, typeE, typeI );
        for i = 1:2
            nodeE{i}.iE(counter) = iE;
            nodeE{i}.iI(counter) = iI;
            nodeE{i}.firingrate(counter, 1:numel(nodeE_temp{i})) = nodeE_temp{i};
            
            nodeI{i}.iE(counter) = iE;
            nodeI{i}.iI(counter) = iI;
            nodeI{i}.firingrate(counter, 1:numel(nodeI_temp{i})) = nodeI_temp{i};
        end
    end
end

%surf(nodeE{1}.iE, nodeE{1}.iI, nodeE{1}.firingrate');

%%
%%%%%PLOT 2%%%%%%
% Brief input to net A simulated for a duration of t=80. -> woops, I don't
% actually do this, I simulate input for the entire duration because I set
% iI and iE to a single value instead of a vector.
% Input strength iE varied from 0 to 20
% Input strength iI varied from 0 to 20

% for iE = 1:20
%     for iI = 1:20
%         [nodeE_temp, nodeI_temp] = RunNetwork ( timesteps, iE, iI, wEE, wEI, wIE, wII, wAB, ...
%             slopeE, slopeI, thresholdE, thresholdI, typeE, typeI );
%         for i = 1:2
%             nodeE{i}(iE, iI, :) = nodeE_temp{i};
%             nodeI{i}(iE, iI, :) = nodeI_temp{i};
%         end
%     end
% end
% 
% %quick tester
% plot(squeeze(nodeE{1}(1,1,:))) %matrix needs to be squeezed to remove singleton dimension
% %network oscillates at iE = 10 and iI = 10, but not at iE = 1 and iI = 1 or
% %iI = 20. Nice!
% 
% %pcolor(squeeze(nodeE{1}(:,10,:))) %plot this a few times for different
% %values of iI, gives a nice impression of when a network oscillates and
% %when it doesn't




% question 1: which range should certain inputs/weights take?
% question 2: how do I characterize the outputs (activation?) FFT on
% nodeE{1}?
% question 3: how do I plot synchrony between populations? -> check how
% Mike does this. Plot spectral coherence?

%%
%%%%%PLOT 2%%%%%
%network A-B connectivity varied
%

%%
%%%%%PLOT 3%%%%%
%input duration varied
%

%%
%%%%%PLOT 4%%%%%
%input strength and duration varied
%

%%
%%%%%PLOT 5%%%%%
%input strength and network connectivity varied
%


%%%%%SIMULATE NETWORK%%%%%
[nodeE, nodeI] = RunNetwork ( timesteps, iE, iI, wEE, wEI, wIE, wII, wAB, ...
    slopeE, slopeI, thresholdE, thresholdI, typeE, typeI );