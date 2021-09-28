function TRI= GenTri(theta,phi,anm,N)
% given theta and phi discretization, generate a tri model for a given
% number of spherical harmonics N
sz=size(theta);
for i=1:sz(1)
    for j=1:sz(2)
        th=theta(i,j);
            ph=phi(i,j);
            Rsum=0;
        for n=0:N
            %get the Ynm data
            Ymn=Y_l(n,th,ph);
            m=n;
            ind=find(anm(:,1)== n );
            % real part of Anm
        % for Anm use only the real part- refer to this paper, shows no difference reconstruction with real or imaginary
% 3D characterization of general-shape sand particles using microfocus  X-ray computed tomography and spherical harmonic functions, and 
% particle regeneration using multivariate random vector % by Su D. , YanW.M. 

            Anm_r=anm(ind,3);
            % complex part of Anm
%             Anm_c=anm(ind,4);
        len= length(Ymn);
        Y_mn=zeros(len,2);
        % read the real and imaginary parts
        %real(Y_n) gives negative harmonics -n=<m<0 
        %  imag(Y_n) gives positive harmonics 0<m<=l
        Y_mn=[];
        for k=1:len
            Y_mn(k,1)=real(Ymn(k));
            Y_mn(k,2)=imag(Ymn(k));
        end
        Y_mn=Y_mn(find(Y_mn));
         Rsum=Rsum+sum(Anm_r.*Y_mn);
        end
        R(i,j)=Rsum;
    end
end
% convert R values to x, y and z.

x=[];
y=[];
z=[];

for p=1:sz(1)     
    for q=1:sz(2)
   
        x(p,q)=R(p,q)*sin(theta(p,q))*cos(phi(p,q));
        y(p,q)=R(p,q)*sin(theta(p,q))*sin(phi(p,q));
        z(p,q)=R(p,q)*cos(theta(p,q));
    end
end
x=reshape(x,[sz(1)*sz(2),1]);        
y=reshape(y,[sz(1)*sz(2),1]);
z=reshape(z,[sz(1)*sz(2),1]);

dt = DelaunayTri(x,y,z);
 [tri Xb] = freeBoundary(dt);
TRI = TriRep(tri, Xb);
% P = incenters(TRI);
% fn = faceNormals(TRI);
%   figure(2), trimesh(TRI);axis equal;

end
