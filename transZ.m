function T = transZ(A)
    T = [eye(3) [0 0 A]'; 0 0 0 1];
end