function [rv] = calculate_rv(n, rv0, num_itr, t_end)
%/*************************************************************************
%* File Name     : plot_2Dtrajectory
%* Code Title    : 平面上での軌道描画
%* Language      : Matlab
%* Version       : 1.0.0
%**************************************************************************
%* NOTE:
%*  @ input
%*    x : x座標
%*    y : y座標
%*    label_x : x座標ラベル
%*    label_y : y座標ラベル
%*    fig_title : 図のタイトル
%*************************************************************************/

    t_list = linspace(0, t_end, num_itr);
    rv = zeros(6, num_itr);
    rv(:, 1) = rv0;
    for i=2:num_itr
        t = t_list(i);
        Phi11 = [1 0 -6*(sin(n*t) - n*t); 0 cos(n*t) 0; 0 0 4-3*cos(n*t)];
        Phi21 = [0 0 6*n*(1-cos(n*t)); 0 -n*sin(n*t) 0; 0 0 3*n*sin(n*t)];
        Phi12 = [(4*sin(n*t)-3*n*t)/n 0 2*(1-cos(n*t))/n; 0 sin(n*t)/n 0; -2*(1-cos(n*t))/n 0 sin(n*t)/n];
        Phi22 = [4*cos(n*t)-3 0 2*sin(n*t); 0 cos(n*t) 0; -2*sin(n*t) 0 cos(n*t)];
        Phi = [Phi11 Phi12; Phi21 Phi22];
        rv(:, i) = Phi * rv(:, 1);
    end
end