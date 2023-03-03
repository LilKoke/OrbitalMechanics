function [v1, v2, nu1, nu2] = calc_dv_ellipse(am, mu, s, c, dnu, r1, r2, r1v, r2v, dt, N, dtm)
    % 初期値を計算
    a = 1.1 * am;
    T = 2 * pi * sqrt(a ^ 3 / mu);
    alpha = 2 * asin(sqrt(s / (2 * a)));
    beta = 2 * asin(sqrt((s - c) / (2 * a)));
    dtat = 367 / 3.1688087814029E-08;

    while (abs(dt - dtat) > (dt * 1e-5))
        % dtat, dtat/daを計算
        if 2 * pi * N <= dnu && dnu <= pi * (2 * N + 1)

            if dt < dtm
                dtat = N * T + sqrt(a ^ 3 / mu) * ((alpha - sin(alpha)) - (beta - sin(beta)));
                dtatda = 3 * T / (2 * a) * N + 3 * dtat / (2 * a) - (s ^ 2 / sin(alpha) - (s - c) ^ 2 / sin(beta)) / sqrt(mu * a ^ 3);
            elseif dt > dtm
                dtat = (N + 1) * T - sqrt(a ^ 3 / mu) * ((alpha - sin(alpha)) + (beta - sin(beta)));
                dtatda = 3 * T / (2 * a) * (N + 1) + 3 * dtat / (2 * a) + (s ^ 2 / sin(alpha) + (s - c) ^ 2 / sin(beta)) / sqrt(mu * a ^ 3);
            end

        elseif pi * (2 * N + 1) <= dnu && dnu <= 2 * pi * (N + 1)
            if dt < dtm
                dtat = N * T + sqrt(a ^ 3 / mu) * ((alpha - sin(alpha)) + (beta - sin(beta)));
                dtatda = 3 * T / (2 * a) * N + 3 * dtat / (2 * a) - (s ^ 2 / sin(alpha) + (s - c) ^ 2 / sin(beta)) / sqrt(mu * a ^ 3);
            elseif dt > dtm
                dtat = (N + 1) * T - sqrt(a ^ 3 / mu) * ((alpha - sin(alpha)) - (beta - sin(beta)));
                dtatda = 3 * T / (2 * a) * (N + 1) + 3 * dtat / (2 * a) + (s ^ 2 / sin(alpha) - (s - c) ^ 2 / sin(beta)) / sqrt(mu * a ^ 3);
            end

        end

        % aを更新
        a = a + (dt - dtat) / dtatda;
        T = 2 * pi * sqrt(a ^ 3 / mu);
        alpha = 2 * asin(sqrt(s / (2 * a)));
        beta = 2 * asin(sqrt((s - c) / (2 * a)));
    end

    % pを計算する
    if 2 * pi * N <= dnu && dnu <= pi * (2 * N + 1)

        if dt < dtm
            p = 4 * a * (s - r1) * (s - r2) / c ^ 2 * sin((alpha + beta) / 2) ^ 2;
        elseif dt > dtm
            p = 4 * a * (s - r1) * (s - r2) / c ^ 2 * sin((alpha - beta) / 2) ^ 2;
        end

    elseif pi * (2 * N + 1) <= dnu && dnu <= 2 * pi * (N + 1)

        if dt < dtm
            p = 4 * a * (s - r1) * (s - r2) / c ^ 2 * sin((alpha - beta) / 2) ^ 2;
        elseif dt > dtm
            p = 4 * a * (s - r1) * (s - r2) / c ^ 2 * sin((alpha + beta) / 2) ^ 2;
        end

    end

    % eを計算する
    e = sqrt(1 - p / a);
    

    % 真近点離角を計算する
    if (0 < dnu && dnu < pi) || (pi < dnu && dnu < 2 * pi)
        cosnu1 = dot(r1v, r2v) / (r1 * r2);
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
