% Saad Malik
% ECE 202 - Project 1 
% Phase 4
% Using a "for" loop within our script to plot any number of functions,
% instead of hardcoding individual plot commands

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

tms = linspace(tmin,tmax,N+1);% Total number of values for t, in ms
sizetms = size(tms); % Define variable as the size of tms
t = tms/1000; % Converts time t to milliseconds for effective calculations

a_n = (((-1).^n).*A.*(w.^(2*n)))./factorial(2.*n); % General expression to
% obtain value of non-zero coefficient for the function where n starts from
% zero

plot([0,500], [0,0], 'k', 'LineWidth', 1); % Plot x-axis onto graph

% Using a "for" loop to create an indefinite number of functions 
f = zeros(sizetms); % Create an array of zeros with size of tms
p = 0; % Initialize p as 0

hold on % Allow more plots to be added to the same graph

% The collective 6 functions to plot (for non-zero coefficients)
f1 = a_n(1).*t.^(2.*n(1));
f2 = f1 + a_n(2).*t.^(2.*n(2));
f3 = f2 + a_n(3).*t.^(2.*n(3));
f4 = f3 + a_n(4).*t.^(2.*n(4));
f5 = f4 + a_n(5).*t.^(2.*n(5));
f6 = f5 + a_n(6).*t.^(2.*n(6));

% Create a "for" loop to plot additional functions 
for i = 1:length(n)

    if i == length(n) 
    wd = 4; % If the last function is to be plotted, the thickness is 4
    else 
    wd = 2; % For the rest of the functions to be plotted, thickness is 2
    end 

    f = f + (a_n(i).*t.^(2.*n(i))); % Add functions to array "f"
    p(i) = plot(tms, f, 'LineWidth', wd);
    % Plot each individual function onto the same graph with respect to tms
    
end 

check_f6 = sum(f - f6) % Should equal zero if f6 and f are the same 
                       % equivalent functions

hold off % We have finished adding plots onto the graph
legend show Location eastoutside % Locate legend appropriately 
 
% Plotting the first 5 functions with respect to t in ms
% We also define it as the variable p1 for use in legend
ax.FontSize = 16; % Set Font Size equivalent to 16 by default
title(sprintf("ECE 202 - Project 1 Phase 4 - Non-Zero terms for " + ...
    "function %g*cos(%g*t)", A, w), 'FontSize', 12)
xlabel("Time t (milliseconds)", 'FontSize', 12); % Title of x axis
ylabel("Value of function f(t)", 'FontSize', 12); % Title of y axis
ylim([-(A+3),(A+3)]); % Establishes an upper and lower y-axis limit
legend(p, 'f1:n=0', 'f2:n=2', 'f3:n=4', 'f4:n=6', 'f5:n=8', ...
    'f6:n=10', 'Location', 'eastoutside')

% Plotting the final function with respect to t in ms
% We define it as variable p2 for use in legend

ax = gca; ax.GridAlpha = 0.4; % Make the grid darker and more prominent

grid on;

N = cat(1,n*2,a_n); % Connects values of n and a_n
T = array2table(N, "RowNames" , {'n value', 'coefficient'})
% Creates a table of coefficient values next to respective n values

% As comparable to previous outputs, we attain he same output for the final
% command window and graphical representation


