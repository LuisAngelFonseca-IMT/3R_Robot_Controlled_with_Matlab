function [px, py, pz] = computeDGM(TH1, TH2, TH3)
q1 = pi/180*TH1;
q2 = pi/180*TH2;
q3 = pi/180*TH3;

T1 = rotZ(q1)*transZ(9)*rotX(pi/2)*transX(0);
T2 = rotZ(q2)*transZ(0)*rotX(0)*transX(17);
T3 = rotZ(q3)*transZ(0)*rotX(0)*transX(15.8);
Tn = (T1*T2*T3)*[0 0 0 1]';

px = Tn(1);
py = Tn(2);
pz = Tn(3);

end
