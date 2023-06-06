classdef XY_to_angles
    properties
       %define the sin, cos values of theta, phi and the reflected ones
      phi_x;
      phi_y;
      theta_sin;
      theta_cos;
      r_phi_x;
      r_phi_y;
      r_theta_sin;
      theta_in;
      r_theta_cos;
      r_phi_rotate;
      
      r;
      r_r;
       z0;
       zp;
       Ex0;Ey0;Ez0;Exr;Eyr;Ezr;
       Hx;Hy;Hz;
    end

    methods 
        function obj=init(obj,xx,yy,z0,zp)
            %both z0 and zp are >0
            obj.z0=z0;
            obj.zp=zp;
            %efield original 
            [obj.Ex0,obj.Ey0,obj.Ez0]=deal(zeros(size(xx)));
            %efield reflected
            [obj.Exr,obj.Eyr,obj.Ezr]=deal(zeros(size(xx)));
            %h field total
            [obj.Hx,obj.Hy,obj.Hz]=deal(zeros(size(xx)));
            
            obj.r=sqrt(xx.^2+yy.^2+(zp-z0).^2);
            obj.r_r=sqrt(xx.^2+yy.^2+(zp+z0).^2);

            obj.phi_x=xx./obj.r;
            obj.phi_y=yy./obj.r;
            obj.theta_sin=sqrt(xx.^2+yy.^2)./obj.r;
            obj.theta_cos=(zp-z0)./obj.r;

            obj.r_phi_x=xx./obj.r_r;
            obj.r_phi_y=yy./obj.r_r;
            obj.r_theta_sin=sqrt(xx.^2+yy.^2)./obj.r_r;
            obj.r_theta_cos=(zp+z0)./obj.r_r;
            %the rotatin angle about z in radius
            obj.r_phi_rotate=acos(obj.r_phi_x./obj.r_theta_sin);
            %reconstruct the rotation angle to [0,2pi], the acos only return to [0,pi];
            obj=obj.pi2_cali(yy);
            %r_sin(theta) is the incidence angle for calculating refelction
            obj.theta_in=asin(obj.r_theta_sin);
        end

        function obj=E_H(obj,ref_c,x_iter,y_iter,C)
             %sin(theta)cos(phi)
             phix= obj.phi_x(y_iter,x_iter);
             %sin(theta)sin(phi)
             phiy=obj.phi_y(y_iter,x_iter);
             theta_s=obj.theta_sin(y_iter,x_iter);
             theta_c=obj.theta_cos(y_iter,x_iter);

             rphi_x=obj.r_phi_x(y_iter,x_iter);
             %sin(theta_r)sin(phi)
             rphi_y=obj.r_phi_y(y_iter,x_iter);
             rtheta_s=obj.r_theta_sin(y_iter,x_iter);
             rtheta_c=obj.r_theta_cos(y_iter,x_iter);

             g0=exp(1i.*C.k0.*obj.r(y_iter,x_iter))./(4*pi*obj.r(y_iter,x_iter));
             gr=exp(1i.*C.k0.*obj.r_r(y_iter,x_iter))./(4*pi*obj.r_r(y_iter,x_iter));
             coef=C.w0^2*C.mu0*C.dz;
             obj.Ex0(y_iter,x_iter)=-coef.*g0.*phix.*theta_c;
             obj.Ey0(y_iter,x_iter)=-coef.*g0.*phiy.*theta_c;
             obj.Ez0(y_iter,x_iter)=coef.*g0.*theta_s.^2;
                
             obj.Exr(y_iter,x_iter)=coef.*gr.*(-ref_c.r(4)*rphi_x*rtheta_c+ref_c.r(3).*rphi_y);
             obj.Eyr(y_iter,x_iter)=coef.*gr.*(-ref_c.r(4)*rphi_y*rtheta_c-ref_c.r(3).*rphi_x);
             obj.Ezr(y_iter,x_iter)=coef.*gr.*ref_c.r(4)*rtheta_s^2;

             obj.Hx(y_iter,x_iter)=(phiy* obj.Ez0(y_iter,x_iter)- theta_c*obj.Ey0(y_iter,x_iter)...
                 +rphi_y* obj.Ezr(y_iter,x_iter)- rtheta_c*obj.Eyr(y_iter,x_iter))/(C.c*C.mu0);
             obj.Hy(y_iter,x_iter)=-(phix* obj.Ez0(y_iter,x_iter)- theta_c*obj.Ex0(y_iter,x_iter)...
                 +rphi_x* obj.Ezr(y_iter,x_iter)- rtheta_c*obj.Exr(y_iter,x_iter))/(C.c*C.mu0);
             obj.Hz(y_iter,x_iter)=(phix* obj.Ey0(y_iter,x_iter)- phiy*obj.Ex0(y_iter,x_iter)...
                 +rphi_x* obj.Eyr(y_iter,x_iter)- rphi_y*obj.Exr(y_iter,x_iter))/(C.c*C.mu0);
            
        end
      
        function obj=pi2_cali(obj,yy)
           obj.r_phi_rotate(yy<0)=2*pi-obj.r_phi_rotate(yy<0);
        end

    end
end