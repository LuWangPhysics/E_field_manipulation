function cep=find_cep(E,t,w)
%-----------------------------------------------------------
%CEP defined by really the distance of E field and envelope
%-----------------------------------------------------------
% E_env=abs(E);
% p_env=find(E_env==max(E_env));
% p_field=find(abs(real(E))==max(abs(real(E))));
% 
% dt=t(2)-t(1);
% 
% cep=(p_env(1)-p_field(1))*dt*w*180/pi;

%-----------------------------------------------------------
%CEP defined by relative phase difference to the envelope peak
%-----------------------------------------------------------
E_env=abs(E);
p_env=find(E_env==max(E_env));

cep=angle(E(p_env));

end