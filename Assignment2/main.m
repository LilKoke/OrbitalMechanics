%/*************************************************************************
%* File Name     : main.m
%* Code Title    : 課題2: 2体問題の軌道運動の計算
%* Programmer    : Koki Hirano
%* Creation Date : 2023/02/14
%* Language      : Matlab
%* Version       : 1.0.0
%**************************************************************************

clear variables; close all; 

ref.mu = 3.986e5;
ref.R = 6371;
ref.h = 500;

fig_num = 1;
T = 2 * pi * sqrt((ref.R + ref.h) ^ 3 / ref.mu);

%1-1
n = 2 * pi / T;
t = T / 2;
nt = pi;
num_itr = 1000;
t_list = linspace(0, t, num_itr);

targetxz = [1; 0];
Phixz = [(4*sin(nt)-3*nt)/n 2*(1-cos(nt))/n; -2*(1-cos(nt))/n sin(nt)/n];
v0xz = Phixz\targetxz;

rv = zeros(6, num_itr);
rv(:,1) = [0; 0; 0; v0xz(1); 0; v0xz(2)];
for i=2:num_itr
    t = t_list(i);
    Phi11 = [1 0 -6*(sin(n*t) - n*t); 0 cos(n*t) 0; 0 0 4-3*cos(n*t)];
    Phi21 = [0 0 6*n*(1-cos(n*t)); 0 -n*sin(n*t) 0; 0 0 3*n*sin(n*t)];
    Phi12 = [(4*sin(n*t)-3*n*t)/n 0 2*(1-cos(n*t))/n; 0 sin(n*t)/n 0; -2*(1-cos(n*t))/n 0 sin(n*t)/n];
    Phi22 = [4*cos(n*t)-3 0 2*sin(n*t); 0 cos(n*t) 0; -2*sin(n*t) 0 cos(n*t)];
    Phi = [Phi11 Phi12; Phi21 Phi22];
    rv(:, i) = Phi * rv(:, 1);
end

x_list = rv(1, :);
z_list = rv(3, :);
x_label = "x [km]";
z_label = "z [km]";
fig_title = "Trajectory (XZ Plane)";
fig_num = plot_2Dtrajectory(x_list, z_list, x_label, z_label, fig_title, ref, fig_num);

