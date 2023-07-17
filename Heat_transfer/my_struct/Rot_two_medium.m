classdef Rot_two_medium
    properties
        n1;
        n2;
        R1;
        R2;
        theta1;
        theta2;
       
    end

    methods 
        function obj=init(obj,case_name)
                obj.n1=1;
                switch case_name
                    case "R"
                    obj.n2=500000i;                   
                    case "T"
                     obj.n2=obj.n1;
                end
        end

        function obj=Rot_sp_To_xyz(obj,angle,C)
            eta=sqrt(C.eps0/C.mu0);
            obj.theta1=angle;
            %this is only for homogeneous material with refractive index n 
            Rot=@(theta, n) [0,cos(theta),0,-cos(theta);...
             1,0,1,0;...
             n*eta*cos(theta),0,-n*eta*cos(theta),0;...
             0,-n*eta,0,-n*eta];
          %Alexsandra consistent with the paper
%              Rot = @(theta, n) [0,-cos(theta),0,cos(theta);...
%             1,0,1,0;...
%             n*eta*cos(theta),0,-n*eta*cos(theta),0;...
%             0,n*eta,0,n*eta];

            obj.R1= Rot(abs(angle),obj.n1);
            obj.theta2=asin(obj.n1*sin(abs(angle))/obj.n2);            
            obj.R2= Rot(obj.theta2,obj.n2);
            
        end
    end
end