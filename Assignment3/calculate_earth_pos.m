function pos_list = calculate_earth_pos(d)
    % Earth
    Ne = 0.0;
    ie = 0.0;
    we = deg2rad(282.9404 +4.70935E-5 * d);
    ae = 1.000000;
    ee = 0.016709 -1.151E-9 * d;
    Me = deg2rad(356.0470 + 0.9856002585 * d);
    [xe, ye, ze] = calculate_planet_pos(Ne, ie, we, ae, ee, Me);

    pos_list = [xe ye ze];
end
