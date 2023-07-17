function [d_scan1,d_scan2]=d1d2_define(C,meps_wsm)

eps_v=meps_wsm(1,1)-abs(meps_wsm(1,3))^2/meps_wsm(1,1);
eps_r=real(meps_wsm(1,1));
n_iter=imag(meps_wsm(1,3));
%---------------------------------------------------------
%define layer parameters, number, thickness
%---------------------------------------------------------
%define the thickness of each layer;
d_1_limit=max(abs(C.lambda0/imag(sqrt(eps_v))),abs(C.lambda0/real(sqrt(eps_v))));
% if n_iter<(2*abs(eps_r))
% d_1_limit=1*d_1_limit;
% elseif n_iter<(2.5*abs(eps_r))
% d_1_limit=0.25*d_1_limit;
% elseif n_iter<(3.5*abs(eps_r))
% d_1_limit=0.05*d_1_limit;
% else
% d_1_limit=0.01*d_1_limit;
% end
%thickness of the layers
% d_1_limit=1e-6;
% d_scan1=linspace(5e-9,2*d_1_limit,100);                 %wsm
% d_scan2=5e-6:(C.lambda0/C.n_die)/400:7e-6; 
% if imag(meps_wsm(1,1))>0.005
%     d_scan2=1e-9:(C.lambda0/C.n_die)/100:5e-6; 
% else
%     d_scan2=2e-6:(C.lambda0/C.n_die)/400:6e-6; 
% end
% d_scan1=linspace(0,d_1_limit/2, 100);
% d_scan2=linspace(0,2*C.lambda0/1.5,100);


%eps=9+0.3i eps_xz=12
d_scan2=3.24e-6;
d_scan1=1.0e-6;
% d_scan1=2e-6;
% d_scan2=3.2e-6;
%no eps_xz
%   d_scan1=3e-6;%linspace(2.5e-6,3e-6,5);    
%  d_scan2=1.067e-6;%0.8e-6:(C.lambda0/C.n_die)/50:1.5e-6; 
%for spin paper
% d_scan1=0.2*10e-6/(pi);
%  d_scan2=0;

%eps=-9+0.3i eps_xz=5
%  d_scan1=1.33e-6;
%  d_scan2=3.1e-6;

end