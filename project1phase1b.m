% Saad Malik
% ECE 202 - Project 1 
% Phase 1
% Power Series Expansion of the function f(t) = Acos(wt) = 7cos(20t)

clear
clf

format ShortG

n = [0:2:10]; 
% Total Number on Non-Zero Coefficients to plot (6 in this case)

N = 400;
t = linspace(0,0.5,N+1); % Total number of values for t, in second

a_n = (((-1).^(n./2)).*7.*(20.^(n)))./factorial(n) 
% General expression used to obtain value of non-zero coefficient for the
% function where n starts from zero and is always even

% The collective 6 functions to plot (for non-zero coefficients)
f1 = a_n(1).*t.^(n(1));
f2 = f1 + a_n(2).*t.^(n(2));
f3 = f2 + a_n(3).*t.^(n(3));
f4 = f3 + a_n(4).*t.^(n(4));
f5 = f4 + a_n(5).*t.^(n(5));
f6 = f5 + a_n(6).*t.^(n(6));

plot(t,f1,t,f2,t,f3,t,f4,t,f5,t,f6); % Plotting all 6 functions on the same
% graph with respect to t
title("ECE 202 - Project 1 Phase 1b - 6 Non-Zero Terms for function " + ...
    "in Truncated Power Series"); % Effective title for graph
xlabel("Time t (seconds)"); % Title of x axis
ylabel("Value of function f(t)"); % Title of y axis
ylim([-10,10]);
grid on;

