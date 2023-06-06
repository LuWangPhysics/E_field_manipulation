clear all
%close all
addpath('my_function/')
lambda=10e-6;
c=3e8;
w=c*2*pi/lambda;

t=linspace(-2*2*pi/w,2*2*pi/w,2001);
tau=5/w;
%---------------------------------------------
%change parameters for the other polarization
%---------------------------------------------
%initial input
env=exp(-t.^2./tau^2);
Es=exp(1i*w.*t).*env;
Phi=1*pi/2;
Ep=exp(1i*w.*t+1i*Phi).*env;


data_mat=load("r_45degree.mat");
angle_mat=load("r_45degree_angle.mat");
rmat=data_mat.r_mat;
angle_arr=angle_mat.a;
angle_chosen=20*pi/180;
angle_p=find(abs(angle_arr-angle_chosen)==min(abs(angle_arr-angle_chosen)));
delta_cep=zeros(2,length(angle_arr));

for n_iter=1:1:length(angle_arr)
Es_o=rmat(1,n_iter)*Es+rmat(3,n_iter)*Ep;
Ep_o=rmat(4,n_iter)*Ep+rmat(2,n_iter)*Es;
delta_cep(:,n_iter)=[find_cep(Es_o,t,w),find_cep(Ep_o,t,w)];

    if n_iter==angle_p
        r=rmat(:,n_iter);
    end


end
%------------------------------------------------
%plot CEP
%------------------------------------------------
plot_1D(angle_arr,delta_cep)
%------------------------------------------------
%plot the selected point circularly polarized light
%------------------------------------------------
 % ["ss"    "sp"    "ps"    "pp"]
%initial incidence
%r=[1,0,0,1];
Es_o=r(1)*Es+r(3)*Ep;
Ep_o=r(4)*Ep+r(2)*Es;
plot_3D(t,tau,Es_o,Ep_o,angle_chosen)