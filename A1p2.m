% Names of group members: Xavier Chu

% (ii)
S0=1.2;r=0.05;T=0.25;sigma=0.37;q=0.01;
runningmin=0.8:0.025:1.6;
BSfloatlbcallII = BS_Float_Lookback_Call(S0,r,T,sigma,q,runningmin)

% Graph 1
plot(runningmin,BSfloatlbcallII, 'r*-');
title('BS prices for European floating strike lookback call')
xlabel('Running Minimums($)')
ylabel('Option Prices($)')

% (iii)
BTMfloatlbcallIII = zeros(1,12);
runningminiii = 1;
N=[1000:1000:10000 15000 20000];
numprices = 12;
for n=1:numprices
    timesteps = N(n);
    BTMfloatlbcallIII(n) = btm_Eur_Lookback_Call(S0,r,T,sigma,q,runningminiii,timesteps);
end
BTMfloatlbcallIII

BSfloatlbcallIII = BS_Float_Lookback_Call(S0,r,T,sigma,q,runningminiii)

% Graph 2
figure;
plot(N,BTMfloatlbcallIII,'r*-')
hold on;
yline(BSfloatlbcallIII,'b*-')
title('European floating strike lookback call')
xlabel('Time Steps(N)')
ylabel('Option Prices($)')
legend('BTM prices for float lookback call','BS prices for float lookback call')

% (iv)
BTMAMfloatlbcallIV = zeros(1,12);
for n=1:numprices
    timesteps = N(n);
    BTMAMfloatlbcallIV(n) = btm_Am_Lookback_Call(S0,r,T,sigma,q,runningminiii,timesteps);
end
BTMAMfloatlbcallIV

% Graph 3
figure;
plot(N,BTMAMfloatlbcallIV,'g*-')
title('BTM for American floating strike lookback call')
xlabel('Time Steps(N)')
ylabel('Option Prices($)')




