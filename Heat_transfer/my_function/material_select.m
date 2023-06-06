function [meps]=material_select(number,C,eps_xz,eps_r,eps_i,rotate_n)
res=number-2;%mod(number,2);
phi_1=rotate_n;
phi_2=0;
phi_3=0;
        %numbers represent incidence Quadrant
        %2 rotate about z axis 180 degree to get the -kx part (theta negative part)
        %3 rotate about x to get the incidence from below part
        %4 rotate about x and z to get below -kx


%--------------------------------------
%rotate about z axis
%--------------------------------------
euler_z=[cos(phi_1),sin(phi_1),0;...
        -sin(phi_1),cos(phi_1),0;...
        0,0,1];
%--------------------------------------
%rotate about x' axis, the the new x,after first rotate
%--------------------------------------
euler_xp=[1,0,0;...
     0,cos(phi_2),sin(phi_2);...
      0, -sin(phi_2),cos(phi_2)];
%--------------------------------------
%rotate about z'' axis, the new z after twice rotate
%--------------------------------------
euler_zpp=[cos(phi_3),sin(phi_3),0;...
        -sin(phi_3),cos(phi_3),0;...
        0,0,1];

euler_R=euler_zpp*euler_xp*euler_z;

switch res

    case 0
       %Enhanced nonreciprocal radiation in Weyl semimetals by attenuated total reflection
       % doi: 10.1063/5.0055418 data for WSM
       dia=eps_r+eps_i*1i;
       off_dia=eps_xz*1i;
%--------------------------------------
       %voigt
%--------------------------------------
        meps=C.eps0.*[dia,0,off_dia;...
                    0,  dia,  0; ...
                  -off_dia,0, dia];  
%--------------------------------------
       %Faraday
 %--------------------------------------
%         meps=C.eps0.*[dia,off_dia,0;...
%                       -off_dia,  dia,  0; ...
%                     0,0, dia];  
    
    
        meps=euler_R*meps/(euler_R);

     case 1
        meps=C.eps0.*[C.n_die,0,0;...
             0,C.n_die,0;...
            0,0,C.n_die].^2;
        

      case 2
          %mirror n is a large imaginary number
          n_value=-500^2;
          meps=C.eps0.*[n_value,0,0;...
            0,n_value,0;...
            0,0,n_value];

    otherwise
        fprintf("no material defined. make sure layer agrees with material number")
end



end