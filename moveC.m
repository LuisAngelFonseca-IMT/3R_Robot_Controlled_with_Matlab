function q = moveC(Z0, Z1, Z2, Y0, Y1, Y2,r)
cpts = [Z0 Z1 Z1 Z2; Y0 Y1 Y1 Y2];
tpts = [0 5];
tvec = 0:r:5;
[q, qd, qdd, pp] = bsplinepolytraj(cpts,tpts,tvec);
end
