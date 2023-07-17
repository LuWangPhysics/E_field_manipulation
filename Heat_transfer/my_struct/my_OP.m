classdef my_OP
properties

end
methods       

       function e_x=fft2_kxtox(obj,phi_ir,k_vector)
        e_x=fftshift(ifft2(ifftshift(phi_ir))).*(length(k_vector.kx)*k_vector.dkx/(2*pi)).*(length(k_vector.ky)*k_vector.dky/(2*pi));
        end

        function e_kx=fft2_xtokx(obj,phi_ir,k_vector)
        e_kx=fftshift(fft2(ifftshift(phi_ir)))./(length(k_vector.kx)*k_vector.dkx/(2*pi))./(length(k_vector.ky)*k_vector.dky/(2*pi));
        end
end
end