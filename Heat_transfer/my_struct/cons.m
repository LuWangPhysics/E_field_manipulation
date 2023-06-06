function C=cons(lambda_0,dz)
C=struct;
C.dz=dz;
C.lambda0=lambda_0;
C.k0=2*pi/C.lambda0;

C.kb=1.38064852e-23;
C.e=1.60217662e-19;
C.hbar=1.0545718e-34;
C.c=3e8;
C.mu0= 1.25663706212e-6;
C.eps0=8.8541878128e-12; 
C.c=1/sqrt(C.mu0*C.eps0);
C.n_die=1.5;
C.w0=C.c*C.k0;
end