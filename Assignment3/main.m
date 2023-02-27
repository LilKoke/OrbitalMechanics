mu = 1.327e11;

fig_num = 1;
t = [2023 1 1];

for i = 1:12
    t(2) = t(2) + 1;

    if t(2) == 13
        t(2) = 1;
        t(1) = t(1) + 1;
    end

    [fig_num pos_list] = plot_planets(juliandate(t), fig_num);
end

% 保存
savefig(strcat('figure', num2str(fig_num), ".fig"));
fig_num = fig_num + 1;

% 設定
% 出発時刻
best_dv = inf;
for i = 1:12
    for j = i+1:12
        launch_t = juliandate([2023 i 1]);
        arrival_t = juliandate([2023 j 1]);
        % 飛行時間
        dt = arrival_t - launch_t;
        r1 = calculate_earth_pos(launch_t);
        r2 = calculate_mars_pos(arrival_t);
        N = 0;
        [v1, v2, nu1, nu2] = lambert(r1, r2, dt, mu, N);
        dv = norm(v1) + norm(v2);
        if dv < best_dv
            best_dv = dv;
            best_launch_t = launch_t;
            best_arrival_t = arrival_t;
        end
    end
end


% r1, r2を求める
[fig_num, pos_list] = plot_planets(launch_t, fig_num);
savefig(strcat('figure', num2str(fig_num), ".fig"));
fig_num = fig_num + 1;

[fig_num, pos_list] = plot_planets(arrival_t, fig_num);
savefig(strcat('figure', num2str(fig_num), ".fig"));
fig_num = fig_num + 1;


