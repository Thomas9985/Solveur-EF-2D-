function [vals,dervals] = shape_fcts(xh,k)
    if k == 1
        vals = [xh(1),xh(2),1-xh(2)-xh(1)];
        dervals = [1,0,-1;0,1,-1];
    elseif k == 2
        vals = [xh(1)*(2*xh(1)-1),xh(2)*(2*xh(2)-1),(1-xh(2)-xh(1))*(2*(1-xh(2)-xh(1))-1),4*xh(1)*xh(2),4*xh(2)*(1-xh(2)-xh(1)),4*xh(1)*(1-xh(2)-xh(1))];
        dervals = zeros(2,6);
        dervals(1,1) = 4 * xh(1) - 1;
        dervals(2,1) = 0;
        dervals(1,2) = 0;
        dervals(2,2) = 4 * xh(2) - 1;
        dervals(1,3) = -4 * (1 - xh(1) - xh(2)) + 1;
        dervals(2,3) = -4 * (1 - xh(1) - xh(2)) + 1;
        dervals(1,4) = 4 * xh(2);
        dervals(2,4) = 4 * xh(1);
        dervals(1,5) = -4 * xh(2);
        dervals(2,5) = 4 * (1 - xh(1) - 2*xh(2));
        dervals(1,6) = 4 * (1 - 2 * xh(1) - xh(2));
        dervals(2,6) = -4 * xh(1);
    end
end
