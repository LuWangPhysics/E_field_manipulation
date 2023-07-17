addpath('/Users/luwang1/Documents/postdoc2/ICFO_postdoc2/projects/codes/Nonreciprocal_E_field_manipulation/Heat_transfer/my_plot_scheme');
addpath('/Users/luwang1/Documents/postdoc2/ICFO_postdoc2/projects/codes/Nonreciprocal_E_field_manipulation/Heat_transfer/my_plot_scheme/print_file');
clear all

lambda=10e-6;
k0=2*pi/lambda;
c=3e8;
%in the paper
%sigma=lambda;
sigma=2*lambda;
x=linspace(-25*sigma,25*sigma,2001);
dx=x(2)-x(1);
kx = 2*pi*(-(length(x)-1)/(2*length(x).*dx):1/(length(x)*dx):(length(x)-1)/(2*length(x)*dx));
dkx=kx(2)-kx(1);

phase_quadratic=exp(-1i*(x./(sigma/2)).^2);
E_x=exp(-(x./sigma).^2);
E_kx=fftshift(fft(ifftshift(E_x)))./(length(kx)*dkx/sqrt(2*pi));
E_kx_quad=fftshift(fft(ifftshift(E_x.*phase_quadratic)))./(length(kx)*dkx/sqrt(2*pi));
%--------------------------------
%add reflection
%--------------------------------
E_angle=kx./k0;

eps_d=1.5+0.3i;
eps_xz=1.5i;
epsv=eps_d-abs(eps_xz)^2/eps_d;
kz1=sqrt(epsv*k0^2-kx.^2);
kz0=sqrt(k0^2-kx.^2);
r_match=(kz0*epsv-kz1+kx.*eps_xz./eps_d)./(kz0*epsv+kz1-kx.*eps_xz./eps_d);
filter=exp(-(kx./k0).^8);

E_x_flat=fftshift(ifft(ifftshift(filter.*E_kx.*r_match))).*(length(kx)*dkx/(sqrt(2*pi)));
E_x_quad=fftshift(ifft(ifftshift(filter.*E_kx_quad.*r_match))).*(length(kx)*dkx/(sqrt(2*pi)));

figure
plot(kx./k0,abs(E_kx))
hold on
plot(kx./k0,abs(E_kx_quad))
xlim([-3,3])
legend('flat','quad')
xlabel('kx/k0')
figure
plot(x./sigma,abs(E_x))
hold on
plot(x./sigma,abs(E_x_flat))
hold on
plot(x./sigma,abs(E_x_quad))
xlim([-2.5,2.5])
legend('in','out flat','out quad')
xlabel('x/\sigma')
% figure
% plot(kx./k0,abs(E_kx))
% hold on
% plot(kx./k0,real(E_kx))
% xlabel('k_x/k_0')
