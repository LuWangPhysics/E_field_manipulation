clear all;
addpath('my_struct');
addpath('my_function');
addpath('my_plot_scheme');
addpath('my_plot_scheme/print_file');

Rot=Rot_two_medium;
%choose reflection or transmission geometry "R" or "T"
Rot=Rot.init("T");

lambda0=10e-6;
dz=1;
C=cons(lambda0,dz);  



%create a mesh point for the entire space
rangex=75;
rangey=75;
% rangex=22;
% rangey=22;
x=linspace(-rangex*C.lambda0,rangex*C.lambda0,200);
%y is the vertical dimension, i.e the fist tensor index
y=linspace(-rangey*C.lambda0,rangey*C.lambda0,201);

E_gaussian_xy=exp(-(0.1*x./C.lambda0).^2).*exp(-(0.1*y'./C.lambda0).^2);




%extend the mesh points to 2D
[xx,yy]=meshgrid(x,y);


%---------------------------------------------------------
%data store remeber to change according to angle array
%---------------------------------------------------------
delta_ignore=1e-6;

eps_r=1.5;
eps_xz=1.5;
eps_i=0.3;
meps_wsm=material_select(2,C,eps_xz,eps_r,eps_i,0)./C.eps0;

%---------------------------------------------------------
%define plot scan variables
%---------------------------------------------------------
rpp=zeros(size(xx));
rps=zeros(size(xx));
d=[40e-6,0*3.2e-6];

z0=25*C.lambda0;
%need to avoid the z0 point
z_obs_arr=[0.1].*C.lambda0;
%z_obs_arr=[0.1,1.5,3].*C.lambda0;%
%z_obs_arr=[10,20,30].*C.lambda0;
%initialize the poynting vector mat
S=S_poynting;
S=S.init(xx,z_obs_arr);

filename=['my_output/V_epsxx_imag' num2str(imag(meps_wsm(1,1))) 'epsxx_real' num2str(real(meps_wsm(1,1)),'%2.2f') ...
    '_d1_' num2str(d(1).*1e6,'%2.2f'),'_d2_' num2str(d(2)*1e6,'%2.2f')...
    'z0' num2str(z0.*1e6,'%2.2f') ];
if ~exist(filename, 'dir')
       mkdir(filename);
end
P=my_plot;
P=P.init(xx,yy,filename,1,C,rangex);


for z_iter=1:length(z_obs_arr)
z_obs=z_obs_arr(z_iter);
%initialize the angle mat
A_mat=XY_to_angles;
A_mat=A_mat.init(xx,yy,z0,z_obs);
  for x_iter=1:length(x)
      for y_iter=1:length(y)
         
           
             C.number_of_interface=1+length(d);
             theta=A_mat.theta_in(y_iter,x_iter);
             theta_rotate=A_mat.r_phi_rotate(y_iter,x_iter); 
             [M,Rot]=layers_all_calculate(Rot,C,theta,eps_xz,eps_r,eps_i,theta_rotate,d);
        
             ref_c=r_s_process(M,Rot,delta_ignore);  
             A_mat=A_mat.E_H(ref_c,x_iter,y_iter,C);
             rpp(y_iter,x_iter)=ref_c.r(4);
             rps(y_iter,x_iter)=ref_c.r(3);
      end
  end
S=S.S_calculate(A_mat,z_iter);
%---------------------------------------------------------
%plots each z
%---------------------------------------------------------
P.S_each(S,C,z_iter);
P.flux(S,C,z_iter);
P.r(rps,rpp,C);
end
%---------------------------------------------------------
%plots 3D
%---------------------------------------------------------

%3D vector for z_arr
%P.S_3D_quiver(S,C,z_obs_arr);
P.S_3D(S,C,z_obs_arr);