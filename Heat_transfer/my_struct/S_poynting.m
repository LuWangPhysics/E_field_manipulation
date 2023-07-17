classdef S_poynting
  properties
    sx;
    sy;
    sz;
   

end
methods
    
    function obj=init(obj,xx,z_arr)
        obj.sx=zeros([size(xx),length(z_arr)]);
        obj.sy=zeros([size(xx),length(z_arr)]);
        obj.sz=zeros([size(xx),length(z_arr)]);
    end
    function obj=S_calculate(obj,EH,z_iter)
            
            Ex=EH.Ex0+EH.Exr;
            Ey=EH.Ey0+EH.Eyr;
            Ez=EH.Ez0+EH.Ezr;
            
            obj.sx(:,:,z_iter)=real(Ey.*conj(EH.Hz)-Ez.*conj(EH.Hy))./2;
            obj.sy(:,:,z_iter)=-real(Ex.*conj(EH.Hz)-Ez.*conj(EH.Hx))./2;
            obj.sz(:,:,z_iter)=real(Ex.*conj(EH.Hy)-Ey.*conj(EH.Hx))./2;
    end
end
end