function M=M_matrix(eps,kx,ky,C,d)
M=zeros(4,4);
%worked version for the M when ky=0
M(1,:)=[-kx*eps(3,1)/eps(3,3),-kx*eps(3,2)/eps(3,3),0,C.w0*C.mu0-kx^2/eps(3,3)/C.w0];
M(2,:)=[0,0,-C.w0*C.mu0,0];
M(3,:)=[-C.w0*eps(2,1)+C.w0*eps(2,3)*eps(3,1)/eps(3,3),kx^2/C.mu0/C.w0-eps(2,2)*C.w0+C.w0*eps(3,2)*eps(2,3)/eps(3,3)...
    0,kx*eps(2,3)/eps(3,3)];
M(4,:)=[C.w0*eps(1,1)-C.w0*eps(1,3)*eps(3,1)/eps(3,3),C.w0*eps(1,2)-C.w0*eps(3,2)*eps(1,3)/eps(3,3)...
    0,-kx*eps(1,3)/eps(3,3)];
% 
% M(1,:)=[-kx*eps(3,1)/eps(3,3),-kx*eps(3,2)/eps(3,3),1i*kx*ky/(C.w0*eps(3,3)),C.w0*C.mu0-kx^2/eps(3,3)/C.w0];
% M(2,:)=[-ky*eps(3,1)/eps(3,3),-ky*eps(3,2)/eps(3,3),-C.w0*C.mu0+ky^2/(C.w0*eps(3,3)),-kx*ky/(C.w0*eps(3,3))];
% M(3,:)=[-kx*ky/(C.w0*C.mu0)-C.w0*eps(2,1)+C.w0*eps(2,3)*eps(3,1)/eps(3,3),kx^2/C.mu0/C.w0-eps(2,2)*C.w0+C.w0*eps(3,2)*eps(2,3)/eps(3,3),...
%     -ky*eps(2,3)/eps(3,3),kx*eps(2,3)/eps(3,3)];
% M(4,:)=[-ky^2/(C.w0*C.mu0)+C.w0*eps(1,1)-C.w0*eps(1,3)*eps(3,1)/eps(3,3),kx*ky/(C.w0*C.mu0)+C.w0*eps(1,2)-C.w0*eps(3,2)*eps(1,3)/eps(3,3),...
%    ky*eps(1,3)/eps(3,3),-kx*eps(1,3)/eps(3,3)];

%the d is negative because propagating to the negative direction
M=expm(-M*1i*d);

%compare with the analytical solutions of the exp matrix
% eps_normal=eps./C.eps0;
% epsv=eps_normal(1,1)-abs(eps_normal(1,3))^2/eps_normal(1,1);
% kzs=sqrt(eps_normal(1,1)*C.k0^2-kx^2);
% kzp=sqrt(epsv*C.k0^2-kx^2);
% P=zeros(4,4);
% P(1,1)=cos(-d*kzp)-1i*eps(1,3)*kx*sin(-d*kzp)/eps(1,1)/kzp;
% P(2,2)=cos(-d*kzs);
end