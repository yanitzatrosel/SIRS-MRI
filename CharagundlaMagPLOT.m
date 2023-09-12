% Define the range of x-values
f = linspace(0.9 , 1, 100); % You can adjust the range and number of points

% Define values (adjust as needed)
gamma = 267.513e6; % Gyromagnetic ratio, proton (rad/s/T)
P = 1; %spin-lock amplitude Bsl=P*B1
tau = 1e-6; % nominal pi/2 pulse width in seconds
%TSL = 200e-3; %Spin-Lock time in miliseconds
T1p = 0.1; % Longitudinal relaxation in seconds. Gray matter
T2p = 0.1;  % transverse relaxation in seconds. Gray matter
B1 = 1.25e3*6.28; % maximun rf amplitude in rad/s

% Define the values of B1
TSL_values = [0.2, 0.4, 0.6, 0.8, 1.0];


% Iterate through each value of TSL
for i = 1:length(TSL_values)
    TSL = TSL_values(i);
    
    % Calculate Mz
    Mz = ((sin(gamma*B1*tau*f)).^2).*exp(-TSL/T1p)+(((cos(gamma*B1*tau*f)).^2).*cos(P*gamma*B1*TSL*f).*exp(-TSL/(T2p)));
    
    % Plot the line for the current value of b
    plot(f, Mz, 'LineWidth', 2);
    
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
