function plot_1D(angle_arr,delta_cep)
%plot the cep change
%aver_smooth = ones(1, 5)/5;
% cep_smooth_s= filter(aver_smooth, 1, delta_cep(1,:));
% cep_smooth_p= filter(aver_smooth, 1, delta_cep(2,:));
%plot(angle_arr.*180./pi,[cep_smooth_s;cep_smooth_p])
figure
delta_cep(delta_cep<0)=delta_cep(delta_cep<0)+2*pi;
delta_cep=unwrap(delta_cep);
hold on
plot(angle_arr.*180./pi,unwrap(delta_cep).*180/pi)
legend('s','p')
xlim([-91,91])
xlabel('incidence angle')
% figure
% plot(angle_arr.*180./pi,unwrap(delta_cep(2,:)-delta_cep(1,:)).*180/pi)
end