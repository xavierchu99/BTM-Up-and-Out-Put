% Names of group members: Xavier Chu
function puo_val=BS_UpOut_Put(S0,X,r,T,sigma,q,H)
% step 1: set up tree parameters
lambda = (r-q+(sigma^2)/2) / sigma^2;
a = sigma * sqrt(T);
x0 = log(S0./X) / a + lambda * a;
x1 = log(S0/H) / a + lambda * a;
y0 = log((H^2)./(S0*X)) / a + lambda * a;
y1 = log(H./S0) / a + lambda * a;
% Separate into 2 cases, Case 1 being X is scalar, and Case 2 being X is
% non-scalar(i.e array with dimensions differing from 1 x 1)
% Case 1: X is scalar
if isscalar(X)
    % Case 1(i): X is less than H, then we compute the option value as per
    % the formula given with the tree parameters initialized above
    if X < H
        Puo = X*exp(-r*T).*(normcdf(-x0+a) - (H./S0).^(2*lambda-2) .* normcdf(-y0+a)) - S0*exp(-q*T).*(normcdf(-x0) - (H./S0).^(2*lambda).*normcdf(-y0));
        puo_val = Puo;
        return
    % Case 1(ii): X is greater than or equals to H, then we compute the option value as per
    % the formula given with the tree parameters initialized above
    else
        Puo = X*exp(-r*T).*(normcdf(-x1+a) - (H./S0).^(2*lambda-2) .* normcdf(-y1+a)) - S0*exp(-q*T).*(normcdf(-x1) - (H./S0).^(2*lambda).*normcdf(-y1));
        puo_val = Puo;
        return
    end
end
% Case 2: X is non-scalar(i.e X is an array with dimensions greater than
% 1x1)
% Modify the tree parameters above by subsetting the parameters according to whether (X < H) or (X >= H)
% Note: There is no need to subset x1 and y1 as they do not contain X parameter
X2i = X(X<H); x02i = x0(X<H); y02i = y0(X<H);X2ii = X(X>=H);
% Compute option prices for ranges of X < H
if any(X < H)
    Puocase2i = X2i*exp(-r*T).*(normcdf(-x02i+a) - (H./S0).^(2*lambda-2) .* normcdf(-y02i+a)) - S0*exp(-q*T).*(normcdf(-x02i) - (H./S0).^(2*lambda).*normcdf(-y02i)); 
end
% Compute option prices for ranges of X >= H
if any(X >=H)
    Puocase2ii = X2ii*exp(-r*T).*(normcdf(-x1+a) - (H./S0).^(2*lambda-2) .* normcdf(-y1+a)) - S0*exp(-q*T).*(normcdf(-x1) - (H./S0).^(2*lambda).*normcdf(-y1));
    puo_val = [Puocase2i Puocase2ii];
    return
end
puo_val = Puocase2i;
return