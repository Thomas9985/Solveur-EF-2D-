function [points,weights] = quadrature(number)
    if number == 1
        points = [1,0;0,1;0,0];
        a = 1/6;
        weights = [a,a,a];
    elseif number == 3
        points = [1,0;0,1;0,0;1/2,1/2;0,1/2;1/2,0;1/3,1.0/3];
        weights = [1/40,1/40,1/40,1/15,1/15,1/15,9/40];
    else
        points =[];
        weights =[];
    end
end
