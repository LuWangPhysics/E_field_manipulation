classdef my_plot
properties
    xx;
    yy;
    savename;
    save_flag;
    norm_c;
    p_range;
end
methods
   
    function obj=init(obj,xx,yy,name,flag,C,x_range)
        obj.p_range=x_range;
        obj.xx=xx;
        obj.yy=yy;
        obj.savename=name;
        obj.save_flag=flag;
        obj.norm_c=C.lambda0*C.w0.^4/C.c^3/C.eps0;
    end

    function obj=S_each(obj,S,C,z_iter)
        cellname={'sx','sy','sz'};
        cell_vec={S.sx(:,:,z_iter),S.sy(:,:,z_iter),S.sz(:,:,z_iter)};
       
        figure
        for iter_n=1:3
            subplot(1,3,iter_n)
            h=surf(obj.xx./C.lambda0,obj.yy./C.lambda0,abs(cell_vec{iter_n})./obj.norm_c)
            set(h,'linestyle','none')
            xlabel('x/\lambda_0')
            ylabel('y/\lambda_0')
            title(cellname{iter_n})
            grid off
            view(2)
            colormap jet
        end

         if obj.save_flag==1
             filename=[obj.savename '/S_xyz_' num2str(floor(z_iter)) ]; 
             saveas(gcf,[filename '.fig'])
            
         end

    end

    function obj=flux(obj,S,C,z_iter)
        d_n=10;
        s_xy=sqrt(S.sx(:,:,z_iter).^2+S.sy(:,:,z_iter).^2)./obj.norm_c;
        s_xyz=sqrt(S.sx(:,:,z_iter).^2+S.sy(:,:,z_iter).^2+S.sz(:,:,z_iter).^2)./obj.norm_c;
        
        figure
        h=pcolor(obj.xx./C.lambda0,obj.yy./C.lambda0,s_xyz./max(max(s_xyz)));        
        set(h,'linestyle','none')
        colormap jet
        hold on
        q=quiver(obj.xx(1:d_n:end,1:d_n:end)./C.lambda0,obj.yy(1:d_n:end,1:d_n:end)./C.lambda0,S.sx(1:d_n:end,1:d_n:end,z_iter),S.sy(1:d_n:end,1:d_n:end,z_iter),'w')
        set(q,'LineWidth',0.75);
%         set(q,'linestyle','none')
        axis equal
        hold off
        xlabel('x/\lambda_0')
        ylabel('y/\lambda_0')
        title('S_{xyz}, normalized')
        if obj.save_flag==1
            filename=[obj.savename '/S_xyz_' num2str(floor(z_iter))  ]; 
            saveas(gcf,[filename '.fig'])
           
        end

    end

    function obj=r(obj,rsp,rpp,C)
        cellname={'r_{ps}','r_{pp}'};
        cell_vec={rsp,rpp};
        figure
        for iter_n=1:2
            subplot(1,2,iter_n)
            h=surf(obj.xx./C.lambda0,obj.yy./C.lambda0,abs(cell_vec{iter_n}).^2)
            set(h,'linestyle','none')
            xlabel('x/\lambda_0')
            ylabel('y/\lambda_0')
            title(cellname{iter_n})
            xlim([- obj.p_range, obj.p_range])
            ylim([- obj.p_range, obj.p_range])
            grid off
            view(2)
  
        end
         if obj.save_flag==1
             filename=[obj.savename '/R'  ]; 
             saveas(gcf,[filename '.fig'])
         
         end
    
    end

    function obj=S_3D_quiver(obj,S,C,z_arr)
        %---------------------------------------
        %quiver 3D
        %---------------------------------------
          d_n=10;
          xplot=zeros([size(obj.xx(1:d_n:end,1:d_n:end)),length(z_arr)]);
          yplot=zeros([size(obj.xx(1:d_n:end,1:d_n:end)),length(z_arr)]);
          zplot=zeros([size(obj.xx(1:d_n:end,1:d_n:end)),length(z_arr)]); 
          for z_iter=1:length(z_arr)
             xplot(:,:,z_iter)=obj.xx(1:d_n:end,1:d_n:end)./C.lambda0;
             yplot(:,:,z_iter)=obj.yy(1:d_n:end,1:d_n:end)./C.lambda0;
             zplot(:,:,z_iter)=ones(size(obj.xx(1:d_n:end,1:d_n:end))).*z_arr(z_iter)./C.lambda0;
          end
        s_total=1+0*sqrt(S.sx(1:d_n:end,1:d_n:end,:).^2+S.sy(1:d_n:end,1:d_n:end,:).^2+S.sz(1:d_n:end,1:d_n:end,:).^2);
        sx=S.sx(1:d_n:end,1:d_n:end,:)./s_total;
        sy=S.sy(1:d_n:end,1:d_n:end,:)./s_total;
        sz=S.sz(1:d_n:end,1:d_n:end,:)./s_total;
        figure  
        q=quiver3(xplot,yplot,zplot,sx,sy,sz);
            xlim([- obj.p_range, obj.p_range])
            ylim([- obj.p_range, obj.p_range])
        set(q,'LineWidth',1.2);
       % axis equal
        if obj.save_flag==1
             filename=[obj.savename '/S_3D_vector'  ]; 
             saveas(gcf,[filename '.fig'])
        end
    end
    function obj=S_3D(obj,S,C,z_arr)
        %---------------------------------------
        %Sz surfaces 3D
        %---------------------------------------  
