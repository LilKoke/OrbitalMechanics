function [v1, v2, nu1, nu2] = calc_dv_hyperbola(a, mu, s, c, dnu, r1, r2, r1v, r2v)
    % 初期値を計算
    gamma = 2 * asinh(sqrt(s / (-2 * a)));
    delta = 2 * asin(sqrt((s - c) / (-2 * a)));
    dt = 1;
    dtat = 1;

    while abs(dt - dtat) > dt * 1e-5

        % dtat, dtat/daを計算
        if 0 <= dnu && dnu <= pi
            dtat = sqrt(a ^ 3 / mu) * ((sinh(gamma) - gamma) - (sinh(delta) - delta));
            dtatda = 3 * dt / (2 * a) - (s ^ 2 / sinh(gamma) - (s - c) ^ 2 / sinh(delta)) / sqrt(mu * a ^ 3);
        elseif pi <= dnu && dnu <= 2 * pi
            dtat = sqrt(a ^ 3 / mu) * ((sinh(gamma) - gamma) + (sinh(delta) - delta));
            dtatda = 3 * dt / (2 * a) - (s ^ 2 / sinh(gamma) + (s - c) ^ 2 / sinh(delta)) / sqrt(mu * a ^ 3);
        end

        % aを更新
        a = a + (dt - dtat) / dtatda;
    end

    % pを計算する
    if 0 <= dnu && dnu <= pi
        p = 4 * a * (s - r1) * (s - r2) / c ^ 2 * sin((gamma + delta) / 2) ^ 2;
    elseif pi <= dnu && dnu <= 2 * pi
        p = 4 * a * (s - r1) * (s - r2) / c ^ 2 * sin((gamma - delta) / 2) ^ 2;
    end

    % eを計算する
    e = sqrt(1 + p / a);

    % 真近点離角を計算する
    if (0 < dnu && dnu < pi) || (pi < dnu && dnu < 2 * pi)
        cosnu1 = (p - r1) / (e * r1);
        nu1 = asin((cosnu1 * cos(dnu) - (p - r2) / (e * r2)) / sin(dnu));
        nu2 = nu1 + dnu;
    elseif dnu == 0 || dnu == 2 * pi
        nu1 = pi;
        nu2 = pi;
    else
        nu1 = acos((p - r1) / (e * r1));

        if dt == dtm

            if r1 < r2
                nu1 = 0;
            elseif r1 >= r2
                nu1 = pi;
            end

        elseif dt < dtm

            if r1 > r2
                nu1 = nu1 + pi;
            end

        elseif dt > dtm

            if r1 < r2
                nu1 = nu1 + pi;
            end

        end

    end

    % ラグランジュの係数を計算する
    ginv = sqrt(mu * p) / (r1 * r2 * sin(dnu));
    f = 1 - r2 / p * (1 - cos(dnu));
    gdot = 1 - r1 / p * (1 - cos(dnu));

    % 二点P, Qでの速度ベクトルを計算する。
    v1 = (r2v - f * r1v) * ginv;
    v2 = (gdot * r2v - r1v) * ginv;
end
