function fig_num = plot_porkchop(X, Y, dv_matrix, fig_num)
    figure(fig_num);
    hold on; % 全てのプロットを保持する
    axis equal; % x,yの縮尺を等しくする
    grid on; % gridを打つ
    xlabel("launch date (2024/01/01 ~ 2025/12/01)");
    ylabel("flight time (~500 days)");
    title("porkchop plot");
    alt_list = linspace(0, 100, 25);
    contourf(X, Y, dv_matrix, alt_list)
    colorbar
end
