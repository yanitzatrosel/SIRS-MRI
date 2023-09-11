% Define the range of x-values
TSL = linspace(0, 1, 100); % You can adjust the range and number of points

% Define values (adjust as needed)
gamma = 267.513e6; % Gyromagnetic ratio, proton (rad/s/T)
P = 1; %spin-lock amplitude Bsl=P*B1
tau = 1e-6; % nominal pi/2 pulse width
%TSL = 200e-3; %Spin-Lock time in miliseconds
T1p = 0.95; % Longitudinal relaxation in seconds. Gray matter
T2p = 0.1;  % transverse relaxation in seconds. Gray matter

% Define the values of B1
B1_values = [20, 40, 60, 80, 100];


% Iterate through each value of b
for i = 1:length(B1_values)
    B1 = B1_values(i);
    
    % Calculate Mz
    Mz = (sin(gamma*B1*tau).^2).*exp(-TSL/T1p)+(cos(gamma*B1*tau).^2).*cos(gamma*B1*tau).*exp(-TSL/T2p);
    
    % Plot the line for the current value of b
    plot(TSL, Mz, 'LineWidth', 2);
    
    % Hold on to add more lines to the same plot
    hold on;
end

% Compute the corresponding Mz-values
%Mz = (sin(gamma*B1*tau)).^2.*exp(-TSL/T1p)+(cos(gamma*B1*tau)).^2.*cos(gamma*B1*tau).*exp(-TSL/T2p);
%Mz2 = exp(-TSL/T1p);

% Add labels and legend
xlabel('TSL (s)');
ylabel('Mz');
title('Longitudinal magnetization');
grid on;
legend('B1=20', 'B1=40', 'B1=60', 'B1=80', 'B1=100');

% Turn off the hold mode
hold off;
