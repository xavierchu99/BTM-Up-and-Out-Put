% Names of group members: Xavier Chu

% (ii)
r = 0.02; T = 0.5; sigma = 0.35; q = 0.03; H = 1.3; S = 1;
X = 0.9:0.05:1.5;
BSpuoII = BS_UpOut_Put(S,X,r,T,sigma,q,H)

% Graph 1
plot(X,BSpuoII,'r*-')
title('Option Prices versus Strike Prices(Fixed underlying of $1)')
xlabel('Strike Prices($)')
ylabel('Option Prices($)')
hold on

% (iii)
BSputIII = BS_put(S,X,r,T,sigma,q)

% 2nd plot on Graph 1
plot(X,BSputIII, 'b*-')
legend('European Up-and-Out Put','European Vanilla Put')

% (iv)
XIV = 1.2; SIV = 0.8:0.05:1.3;
BSpuoIV = BS_UpOut_Put(SIV,XIV,r,T,sigma,q,H)
BSputIV = BS_put(SIV,XIV,r,T,sigma,q)

% Graph 2
figure;
hold on
plot(SIV,BSpuoIV, 'g*-')
plot(SIV,BSputIV, 'b*-')
title('Option Prices vs Underlying Stock Prices(Fixed strike of $1.2)')
xlabel('Underlying Stock Prices($)')
ylabel('Option Prices($)')
legend('European Up-and-Out Put','European Vanilla Put')

% (v)
N = [1000 2000 4000 8000 16000 32000];
numprices = 6;
BTMpuoV = zeros(1,6);
for n=1:numprices
    BTMpuoV(n) = btm_UpOut_Put(S,XIV,r,T,sigma,q,H,N(n));
end
BTMpuoV

BSpuoV= BS_UpOut_Put(S,XIV,r,T,sigma,q,H)
errors = abs(BSpuoV - BTMpuoV)

% Graph 3
figure;
plot(N, errors, 'r*-')
title('BS vs BTM Up-and-Out Put Errors')
xlabel('Time Steps(N)')
ylabel('Absolute Errors($)')

% (vi)(a)
i = floor(log(H/S)./(sigma*sqrt(T./N)))

% (b)
u = exp(sigma*sqrt(T./N));
distance = abs(S*u.^i - H)

% (c)
% Using Boyle and Lau
improvedN = floor(T*((i*sigma)/log(H/S)).^2)

% (d)
uPARTD = exp(sigma*sqrt(T./improvedN));
distanceD = abs(S*uPARTD.^i - H)

% (e)
tableE = table(i',N',distance',improvedN',distanceD', 'VariableNames',{'i','Original Values of N','Original Distance from level i to barrier','Improved Values of N','Improved Distances from level i to barrier'})

% (vii)
BTMpuoVII = zeros(1,6);
for n=1:numprices
    BTMpuoVII(n) = btm_UpOut_Put(S,XIV,r,T,sigma,q,H,improvedN(n));
end
BTMpuoVII

newerrors = abs(BSpuoV - BTMpuoVII)

% Graph 4
figure;
plot(improvedN, newerrors, 'r*-')
title('BS vs BTM Up-and-Out Put Errors("improved" N)')
xlabel('Time Steps(N)')
ylabel('Absolute Errors($)')

