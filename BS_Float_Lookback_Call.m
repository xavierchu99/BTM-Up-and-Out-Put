% Names of group members: Xavier Chu
function optval=BS_Float_Lookback_Call(S0,r,T,sigma,q,S_min)
% Conversion of exact formula to code
% Taking the minimum of the running minimum thus far and the current
% underlier price
Smin = min(S_min,S0);
% Establishing parameters of the exact formula
a1 = (log(S0./Smin) + (r-q+sigma^2/2)*T ) / ( sigma*sqrt(T) );
a2 = a1 - sigma*sqrt(T);
a3 = (log(S0./Smin) + (-r+q+sigma^2/2)*T ) / ( sigma*sqrt(T) );
y1 = -(2*(r-q-sigma^2/2) * log(S0./Smin) ) / sigma^2;
% Compute option value with the formula
optval = S0*exp(-q*T)*normcdf(a1) - S0*exp(-q*T)*sigma^2/(2*(r-q))*normcdf(-a1) - Smin*exp(-r*T).*(normcdf(a2)-sigma^2/(2*(r-q))*exp(y1).*normcdf(-a3));
end
