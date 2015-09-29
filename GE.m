function [ y ] = GE ( wEE, rE, wEI, rI, iE, type, slopeE, thresholdE )
%GE This function gives the excitatory response function of the simplified
%firing rate model as described in Jadi & Sejnowski (2014).
%Inputs:
% wEE, wEI = connection strengths between populations, positive integers
% rE, rI = input activity to E-population and I-population, integers?
% iE = external excitation to E-population, integer
% type = the type of response function (sigmoid or linear)
%Outputs:
% y = proportion of population cells firing, integer

%input to the excitatory response function
x = wEE * rE - wEI * rI + iE;

%response function
switch type
    case 'sigmoid'
        y = 1 / (1 + exp( -slopeE(x - thresholdE))) - 1 / (1 + exp(slopeE * thresholdE));       
    case 'linear'
        if x < thresholdE
            y = 0;
        elseif x > (thresholdE + 1/slopeE)
            y = 1;
        else
            y = slopeE(x - thresholdE);
        end
    otherwise
        error('Invalid response function type for excitatory population.');
end