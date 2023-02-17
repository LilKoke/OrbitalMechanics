function plot_planets(t, fig_num)
y = t(1);
m = t(2);
D = t(3);
UT = t(4);
d = 367*y - 7 * ( y + (m+9)/12 ) / 4 + 275*m/9 + D - 730530;
d = d + UT/24.0;

%------------------------------------------------------------------
%N = longitude of the ascending node
%i = inclination to the ecliptic (plane of the Earth's orbit)
%w = argument of perihelion
%a = semi-major axis, or mean distance from Sun
%e = eccentricity (0=circle, 0-1=ellipse, 1=parabola)
%M = mean anomaly (0 at perihelion; increases uniformly with time)
%------------------------------------------------------------------
% Earth
Ne = 0.0;
ie = 0.0; 
we = deg2rad(282.9404 + 4.70935E-5 * d);
ae = 1.000000;
ee = 0.016709 - 1.151E-9 * d;
Me = deg2rad(356.0470 + 0.9856002585 * d);
[xe, ye, ze] = calculate_planet_pos(Ne, ie, we, ae, ee, Me);

% Mars
Nm = deg2rad(49.5574 + 2.11081E-5 * d);
im = deg2rad(1.8497 - 1.78E-8 * d);
wm = deg2rad(286.5016 + 2.92961E-5 * d);
am = 1.523688;
em = 0.093405 + 2.516E-9 * d;
Mm = deg2rad(18.6021 + 0.5240207766 * d);
[xm, ym, zm] = calculate_planet_pos(Nm, im, wm, am, em, Mm);

% Jupiter
Nj = deg2rad(100.4542 + 2.76854E-5 * d);
ij = deg2rad(1.3030 - 1.557E-7 * d);
wj = deg2rad(273.8777 + 1.64505E-5 * d);
aj = 5.20256;
ej = 0.048498 + 4.469E-9 * d;
Mj = deg2rad(19.8950 + 0.0830853001 * d);
[xj, yj, zj] = calculate_planet_pos(Nj, ij, wj, aj, ej, Mj);


figure(fig_num);
hold on;      % 全てのプロットを保持する
axis equal;   % x,yの縮尺を等しくする
grid on;      % gridを打つ
xlabel("x");
ylabel("y");
zlabel("z");
title("3D plot");
rs = 0.25;
[x,y,z] = sphere;
xs = x*rs;
ys = y*rs;
zs = z*rs;
surf(xs,ys,zs);
plot3(xe,ye,ze, 'o');
plot3(xm,ym,zm, 'o');
plot3(xj,yj,zj, 'o');
% カメラ視線方向の設定
view(-65,20);
end