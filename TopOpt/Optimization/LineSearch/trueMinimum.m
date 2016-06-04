%% True minimum linesearch
%
% Code developed by Ghislain Raze under the supervision of Prof. Joseph
% Morlier
%
% Initial code by Johannes T. B. Overvelde
%
% <http://www.overvelde.com>
%

function  [xs,fs,gs] = trueMinimum(x0,f0,g0,x1,objfun)


    iterMax = 100;
    minimum = false;
    iter = 0;
    tol = 1e-3;
    s0 = (x1-x0)/norm(x1-x0);
    
    [f1,g1] = objfun(x1);
    
    gp0 = g0'*s0;
    gp1 = g1'*s0;
    g00 = norm(g0);
    
    while ~minimum && iter < iterMax
        
        iter = iter+1;
        
        ls = cubicApproximation(0,norm(x1-x0),f0,f1,gp0,gp1);
        
        xs = x0+ls*s0;
        [fs,gs] = objfun(xs);
        gps = gs'*s0;
        
        if abs(gps/g00) > tol
            if norm(x1-xs) > norm(xs-x0)
                x0 = xs;
                f0 = fs;
                gp0 = gps;
            else
                x1 = xs;
                f1 = fs;
                gp1 = gps;
            end
        else
            minimum = true;
        end
    end
end