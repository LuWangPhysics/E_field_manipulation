lambda=10e-6;
k0=2*pi/lambda;
kx=linspace(-3*k0,3*k0,10000);
eps_d=1.5+0.3i;
eps_xz=1.5i;
epsv=eps_d-abs(eps_xz)^2/eps_d;
kz1=sqrt(epsv*k0^2-kx.^2);
kz0=sqrt(k0^2-kx.^2);
r=(kz0*epsv-kz1+kx.*eps_xz./eps_d)./(kz0*epsv+kz1-kx.*eps_xz./eps_d);
figure
plot(kx./k0,[real(r);imag(r)])