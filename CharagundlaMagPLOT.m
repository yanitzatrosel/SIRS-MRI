close all; clear all;

% Define values (adjust as needed)
gamma = 42.58*1e6; % Hz/T % 267.513e6; % Gyromagnetic ratio, proton (rad/s/T)
P = 1; %spin-lock amplitude Bsl=P*B1
tau = 1e-6; % nominal pi/2 pulse width in seconds
T1p = 0.1; % Longitudinal relaxation in seconds. Gray matter
T2p = 0.1;  % transverse relaxation in seconds. Gray matter
%B1 = 1.25e3.*6.28; % maximun rf amplitude in rad/s

B1_percentage=[90:0.00001:100];
B1=(B1_percentage./100);

theta = (gamma*B1*tau.*1.25e3)./(gamma.*gamma);
%theta = gamma*B1*tau.*1.25e3;

alpha = P*gamma*B1.*1.25e3./gamma;
%alpha = P*gamma*B1.*1.25e3;

% Define the values of B1
TSL_values = [0.2, 0.4, 0.6, 0.8, 1.0];
%TSL_values = [1.6, 1.6, 1.6, 1.6, 1.6];

% Iterate through each value of TSL
for i = 1:length(TSL_values)
    TSL = TSL_values(i);
    
    % Calculate Mz
    Mz = sin(theta).*sin(theta).*exp(-TSL/T1p)+cos(theta).*cos(theta).*cos(alpha.*TSL).*exp(-TSL/T2p);
    
    % Plot the line for the current value of b
    plot(B1, Mz, 'LineWidth', 1);
    ylim([-0.25 0.25])
    
    % Hold on to add more lines to the same plot
    hold on;
end

% Compute the corresponding Mz-values
%Mz = (sin(gamma*B1*tau)).^2.*exp(-TSL/T1p)+(cos(gamma*B1*tau)).^2.*cos(gamma*B1*tau).*exp(-TSL/T2p);
%Mz2 = exp(-TSL/T1p);

% Add labels and legend
xlabel('fraction of B1 (Hz)');
ylabel('Mz');
title('Longitudinal magnetization');
grid on;
legend('TSL=0.2', 'TSL=0.4', 'TSL=0.6', 'TSL=0.8', 'TSL=1.0');

% Turn off the hold mode
hold off;
