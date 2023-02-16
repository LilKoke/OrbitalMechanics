function [best_tb, best_dV, best_dV1, best_dV2] = calculate_best_tb(n, rv, ratio, num_itr, T)
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
    num_tb = 1000;
    eps = 1e-5;
    tb_list = linspace(0+eps, T/2-eps, num_tb);
    best_dV = inf;
    targetrv = rv(:, ratio*num_itr);
    r0 = [0; 0; 0];
    for i=1:num_tb
        t = T / 2 - tb_list(i);
        
        Phi12 = [(4*sin(n*t)-3*n*t)/n 0 2*(1-cos(n*t))/n; 0 sin(n*t)/n 0; -2*(1-cos(n*t))/n 0 sin(n*t)/n];
        Phi22 = [4*cos(n*t)-3 0 2*sin(n*t); 0 cos(n*t) 0; -2*sin(n*t) 0 cos(n*t)];
        v0xyz = Phi12\targetrv(1:3);
        dV1 = v0xyz;
        dV2 = targetrv(4:6) - Phi22 * v0xyz;
        dV = norm(dV1) + norm(dV2);
        if best_dV > dV
            best_idx = i;
            best_dV = dV;
            best_dV1 = dV1;
            best_dV2 = dV2;
            best_tb = tb_list(best_idx);
        end
    end
end