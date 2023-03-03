function dx=state_equation(t,x)
rho = 3.054e-6;
l = 1.010;
r1 = sqrt((x(1)+l+rho)^2 + x(2)^2 + x(3)^2);
r2 = sqrt((x(1)+l-1+rho)^2 + x(2)^2 + x(3)^2);
A = [0 0 0 1 0 0;
    0 0 0 0 1 0;
    0 0 0 0 0 1;
    (-(1-rho)/(r1^3)-rho/(r2^3)+1) 0 0 0 2 0;
    0 (-(1-rho)/(r1^3)-rho/(r2^3)+1) 0 -2 0 0;
    0 0 (-(1-rho)/(r1^3)-rho/(r2^3)) 0 0 0];
B = [0; 0; 0; (l-(1-rho)*(l+rho)/r1^3-rho*(l-1+rho)/r2^3); 0; 0];
dx = A*x + B;
end