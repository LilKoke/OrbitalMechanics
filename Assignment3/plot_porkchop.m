function fig_num = plot_porkchop(X, Y, dv_matrix, fig_num)
    figure(fig_num);
    hold on; % 全てのプロットを保持する
    axis equal; % x,yの縮尺を等しくする
    grid on; % gridを打つ
    xlabel("x");
    ylabel("y");
    title("3D plot");
    alt_list = linspace(50, 80, 30);
    contour(X, Y, dv_matrix, alt_list);
end