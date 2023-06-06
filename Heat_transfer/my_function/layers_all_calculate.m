function [M,Rot]=layers_all_calculate(Rot,C,theta_arr_n,n_iter,eps_r,eps_i,rotate_n,d)

                        kx=Rot.n1*C.k0*sin(theta_arr_n);
                        ky=0;
        %equivalent decomposition of k compared to rotate the m matrix
%                          theta_rot=-0*pi/2.7;
%                          kx=Rot.n1*C.k0*sin(theta_arr_n)*cos(theta_rot);
%                          ky=Rot.n1*C.k0*sin(theta_arr_n)*sin(theta_rot);
        
                        %get the rotation matrix for the in and out layer
                        Rot=Rot.Rot_sp_To_xyz(theta_arr_n,C);  
                        M=eye(4,4);
                        for n_k=2:C.number_of_interface
                            meps=material_select(n_k,C,n_iter,eps_r,eps_i,rotate_n);
                            M_layer=M_matrix(meps,kx,ky,C,d(n_k-1));
                            M=M_layer*M;
            
                        end
end