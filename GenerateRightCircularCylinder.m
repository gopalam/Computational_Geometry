%Generate a series of Right Circular Cylinders defined with height and radius R=1
# each geometry is stored as a Tri mesh file ( one of the old-fashioned matlab geometries)
% Define, H==> height of Cylinder

H=4;
for i=1:10
 
A = meshgrid(linspace(0, 2*pi, 60), linspace(0, 2*pi, 60)) ;
R=1;
X = R .* cos(A);
Y = R .* sin(A);
H=H+1;

chr=['Cylinder_','R',num2str(1),'_H',num2str(H)];

Z = meshgrid(linspace(-1, 1, 60), linspace(-1, 1, 60))';

de = DelaunayTri(X(:),Y(:),Z(:));
[tri Xb] = freeBoundary(de);
ETRI = TriRep(tri, Xb);
trimesh(ETRI);axis equal;
pause(3);
close all;

assignin('base',chr,ETRI) ;  

end
