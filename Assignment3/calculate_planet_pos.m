function [xh, yh, zh] = calculate_planet_pos(N, i, w, a, e, M)
E = M + e * sin(M) * ( 1.0 + e * cos(M) );

xv = a * ( cos(E) - e );
yv = a * ( sqrt(1.0 - e*e) * sin(E) );

v = atan2( yv, xv );
r = sqrt( xv*xv + yv*yv );

xh = r * ( cos(N) * cos(v+w) - sin(N) * sin(v+w) * cos(i) );
yh = r * ( sin(N) * cos(v+w) + cos(N) * sin(v+w) * cos(i) );
zh = r * ( sin(v+w) * sin(i) );
end