function T = transX(A)
    T = [eye(3) [A 0 0]'; 0 0 0 1];
end