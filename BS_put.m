% Names of group members: Xavier Chu
% Black-Scholes formula for European vanilla put
% put syntax: p = BS_put(S0, X, r, T, sigma, q)
function  p = BS_put(S0, X, r, T, sigma, q)
d1=(log(S0./X)+(r-q+sigma^2/2)*T)/sigma/sqrt(T);
d2=d1-sigma*sqrt(T);
p=exp(-r*T)*(X.*normcdf(-d2))-exp(-q*T)*S0.*normcdf(-d1);
return