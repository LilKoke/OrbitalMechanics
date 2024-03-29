function [fig_num] = plot_3Dtrajectory(x, y, z, label_x, label_y, label_z, fig_title, fig_num, color, linewidth)
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

figure(fig_num);
hold on;      % 全てのプロットを保持する
axis equal;   % x,yの縮尺を等しくする
grid on;      % gridを打つ
xlabel(label_x);
ylabel(label_y);
zlabel(label_z);
title(fig_title);

% 楕円軌道を描画
plot3(x, y, z, color, LineWidth=linewidth);

% カメラ視線方向の設定
view(-65,20);

% 保存
savefig(strcat('figure',num2str(fig_num),".fig"));
fig_num = fig_num + 1;

end