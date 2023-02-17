fig_num = 1;
t = [2023 1 1 0];
for i=1:360
t(2) = t(2)+1;    
    if t(2) == 13
        t(2) = 1;
        t(1) = t(1) + 1;
    end
plot_planets(t, fig_num);
end

% 保存
savefig(strcat('figure',num2str(fig_num),".fig"));
fig_num = fig_num + 1;