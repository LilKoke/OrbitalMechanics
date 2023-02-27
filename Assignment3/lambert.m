function [v1, v2, nu1, nu2] = lambert(r1, r2, dt)

    % 遷移角を計算
    dnu = acos(dot(r1, r2) / norm(r1) / norm(r2));

    % c, am, s, Tm, betamを計算
    c = sqrt(norm(r1) ^ 2 + norm(r2) ^ 2 - 2 * dot(r1, r2));
    am = (norm(r1) + norm(r2) + c) / 4;
    s = 2 * am;
    % Tm = 2 * PI * sqrt(am^3 / r);
    betam = 2 * asin(sqrt((s - c) / s));

    % 放物線軌道での飛行時間を計算
    if 0 <= dnu && dnu <= deg2rad(180)
        dtp = 1/3 * sqrt(2 / mu) * (s ^ (3/2) - (s - c) ^ (3/2));
    elseif deg2rad(180) <= dnu && dnu <= deg2rad(360)
        dtpt = 1/3 * sqrt(2 / mu) * (s ^ (3/2) + (s - c) ^ (3/2));
    end

    if dt > dtp
        orbit_type = "ellipse";
    elseif dt == dtp
        orbit_type = "parabola";
    else
        orbit_type = "hyperbola";
    end

    if orbit_type == "ellipse"
        [v1, v2, nu1, nu2] = calc_dv_ellipse(am, mu, s, c, dnu, norm(r1), norm(r2), r1, r2);
    elseif orbit_type == "hyperbola"
        [v1, v2, nu1, nu2] = calc_dv_hyperbola(am, mu, s, c, dnu, norm(r1), norm(r2), r1, r2);
    end

end
