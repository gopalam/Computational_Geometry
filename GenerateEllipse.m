function  [ETRI]=GenerateEllipse(abc,n)

% abc =[ a b c]; % semi major lengths, x, y and z directions respectively
% n= number of points, 
% given characteristic parameters, generate a meshed ellipse
% ------
% Author: Gopal Mulukutla
% e-mail: gopal.mulukutla@unh.edu
% Created: 2017,    using MATLAB Version: 9.2.0.538062 (R2017a)
% Copyright Gopal Mulukutla.


cx=0; cy=0; cz=0; % center of ellipse
 xl=abc(1);yl=abc(2);zl=abc(3); % semi major lengths, x, y and z directions
[x,y,z]=ellipsoid(cx,cy,cz,xl,yl,zl,n);
 xe=reshape(x,(n+1)*(n+1),1);
ye=reshape(y,(n+1)*(n+1),1);
ze=reshape(z,(n+1)*(n+1),1);
 xyze=[xe ye ze];
de = DelaunayTri(xyze(:,1),xyze(:,2),xyze(:,3)); 
 [tri Xb] = freeBoundary(de);
ETRI = TriRep(tri, Xb);
% trimesh(ETRI);axis equal;
end
