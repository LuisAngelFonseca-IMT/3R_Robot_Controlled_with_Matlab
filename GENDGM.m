function T0n = GENDGM( a, alpha, d, theta, joints, q) 

    n = length(a);
    x1 = 0;
    y1 = 0;
    z1 = 0;
    
    x2 = 0;
    y2 = 0;
    z2 = 0;
    
    for i = 1:n        
        T(:,:,i) = rotZ(theta(i))*transZ(d(i))*rotX(alpha(i))*transX(a(i))
        
        if joints(i) == 0 %Revolute
            T2(:,:,i) = rotZ(theta(i)+q(i))*transZ(d(i))*rotX(alpha(i))*transX(a(i))
        else
            T2(:,:,i) = rotZ(theta(i))*transZ(d(i)+q(i))*rotX(alpha(i))*transX(a(i))
        end
    end
    
    T0n = eye(4);
    T0n2 = eye(4);
    
    for i = 1:n
        T0n = T0n*T(:,:,i);
        T0n2 = T0n2*T2(:,:,i);
        hold on
        if joints(i) == 0
            f = "o";
        else
            f = "s";
        end
        plot3(T0n(1,4),T0n(2,4), T0n(3,4),f)
        plot3([x1, T0n(1,4)],[y1, T0n(2,4)],[z1, T0n(3,4)])
        x1 = T0n(1,4);
        y1 = T0n(2,4);
        z1 = T0n(3,4);
        
        plot3(T0n2(1,4),T0n2(2,4), T0n2(3,4),f)
        plot3([x2, T0n2(1,4)],[y2, T0n2(2,4)],[z2, T0n2(3,4)])
        x2 = T0n2(1,4);
        y2 = T0n2(2,4);
        z2 = T0n2(3,4);
        
        
        grid on
    end
end