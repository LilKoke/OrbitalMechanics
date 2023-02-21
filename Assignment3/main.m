fig_num = 1;
t = [2023 1 1 0];
for i=1:12
t(2) = t(2)+1;    
    if t(2) == 13
        t(2) = 1;
        t(1) = t(1) + 1;
    end
[fig_num pos_list] = plot_planets(t, fig_num);
end

% 保存
savefig(strcat('figure',num2str(fig_num),".fig"));
fig_num = fig_num + 1;

% 設定
% 出発時刻
launch_t = [2023 1 1 0];

% 到着時刻
arrival_t = [2024 1 1 0];

% 飛行時間
T_f = arrival_t - launch_t;

% sを求める
[fig_num pos_list] = plot_planets(launch_t, fig_num);
savefig(strcat('figure',num2str(fig_num),".fig"));
fig_num = fig_num + 1;

r_1 = norm(pos_list(1:3));

[fig_num pos_list] = plot_planets(arrival_t, fig_num);
r_2 = norm(pos_list(7:9));
savefig(strcat('figure',num2str(fig_num),".fig"));
fig_num = fig_num + 1;

c = norm(pos_list(7:9) - pos_list(1:3));

s = (r_1 + r_2 + c) / 2;

disp(s);