function [v1, v2, nu1, nu2] = lambert(r1, r2, dt, mu, N)

    % 遷移角を計算
    cosdnu = dot(r1, r2) / norm(r1) / norm(r2);
    k = [0 0 1];
    sindnu = sign(dot(cross(r1, r2), k)) * sqrt(1 - cosdnu ^ 2);
    dnu = asin(sindnu);

    if dnu < 0
        dnu = dnu + 2 * pi;
    end

    % c, am, s, Tm, betamを計算
    c = sqrt(norm(r1) ^ 2 + norm(r2) ^ 2 - 2 * dot(r1, r2));
    am = (norm(r1) + norm(r2) + c) / 4;
    s = 2 * am;
    Tm = 2 * pi * sqrt(am ^ 3 / mu);
    betam = 2 * asin(sqrt((s - c) / s));

    if 2 * pi * N <= dnu <= pi * (2 * N + 1)
        dtm = N * Tm + sqrt(am ^ 3 / mu) * (pi - (betam - sin(betam)));
    elseif pi * (2 * N + 1) <= dnu <= 2 * pi * (N + 1)
        dtm = N * Tm + sqrt(am ^ 3 / mu) * (pi + (betam - sin(betam)));
    end

    % 放物線軌道での飛行時間を計算
    if 0 <= dnu && dnu <= pi
        dtp = 1/3 * sqrt(2 / mu) * (s ^ (3/2) - (s - c) ^ (3/2));
    elseif pi <= dnu && dnu <= 2 * pi
        dtp = 1/3 * sqrt(2 / mu) * (s ^ (3/2) + (s - c) ^ (3/2));
    end

    if dt > dtp
        orbit_type = "ellipse";
    elseif dt == dtp
        orbit_type = "parabola";
    else
        orbit_type = "hyperbola";
    end

    if orbit_type == "ellipse"
        [v1, v2, nu1, nu2] = calc_dv_ellipse(am, mu, s, c, dnu, norm(r1), norm(r2), r1, r2, dt, N, dtm);
    elseif orbit_type == "hyperbola"
        [v1, v2, nu1, nu2] = calc_dv_hyperbola(am, mu, s, c, dnu, norm(r1), norm(r2), r1, r2, dt);
    end

end
