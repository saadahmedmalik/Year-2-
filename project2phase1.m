% Saad Malik
% ECE 202 - Project 2
% Phase 1 
% Comparing the Analytic Soltution to the Numeric Solution, without Drag 
% (Including the structure required for computation of Drag)

clear;
clf;

% --- Define Given Information ---

R0 = 463; % Range of HR, in feet
v0mph = 116; % Exit velocity, in mph 
phi0deg = 28; % Launch angle, in degrees
maxheight = 100; % Maximum height in feet
flighttime = 5.3; % Flight time in seconds
m = 0.145; % Mass of a baseball in kilograms

x0 = 0; y0 = 0;
g = 9.8; % gravity force, in m/s^2

% time is in s, distance in m, speed in m/s, etc

% --- conversion factors ---

mph2mps = 5280 * 12 * 2.54 / 100 / 3600; % mph to m/s conversion
deg2rad = pi/180; % Degrees to radians
m2ft = 3.28084; % Metres to feet

% --- Conducted Calculations Regarding Conversions ---

v0mph = v0mph*mph2mps; % initial speed
phi0 = phi0deg*deg2rad; % launch angle, radians

v0x = v0mph*cos(phi0); % x-component of velocity
v0y = v0mph*sin(phi0); % y-component

% --- Compute some useful quantities for the trajectory ---

tH = v0y/g; % time to reach maxmium height
tLand = 5.3; % time to land (time of flight)

H = tH * v0y/2; % max height
R = v0x * tLand; % range

R_ft = R*m2ft; % rough conversion, range in ft

maxheightft = maxheight/m2ft;

% --- Check estimate of range ---

% Since the two trajectories are the same
% use the analytic range to compute percent error for now...

check_r_percent_error = 100*(R_ft-R0)/R0;
% Error in calculations of range of motion
error_h = 100*(H - maxheightft)/H;
% Error in calculations of maximum height
error_t = 100*(tH - flighttime)/flighttime;
% Error in calculations of total time of flight

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

    ay = -g; 
    % Treat as non-constant
    yn(n+1) = yn(n) + dt*vy + (1/2)*(dt^2)*ay; 
    % y(t+dt) = y(t) + dt*y'(t) + (1/2)*dt^2*y''(t)
    vy = vy + ay*dt; 
    % y'(t+dt) = y'(t) + dt*y''(t)

    ax = 0;
    % Initialize the force in the x-direction as 0
    xn(n+1) = xn(n) + dt*vx;
    % x(t+dt) = x(t) + dt*x'(t) + (1/2)*dt^2*x''(t)
    vx = vx + ax*dt; 
    % x'(t+dt) = x'(t) + dt*x''(t)
    
end

xa_ft = xa*m2ft;
ya_ft = ya*m2ft;
xn_ft = xn*m2ft;
yn_ft = yn*m2ft;


check_numy = sum(abs(yn-ya))  
% Compare analytic to numeric, should equate to zero
check_numx = sum(abs(xn-xa))
% Compare analytic to numeric, should equate to zero

plot(xa_ft,ya_ft,xn_ft,yn_ft,'--','LineWidth', 5)
grid on
ax = gca; ax.FontSize = 14;

xlabel('x (ft)','FontSize',16);
ylabel('y (ft)','FontSize',16);

title({'ECE 202 Project 2 - Phase 1',...
    'Analytical vs. numerical trajectory of a baseball'},'FontSize',22);

legend({'Analytical','Numerical'},'FontSize',16);