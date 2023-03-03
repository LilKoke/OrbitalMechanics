function pos_list = calculate_mars_pos(d)
    % Mars
    Nm = deg2rad(49.5574 +2.11081E-5 * d);
    im = deg2rad(1.8497 -1.78E-8 * d);
    wm = deg2rad(286.5016 +2.92961E-5 * d);
    am = 1.523688;
    em = 0.093405 +2.516E-9 * d;
    Mm = deg2rad(18.6021 + 0.5240207766 * d);
    [xm, ym, zm] = calculate_planet_pos(Nm, im, wm, am, em, Mm);

    pos_list = [xm ym zm] * 1.496e8;
end
