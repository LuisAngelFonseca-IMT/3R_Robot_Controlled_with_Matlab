function [x, idx] = compute_IGM(PX, PY, PZ, actual1, actual2, actual3)

% Ecuation 1 from DGM            
% PX*sin(q1) - PY*cos(q1) = 0   (TYPE 2)
% Compute theta 1
X = PX;
Y = -PY;
Z = 0;

theta1(1)= atan2(-Y,X);
theta1(2) = theta1(1)+pi;

% Save 4 solutions for Theta 1 in Degrees
th1d(1) = (atan2(-Y,X))*180/pi;
th1d(2) = (atan2(-Y,X))*180/pi;
th1d(3) = (atan2(-Y,X)+pi)*180/pi;
th1d(4) = (atan2(-Y,X)+pi)*180/pi;
clear X Y Z 

% Ecuations 2 & 3 from DGM
% PZ - 9 = (15*sin(q2 + q3))/2 + 17*sin(q2)
% PX*cos(q1) + PY*sin(q1) = (15*cos(q2 + q3))/2 + 17*cos(q2)
% Compute theta 2 % theta 3
X = 17;
Y = 79.000000001/5; %Tolerance
Z2 = PZ - 9;

stop = 0;

% Compute 2 posibles cosines of theta 3
for i=1:2
    Z1 = PX*cos(theta1(i)) + PY*sin(theta1(i));
    C3(i) = ((Z1^2)+(Z2^2)-(X^2)-(Y^2))/(2*X*Y);
    
    if C3(i)> 1.0 || C3(i)< -1.0
        stop = 1;
    end
end

if stop == 0
    
    
    % Compute 4 posible solutions
    theta3(1)=atan2(sqrt(1-(C3(1)^2)),C3(1));
    theta3(2)=atan2(-sqrt(1-(C3(1)^2)),C3(1));
    theta3(3)=atan2(sqrt(1-(C3(2)^2)),C3(2));
    theta3(4)=atan2(-sqrt(1-(C3(2)^2)),C3(2));
    
    % Save solutions theta 3
    th3d(1) = theta3(1)*180/pi;
    th3d(2) = theta3(2)*180/pi;
    th3d(3) = theta3(3)*180/pi;
    th3d(4) = theta3(4)*180/pi;
    
    % Computation of theta 2.1
    Z1 = PX*cos(theta1(1)) + PY*sin(theta1(1));
    B1=X+(Y*cos(theta3(1)));
    B2= Y*sin(theta3(1));
    S2= ((B1*Z2)-(B2*Z1))/((B1^2)+(B2^2));
    C2= ((B1*Z1)+(B2*Z2))/((B1^2)+(B2^2));
    theta2(1) =atan2(S2,C2);
    
    th2d(1) = theta2(1)*180/pi;
    
    % Computation of theta 2.2
    Z1 = PX*cos(theta1(1)) + PY*sin(theta1(1));
    B1=X+(Y*cos(theta3(2)));
    B2= Y*sin(theta3(2));
    S2= ((B1*Z2)-(B2*Z1))/((B1^2)+(B2^2));
    C2= ((B1*Z1)+(B2*Z2))/((B1^2)+(B2^2));
    theta2(2) =atan2(S2,C2);
    
    th2d(2) = theta2(2)*180/pi;
    
    % Computation of theta 2.3
    Z1 = PX*cos(theta1(2)) + PY*sin(theta1(2));
    B1=X+(Y*cos(theta3(3)));
    B2= Y*sin(theta3(3));
    S2= ((B1*Z2)-(B2*Z1))/((B1^2)+(B2^2));
    C2= ((B1*Z1)+(B2*Z2))/((B1^2)+(B2^2));
    theta2(3)=atan2(S2,C2);
    
    th2d(3) = theta2(3)*180/pi;
    
    % Computation of theta 2.4
    Z1 = PX*cos(theta1(2)) + PY*sin(theta1(2));
    B1=X+(Y*cos(theta3(4)));
    B2= Y*sin(theta3(4));
    S2= ((B1*Z2)-(B2*Z1))/((B1^2)+(B2^2));
    C2= ((B1*Z1)+(B2*Z2))/((B1^2)+(B2^2));
    theta2(4)=atan2(S2,C2);
    
    th2d(4) = theta2(4)*180/pi;
    
    % Join solutions
    act = [actual1 actual2 actual3];
    sol(1,:) = [th1d(1) th2d(1) th3d(1)];
    sol(2,:) = [th1d(2) th2d(2) th3d(2)];
    sol(3,:) = [th1d(3) th2d(3) th3d(3)];
    sol(4,:) = [th1d(4) th2d(4) th3d(4)];
    x = sol;
    
    for n=1:4
        sorted(n) = norm(sol(n,1:3)- act(1:3));
    end
    [out, idx] = sort(sorted, "ascend");
    
else
    x =  [];
    idx = [];    
end
end
