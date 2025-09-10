% Saad Malik
% ECE 202 - Project 2
% Phase 4
% Deriving like-natured results in Matlab and establishing a comparison
% between aforementioned results and Excel calculated results

clear;
clf;

% --- Define Given Information ---

R0 = 463; % Range of HR, in feet
v0 = 116; % Exit velocity, in mph 
phi0deg = 28; % Launch angle, in degrees
maxheight = 100; % Maximum height in feet
m = 0.145; % Mass of a baseball in kilograms
C = input('Enter a value for C: ');
% Recieve user input for a value of C, which is a dimensionless quantity
p = 1.293; % Density of air at 1 atm, and 273K; units in kg/m^3
r = 76/2000; % Radius of baseball
bba = pi()*r^2; % Cross-sectional area of baseball in meteres^2

x0 = 0; y0 = 0;
g = 9.8; % gravity force, in m/s^2

% time is in s, distance in m, speed in m/s, etc

% --- conversion factors ---

mph2mps = 5280 * 12 * 2.54 / 100 / 3600; % mph to m/s conversion
deg2rad = pi/180; % Degrees to radians
m2ft = 100/2.54/12; % Metres to feet

% --- Conducted Calculations Regarding Conversions ---

v0 = v0*mph2mps; % initial speed
phi0 = phi0deg*deg2rad; % launch angle, radians

v0x = v0*cos(phi0); % x-component of velocity
v0y = v0*sin(phi0); % y-component

% --- Compute some useful quantities for the trajectory ---

tH = v0y/g; % time to reach maxmium height
tLand = 5.3; % time to land (time of flight)

% --- Compute Analytical Solution ---

tmin = 0; tmax = tLand;
N = 400; % Number of Intervals

t = linspace(tmin,tmax,N+1); % time array, create x(t) y(t)

xa = x0 + v0x*t; 
% analytical x(t), no drag, ax = 0;
ya = y0 + v0y*t - (1/2)*g*t.^2; 
% analytical y(t), gravity, no drag, ay = -g

% --- Add Numerical Solution ---

dt = (tmax-tmin)/N;

xn = zeros(1,N+1); % Position x as a function of time
yn = zeros(1,N+1); % Position y as a function of time

yn(1) = y0; % Initial Position y
xn(1) = x0; % Initial Position x

vy = v0y; % Initial Velocity for y component
vx = v0x; % Initial Velocity for x component

for n = 1:N

    v = sqrt(vx^2 + vy^2); % Velocity 

    dragfx = -(1/2)*C*p*bba*v*vx; % Drag force in x-direction
    dragfy = -(1/2)*C*p*bba*v*vy; % Drag force in y-direction

    ax = dragfx/m; % Acceleration in x-direction
    ay = (dragfy/m) - g; % Acceleration in y-direction

    yn(n+1) = yn(n) + dt*vy + (1/2)*(dt^2)*ay; 
    % y(t+dt) = y(t) + dt*y'(t) + (1/2)*dt^2*y''(t)
    vy = vy + ay*dt; 
    % y'(t+dt) = y'(t) + dt*y''(t)

    xn(n+1) = xn(n) + dt*vx;
    % x(t+dt) = x(t) + dt*x'(t) + (1/2)*dt^2*x''(t)
    vx = vx + ax*dt; 
    % x'(t+dt) = x'(t) + dt*x''(t)

    if yn(n)*yn(n+1)<0
        flighttime = (n-1+(yn(n)/(yn(n)-yn(n+1))))*dt
        range = xn(n);

        vf = sqrt(vx^2 + vy^2);

        KEi = (1/2)*m*(v0x^2 + v0y^2);
        KEf = (1/2)*m*vf^2;
        EnergyLost = KEi - KEf
        
        break
    end 
    
end

% Conversion of values in metres, to values in feet

xn_ft = xn*m2ft;
yn_ft = yn*m2ft;
xa_ft = xa*m2ft;
ya_ft = ya*m2ft;

% Calculations and conversions of required values into the required unit
% parameters

rangeft = range*m2ft
MaxHeight = max(yn)*m2ft
fspeedmph = vf*2.23694


check_numy = sum(abs(ya-yn))  
% Compare analytic to numeric, should equate to zero
check_numx = sum(abs(xa-xn))
% Compare analytic to numeric, should equate to zero

plot(xa_ft,ya_ft,xn_ft,yn_ft,'--','LineWidth', 5)
grid on
ax = gca; ax.FontSize = 14;
grid minor 
ax.GridAlpha = 0.4; ax.MinorGridAlpha = 0.5;

xlabel('x (ft)','FontSize',16); % Adding an x-label
ylabel('y (ft)','FontSize',16); % Adding an y-label

title({'ECE 202 Project 2 - Phase 4',...
    'Analytical Trajectory of a baseball (inclusive of Drag)', ...
    sprintf('With C = %g',C)},'FontSize',22);
legend({'C = 0', sprintf('C = %g', C)}, 'FontSize',16)

legend({'Analytical','Numerical'},'FontSize',16);

ylim([0 110]); % Adding a limit on the y-axis

xlabel('x(ft)','FontSize',16);
ylabel('y(ft)','FontSize',16);

% Exporting text files, to be used in Excel
writematrix(t,'t.txt', 'Delimiter', 'tab'); 
writematrix(xn_ft,'x2.txt', 'Delimiter', 'tab');
writematrix(yn_ft,'y2.txt', 'Delimiter', 'tab');

% ---- Comments ----
% We will now establish a relationship between Excel generated values and
% Matlab generated values. 
% The Matlab generated values are as follows: Flight time = 3.9830 seconds,
% Maximum Height attained = 65.0217 feet, and Range = 366.0736 feet.
% The Excel generated values are as follows: Flight time = 3.975 seconds,
% Maximum Height attained = 65.0217 feet, and Range = 366.0736147 feet. 
% As observable, these are the same (exlcuding minor calculatory errors)
% values for either programming system

