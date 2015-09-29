function [ y ] = GI ( wIE, rE, wII, rI, iI, type, slopeI, thresholdI )
%GI This function gives the excitatory response function of the simplified
%firing rate model as described in Jadi & Sejnowski (2014).
%Inputs:
% wII, wIE = connection strengths between populations, positive integers
% rE, rI = input activity to E-population and I-population, integers
% iI = external excitation to I-population, integer
% type = the type of response function (sigmoid or powerlaw)
%Outputs:
% y = proportion of population cells firing, integer

%input to the inhibitory response function
x = wIE * rE - wII * rI + iI;

%response function
switch type
    case 'sigmoid'
        y = 1 / (1 + exp( -slopeI * (x - thresholdI))) - 1 / (1 + exp(slopeI * thresholdI));       
    case 'powerlaw'
        if x < thresholdI
            y = 0;
        else
            y = slopeI * (x - thresholdI)^3;
        end
        if y > 1
            y = 1;
        end
    otherwise
        error('Invalid response function type for inhibitory population.');
end