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

% r1, r2を求める
[fig_num pos_list] = plot_planets(launch_t, fig_num);
savefig(strcat('figure',num2str(fig_num),".fig"));
fig_num = fig_num + 1;

r1 = pos_list(1:3);

[fig_num pos_list] = plot_planets(arrival_t, fig_num);
r_2 = pos_list(7:9);
savefig(strcat('figure',num2str(fig_num),".fig"));
fig_num = fig_num + 1;

% 遷移角を計算
dnu = dot(r1, r2) / norm(r1) / norm(r2);

% c, am, s, Tm, betamを計算
c = sqrt(norm(r1)^2 + norm(r2)^2 - 2 * dot(r1, r2))
am - (norm(r1) + norm(r2) + c) / 4;
s = 2 * am;
Tm = 2 * PI * sqrt(am^3 / r);
betam = 2 * asin(sqrt((s - c) / s));

% 最小エネルギー楕円軌道での飛行時間を計算する
if 360 * N <= dnu && dnu <= 180 * (2 * N + 1)
    dtm = N * Tm + sqrt(am^3 / nu) * (pi - (betam - sin(betam)));
elseif 180 * (2 * N + 1) <= dnu && dnu <= 360  * (N + 1)
    dtm = N * Tm + sqrt(am^3 / nu) * (pi + (betam - sin(betam)));