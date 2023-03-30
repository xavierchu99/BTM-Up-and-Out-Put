% Names of group members: Xavier Chu
function OptVal=btm_UpOut_Put(S0,X,r,T,sigma,q,H,N)
% step 1: set up tree parameters
dt=T./N;                       % delta t, length of time period
u=exp(sigma*sqrt(dt)); d=1./u; % up and down factors
p=(exp((r-q)*dt)-d)./(u-d);    % risk-neutral probability
% step 2: terminal condition 
jshift = 1;
% Calculating the price index of Barrier H at expiry(rounding down)
% This is done by assuming H = S0*u^(2j-n), making j the subject and
% rounding down
condition = floor(1/2 * (log(H/S0)./(sigma*sqrt(dt)) + N));
% range of index for price states below the barrier at expiry
j = 0:1:condition;   
% compute option payoffs for the range of indexes that are below the
% barrier at expiry
Vn=max(X-S0*u.^(2*j-N),0);
% Enforce option payoffs to be 0 for all price indexes that are above the
% barrier at expiry
Vn(condition+1+jshift:N+jshift) = 0;
% step 3: backward recursive through time
for n=N-1:-1:0   
   Vnp1=Vn;
   j = 0:1:n;
   % Recalculating the price index of Barrier H at every iteration(rounding
   % down)
   condition = floor(1/2 * (log(H/S0)/(sigma*sqrt(dt)) + n));
   Vn=exp(-r*dt)*(p*Vnp1(j+1+jshift)+(1-p)*Vnp1(j+jshift));
   % Enforcing option values to be 0 for all price indexes that are above
   % the barrier at each iteration
   Vn(condition+1+jshift:n+jshift) = 0;
end
% step 4: 
OptVal=Vn;