% Names of group members: Xavier Chu
function optval=btm_Eur_Lookback_Call(S0,r,T,sigma,q,running_minimum,N)
% For previously issued options with runningmin lower than S0 at t0
% Note: Wn is not the actual option value, to obtain actual option value,
% multiply final value of Wn by S0
% step 1: set up tree parameters
x0 = log(running_minimum/S0); % Note: x0 < 0 since runningmin < S0
dt = T/N; dx = sigma*sqrt(dt); % delta t, length of time period
u = exp(dx); d = 1/u; % up and down factors
p = (exp((r-q)*dt) - d) / (u - d); % risk-neutral probability
% step 2: terminal condition
j = floor(x0/-dx); 
% Establishing range of price indexes at expiry
k=max(j-N,0):1:j+N+1;
% Calculating option payoffs with range of indexes
Wn = 1-exp(-k*dx);
jshift = 1;
% step 3: backward recursive through time
for n = N-1:-1:0
    Wnp1 = Wn;
    % Establishing option value at boundary cases if there exists boundary
    % cases at current iteration
    if n>= j
        Wn(jshift) = exp(-r*dt)*(p*u*Wnp1(jshift+1)+(1-p)*d*Wnp1(jshift));
    end
    % Establishing option values at non-boundary cases at current iteration
    % by performing backward recursive
    for k = max(j-n,1):1:j+n+1
        Wn(k+jshift) = exp(-r*dt)*(p*u*Wnp1(jshift+k+1)+(1-p)*d*Wnp1(jshift+k-1));
    end
end
% Interpolation
alpha0 = j+1 - (x0/-dx); alpha1 = (x0/-dx) - j;
optval = alpha0*S0*Wn(j+jshift) + alpha1*S0*Wn(j+1+jshift);
end