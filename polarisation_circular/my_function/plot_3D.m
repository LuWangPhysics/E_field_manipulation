function plot_3D(t,tau,Es_o,Ep_o,angle_chosen)
figure
box on
view(45,30)
%plot projection
hold on
plot3(t./tau,(max(abs(real(Es_o)))*1.3)*ones(size(Es_o)), real(Ep_o), 'LineWidth', 1,'Color','k'); % project in x-z axis at y=100
hold on
plot3(t./tau, real(Es_o), (min(real(Ep_o))*1.3)*ones(size(Ep_o)), 'LineWidth', 1,'Color','k'); % project in y-z axis at z=-2
hold on
plot3(t./tau,Es_o,Ep_o,"LineWidth",3,'Color','b')
% hold on
% hold on
% plot3(t.*1e15,(max(abs(Es_o))*1.3)*ones(size(Es_o)), abs(Ep_o), 'LineWidth', 1,'Color','k')
%plot3((t(1)*1e15-2)*ones(size(t)), Ex,Ey, 'LineWidth', 1,'Color','r'); % project in y-z axis at x=2
% plot3(t.*1e15, abs(Es_o), (min(real(Ep_o))*1.3)*ones(size(Ep_o)), 'LineWidth', 1,'Color','k');

xlabel ("t/\tau");
ylabel ("Es");
ylim([(min(real(Es_o))*1.3),(max(abs(real(Es_o)))*1.3)])
zlabel ("Ep");
zlim([(min(real(Ep_o))*1.3),(max(abs(real(Ep_o)))*1.3)])
%zlim([-1.3,1])
title(['incidence angle=\,',num2str(angle_chosen*180/pi,2)])
end