%         interval=(z_arr(end)-z_arr(end-1))./C.lambda0;
%          s_total=sqrt(S.sx.^2+S.sy.^2+S.sz.^2);
%         Amp=interval;
%         figure
%         for iter_n=1:length(z_arr)
%             szplot=Amp.*S.sz(:,:,iter_n)./max(max(s_total(:,:,iter_n)));
%             shift=0*z_arr(iter_n)./C.lambda0;
%             subplot(1,length(z_arr),iter_n)
%             h=surf(obj.xx./C.lambda0,obj.yy./C.lambda0,szplot+shift)
%             set(h,'linestyle','none')
%             xlabel('x/\lambda_0')
%             ylabel('y/\lambda_0')
%             %h.CData=h.CData-shift;
%             %c_low=min(min(szplot+shift));
%            % caxis([-Amp,Amp])
%             grid off
%            % hold on
%           
%         end
%          hold off
%          title('Sz_layer')
%          if obj.save_flag==1
%              filename=[obj.savename '/Sz_layer'  ]; 
%              saveas(gcf,[filename '.fig'])
%          end
        %---------------------------------------
        %S_total
        %---------------------------------------
          d_n=1;
          xplot=zeros([size(obj.xx(1:d_n:end,1:d_n:end)),length(z_arr)]);
          yplot=zeros([size(obj.xx(1:d_n:end,1:d_n:end)),length(z_arr)]);
          zplot=zeros([size(obj.xx(1:d_n:end,1:d_n:end)),length(z_arr)]); 
          s_total=zeros(size(zplot));
          for z_iter=1:length(z_arr)
             xplot(:,:,z_iter)=obj.xx(1:d_n:end,1:d_n:end)./C.lambda0;
             yplot(:,:,z_iter)=obj.yy(1:d_n:end,1:d_n:end)./C.lambda0;
             zplot(:,:,z_iter)=ones(size(obj.xx(1:d_n:end,1:d_n:end))).*z_arr(z_iter)./C.lambda0;
             temp= sqrt(S.sx(1:d_n:end,1:d_n:end,z_iter).^2+S.sy(1:d_n:end,1:d_n:end,z_iter).^2+S.sz(1:d_n:end,1:d_n:end,z_iter).^2);
             s_total(:,:,z_iter)=temp./max(max(temp));
          end
   
         figure
         scatter3(xplot(:),yplot(:),zplot(:),10,s_total(:),'fill')
         grid off
         colormap(jet)
            xlim([- obj.p_range, obj.p_range])
            ylim([- obj.p_range, obj.p_range])
        xlabel('x/\lambda_0')
        ylabel('y/\lambda_0')

    end


end
end