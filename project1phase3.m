% Saad Malik
% ECE 202 - Project 1 
% Phase 3
% Defining variables to make the script more robust and changeable by
% changing initial variable values

clear
clf

format ShortG

% Define Variables to be used ahead

A = 7; % Amplitude of Sinusoid
w = 20; % Angular Frequency of Sinusoid
tmin = 0; % In milliseconds
tmax = 500; % In milliseconds
N = 400; % Total Number of points to plot
nmax = 6; % Number of Non-Zero terms to be plotted
n = 0:(nmax-1); % Total Number on Non-Zero Coefficients to plot (6)

tms = linspace(tmin,tmax,N+1); % Total number of values for t, in ms
t = tms/1000; % Converts time t to milliseconds for effective calculations

a_n = (((-1).^n).*A.*(w.^(2*n)))./factorial(2.*n); % General expression to
% obtain value of non-zero coefficient for the function where n starts from
% zero

% The collective 6 functions to plot (for non-zero coefficients)
f1 = a_n(1).*t.^(2.*n(1));
f2 = f1 + a_n(2).*t.^(2.*n(2));
f3 = f2 + a_n(3).*t.^(2.*n(3));
f4 = f3 + a_n(4).*t.^(2.*n(4));
f5 = f4 + a_n(5).*t.^(2.*n(5));
f6 = f5 + a_n(6).*t.^(2.*n(6));

p1 = plot(tms,f1,tms,f2,tms,f3,tms,f4,tms,f5, 'LineWidth', 2); 
% Plotting the first 5 functions with respect to t in ms
% We also define it as the variable p1 for use in legend
ax.FontSize = 16; % Set Font Size equivalent to 16 by default
title(sprintf("ECE 202 - Project 1 Phase 3 - Non-Zero terms for " + ...
    "function %g*cos(%g*t)", A, w), 'FontSize', 12)
xlabel("Time t (milliseconds)", 'FontSize', 12); % Title of x axis
ylabel("Value of function f(t)", 'FontSize', 12); % Title of y axis
ylim([-(A+3),(A+3)]); % Establishes an upper and lower y-axis limit

hold on % Allows us to add more graphs to the same plot
plot([0,500], [0,0], 'k', 'LineWidth', 1);
% Plotting the x-axis onto the same graph

hold on % Allows us to add more graphs to the same plot
p2 = plot(tms,f6, 'LineWidth', 4);
% Plotting the final function with respect to t in ms
% We define it as variable p2 for use in legend

hold off % We are finished adding graphs
ax = gca; ax.GridAlpha = 0.4; % Make the grid darker and more prominent
legend([p1;p2], 'f1:n=0', 'f2:n=2', 'f3:n=4', 'f4:n=6', 'f5:n=8', ...
    'f6:n=10', 'Location', 'eastoutside') % Adding an effective legend
grid on;

n_value = [0; 2; 4; 6; 8; 10;]; 
% Values of n for which coefficients are calculated
coefficient = [a_n(1); a_n(2); a_n(3); a_n(4); a_n(5); a_n(6);];
% The coefficient respective to a value of n
T = table(n_value, coefficient);
% Define a variable as a table to be displayed ahead
disp(T) % Table displayed 

% For Spec 7, we are asked to check if the final output of our script is
% the same visually as before, and as observable, it is the exact same
