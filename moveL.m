function [q,qd] = moveL(Z0, Z1, Y0, Y1, r)
wpts = [Z0 Z1; Y0 Y1];
tpts = [0 5];
tvec = 0:r:5;

[q, qd, qdd, pp] = cubicpolytraj(wpts, tpts, tvec);
end
