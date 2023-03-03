%/*************************************************************************
%* File Name     : main.m
%* Code Title    : 課題2-1: レコード盤軌道
%* Programmer    : Koki Hirano
%* Creation Date : 2023/02/16
%* Language      : Matlab
%* Version       : 1.0.0
%**************************************************************************

clear variables; close all; 

mu = 3.986e5;
R = 6371;
h = 500;

fig_num = 1;
T = 2 * pi * sqrt((R + h) ^ 3 / mu);

%1-1*************************
n = 2 * pi / T;
t = T / 2;
nt = pi;
num_itr = 3000;


targetxz = [1; 0];
Phixz = [(4*sin(nt)-3*nt)/n 2*(1-cos(nt))/n; -2*(1-cos(nt))/n sin(nt)/n];
v0xz = Phixz\targetxz;

rv0_1 = [0; 0; 0; v0xz(1); 0; v0xz(2)];
rv1 = calculate_rv(n, rv0_1, num_itr, T/2);

x_list = rv1(1, :);
z_list = rv1(3, :);
x_label = "x [km]";
z_label = "z [km]";
fig_title = "Trajectory (XZ Plane)";
fig_num = plot_2Dtrajectory(x_list, z_list, x_label, z_label, fig_title, fig_num);


%1-2*************************
targetxz = [-2; 0];
Phixz = [(4*sin(nt)-3*nt)/n 2*(1-cos(nt))/n; -2*(1-cos(nt))/n sin(nt)/n];
v0xz2 = Phixz\targetxz;

rv0_2 = [1; 0; 0; v0xz2(1); 0; v0xz2(2)];
rv2 = calculate_rv(n, rv0_2, num_itr, T/2);

x_list = [x_list rv2(1, :)];
z_list = [z_list rv2(3, :)];
x_label = "x [km]";
z_label = "z [km]";
fig_title = "Trajectory (XZ Plane)";
fig_num = plot_2Dtrajectory(x_list, z_list, x_label, z_label, fig_title, fig_num);

%1-3*************************
v0y = sqrt(n^2 - (n + 2*v0xz2(2))^2 -v0xz2(2)^2);
rv0_3 = [1; 0; 0; v0xz2(1); v0y; v0xz2(2)];
rv3 = calculate_rv(n, rv0_3, num_itr, T/2);

x_list = [rv3(1, :)];
y_list = [rv3(2, :)];
x_label = "x [km]";
y_label = "y [km]";
fig_title = "Trajectory (XY Plane)";
fig_num = plot_2Dtrajectory(x_list, y_list, x_label, y_label, fig_title, fig_num);

%1-4*************************

rv0_circ = [1; 0; 0; v0xz2(1); v0y; v0xz2(2)];
rv_circ = calculate_rv(n, rv0_circ, num_itr, T);
[best_tB, best_dV_B, best_dV1_B, best_dV2_B] = calculate_best_tb(n, rv_circ, 1/3, num_itr, T);
disp("t_B:" + best_tB);
disp("dV_B:" + best_dV_B);

%1-5*************************
[best_tC, best_dV_C, best_dV1_C, best_dV2_C] = calculate_best_tb(n, rv_circ, 2/3, num_itr, T);

rvA1 = rv1;
rvA2 = rv_circ(:,1:num_itr/6);

rv0_B = [0; 0; 0; best_dV1_B(1); best_dV1_B(2); best_dV1_B(3)];
rvB1 = calculate_rv(n, rv0_B, num_itr, T/2 - best_tB);
rv1_B = rvB1(:, num_itr) + [0; 0; 0; best_dV2_B(1); best_dV2_B(2); best_dV2_B(3)];
rvB2 = calculate_rv(n, rv1_B, num_itr, T/6);

rv0_C = [0; 0; 0; best_dV1_C(1); best_dV1_C(2); best_dV1_C(3)];
rvC1 = calculate_rv(n, rv0_C, num_itr, T/2 - best_tC);
rv1_C = rvC1(:, num_itr) + [0; 0; 0; best_dV2_C(1); best_dV2_C(2); best_dV2_C(3)];
rvC2 = calculate_rv(n, rv1_C, num_itr, T/6);

% t=T/2からt=2/3Tまでのプロット
x_label = "x [km]";
y_label = "y [km]";
z_label = "z [km]";
fig_title = "Trajectory (XYZ Space) (t = T/2 ~ 2/3T)";

linex1 = [rvA2(1, 1) rvB2(1,1) rvC2(1,1) rvA2(1, 1)];
liney1 = [rvA2(2, 1) rvB2(2,1) rvC2(2,1) rvA2(2, 1)];
linez1 = [rvA2(3, 1) rvB2(3,1) rvC2(3,1) rvA2(3, 1)];

linex2 = [rvA2(1, num_itr/6) rvB2(1,num_itr) rvC2(1,num_itr) rvA2(1, num_itr/6)];
liney2 = [rvA2(2, num_itr/6) rvB2(2,num_itr) rvC2(2,num_itr) rvA2(2, num_itr/6)];
linez2 = [rvA2(3, num_itr/6) rvB2(3,num_itr) rvC2(3,num_itr) rvA2(3, num_itr/6)];

fig_num = plot_3Dtrajectory(rvA2(1, :), rvA2(2, :), rvA2(3, :), x_label, y_label, z_label, fig_title, fig_num, "red", 1);
fig_num = plot_3Dtrajectory(rvB2(1, :), rvB2(2, :), rvB2(3, :), x_label, y_label, z_label, fig_title, fig_num-1, "blue", 1);
fig_num = plot_3Dtrajectory(rvC2(1, :), rvC2(2, :), rvC2(3, :), x_label, y_label, z_label, fig_title, fig_num-1, "green", 1);
fig_num = plot_3Dtrajectory(linex1, liney1, linez1, x_label, y_label, z_label, fig_title, fig_num-1, "black", 0.5);
fig_num = plot_3Dtrajectory(linex2, liney2, linez2, x_label, y_label, z_label, fig_title, fig_num-1, "black", 0.5);

% t=0からt=2/3Tまでのプロット
rvA = [rvA1 rvA2];
rvB = [rvB1 rvB2];
rvC = [rvC1 rvC2];
x_label = "x [km]";
y_label = "y [km]";
z_label = "z [km]";
fig_title = "Trajectory (XYZ Space) (t = 0 ~ 2/3T)";
fig_num = plot_3Dtrajectory(rvA(1, :), rvA(2, :), rvA(3, :), x_label, y_label, z_label, fig_title, fig_num, "red", 1);
fig_num = plot_3Dtrajectory(rvB(1, :), rvB(2, :), rvB(3, :), x_label, y_label, z_label, fig_title, fig_num-1, "blue", 1);
fig_num = plot_3Dtrajectory(rvC(1, :), rvC(2, :), rvC(3, :), x_label, y_label, z_label, fig_title, fig_num-1, "green", 1);