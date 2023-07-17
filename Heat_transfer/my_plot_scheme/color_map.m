function cmap=color_map(c_min,c_max,flag)
N_c=2000;
cmap=ones(N_c,3);
switch flag
    case 1
        %poetic red and blue, center white
        n_blue=fix(N_c*abs(c_min)/(abs(c_min)+abs(c_max)));

        %blue
        cmap(1:n_blue,1:2)=[linspace(0,1,n_blue)',linspace(0,1,n_blue)'];

        %red
        cmap(n_blue+1:end,2:3)=[linspace(1,0,N_c-n_blue)',linspace(1,0,N_c-n_blue)'];


    case 2
        %red yello cyan blue center white
        cmap=zeros(N_c,3);
        n_blue=fix(N_c*abs(c_min)/(abs(c_min)+abs(c_max)));

        %blue
         cmap(1:fix(n_blue/2),2:3)=[linspace(0,1,fix(n_blue/2))',ones(fix(n_blue/2),1)];
        %cyan
         cmap((fix(n_blue/2)+1):n_blue,1)=linspace(0,1,length((fix(n_blue/2)+1):n_blue))';
         cmap((fix(n_blue/2)+1):n_blue,2)=ones(length((fix(n_blue/2)+1):n_blue),1);
         cmap((fix(n_blue/2)+1):n_blue,3)=ones(length((fix(n_blue/2)+1):n_blue),1);
         % yellow
         sec_r=fix(N_c/2+n_blue/2);
         cmap(n_blue+1:sec_r,1)=ones(sec_r-n_blue,1);
         cmap(n_blue+1:sec_r,2)=ones(sec_r-n_blue,1);
         cmap(n_blue+1:sec_r,3)=linspace(1,0,sec_r-n_blue)';

         % %red
         cmap(sec_r:end,1)=ones((N_c-sec_r+1),1);
         cmap(sec_r:end,2)=linspace(1,0,(N_c-sec_r+1))';
      
    case 3
         %red yello cyan blue center black
          cmap=zeros(N_c,3);
          n_blue=N_c;

        %blue
         cmap(1:fix(n_blue/2),2:3)=[linspace(0,1,fix(n_blue/2))',ones(fix(n_blue/2),1)];
        %cyan
         cmap((fix(n_blue/2)+1):n_blue,2)=linspace(1,0,length((fix(n_blue/2)+1):n_blue))';
         cmap((fix(n_blue/2)+1):n_blue,3)=linspace(1,0,length((fix(n_blue/2)+1):n_blue))';
         % yellow
         sec_r=fix(N_c/2+n_blue/2);
         cmap(n_blue+1:sec_r,1)=linspace(0,1,sec_r-n_blue)';
         cmap(n_blue+1:sec_r,2)=linspace(0,1,sec_r-n_blue)';

         % %red
         cmap(sec_r:end,1)=ones((N_c-sec_r+1),1);
         cmap(sec_r:end,2)=linspace(1,0,(N_c-sec_r+1))';

         case 4
     
        cmap=ones(N_c,3);
        N=N_c;%fix(N_c*abs(c_min)/(abs(c_min)+abs(c_max)));
     
        white=[1,1,1];
        dark_blue=[0 102  204]./255;
        light_blue=[0.3010 0.7450 0.9330];
        green=[0 1 0];
        yellow=[1 1 0];
        orange=[255  153 0]./255;
        red=[1 0 0];
        black=[0,0,0];
        dark_red=[54.5, 0, 0]./255;
        myc={dark_blue,dark_blue,light_blue,light_blue,green,yellow,yellow,orange,orange,red...
            dark_red};
        n_sec=fix(N/length(myc));
        for n_iter=(1:fix(N/n_sec)-1)
         range=((n_iter-1)*n_sec+1):1:(n_iter*n_sec);
            for kk=1:1:3
                  cmap(range,kk)=linspace(myc{n_iter}(kk),myc{n_iter+1}(kk),n_sec);   
            end
      
        
        end
        %last color
      N_last=(N-n_sec-10):N;
      myc_last=black;
      for kk=1:1:3
                  cmap(N_last,kk)=linspace(myc{end}(kk),myc_last(kk),length(N_last)); 
       end
   
    
         
         
end
end