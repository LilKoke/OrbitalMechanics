mu = 3.986e5;
R = 6371;
h = 500;
T = 2 * pi * sqrt((R + h) ^ 3 / mu);
%1-1
t = T / 2;
dvy = 1/t;
dV = 2 * dvy;

