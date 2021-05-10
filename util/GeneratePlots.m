function GeneratePlots( n, xt , yt , xcoord , ycoord , r , cons, fig_c)

figure(fig_c)
%pause(0.2)
hold off
plot(xt, yt,'LineWidth',2) % polygon
axis equal
bufferx = 0.1*(max(xt)-min(xt));
buffery = 0.1*(max(yt)-min(yt));
xlim([min(xt)-bufferx,max(xt)+bufferx])
ylim([min(yt)-buffery,max(yt)+buffery])
text(min(xt)-0.5*bufferx,min(yt)-0.5*buffery,strcat('r=',num2str(r)))
hold on

for j = 1:n
    [xc, yc] = circle([xcoord(j)  ycoord(j)], r , 1000);
    plot(xc, yc, 'k')
    plot(xcoord(j),ycoord(j),'k.')
    hold on
end
if ~isempty(cons)
    for i = 1:length(cons(:,1))
        con = cons(i,:);
        plot([xcoord(con(1)), xcoord(con(2))], [ycoord(con(1)), ycoord(con(2))])
        text((xcoord(con(1))+xcoord(con(2)))/2,(ycoord(con(1))+ycoord(con(2)))/2,...
            {'\leftarrow', sprintf('%.2f<= %.2f <=%.2f',con(3),norm([xcoord(con(1))-xcoord(con(2)), ycoord(con(1))-ycoord(con(2))]),con(4))})
        drawnow
    end
end
title(sprintf('%d-Dispersion Results', n))
end